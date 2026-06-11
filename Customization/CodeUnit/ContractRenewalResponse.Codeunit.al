codeunit 73209585 "BLRContract Renewal Response"
{
    procedure SyncToTenancyContractRenewal(ContractStatusRec: Record "BLRApprovalContractStatus")
    var
        ContractRenewal: Record "BLRContractRenewal";
        RenewalHandler: Codeunit "BLRContract Renewal Response";
    begin
        ContractRenewal.Reset();
        ContractRenewal.SetRange("BLRId", ContractStatusRec."BLRRenewal Contract ID");
        if not ContractRenewal.FindFirst() then begin
            Message('No Contract Renewal found for Contract ID %1', ContractStatusRec."BLRRenewal Contract ID");
            exit;
        end;
        if ContractStatusRec."BLRStatus" = 'Approved' then
            case ContractStatusRec."BLRTenancy Contract Status" of
                'Contract Renewal':
                    begin
                        ContractRenewal."BLRRenewal Contract Status" := ContractRenewal."BLRRenewal Contract Status"::"Renewal of Original Contract ID";
                        ContractRenewal."BLRApproval For Renewal" := ContractRenewal."BLRApproval For Renewal"::" ";
                        ContractRenewal."BLROriginal Contract ID" := Format(ContractRenewal."BLRContract ID");
                        ContractRenewal.Modify();
                        RenewalHandler.ProcessContractRenewal(ContractRenewal);
                    end;
                else
                    Message('Unsupported Tenancy Contract Status: %1', ContractStatusRec."BLRTenancy Contract Status");
            end;
        if ContractStatusRec."BLRStatus" = 'Declined' then begin
            ContractRenewal."BLRApproval For Renewal" := ContractRenewal."BLRApproval For Renewal"::" ";
            ContractRenewal.Modify();
        end;
    end;

    procedure ProcessContractRenewal(RenewalRec: Record "BLRContractRenewal")
    var
        TenancyContractRec: Record "BLRTenancyContract";
        EmailRec: Codeunit "BLRSend Contract Renewal Email";
        ContractIDInt: Integer;
    begin
        if RenewalRec."BLRRenewal Contract Status" = RenewalRec."BLRRenewal Contract Status"::"Renewal of Original Contract ID" then
            if Evaluate(ContractIDInt, RenewalRec."BLROriginal Contract ID") then begin
                TenancyContractRec.SetRange("BLRContract ID", ContractIDInt);
                if TenancyContractRec.FindFirst() then begin
                    TenancyContractRec."BLRTenant Contract Status" :=
                        TenancyContractRec."BLRTenant Contract Status"::"Active-Contract Renewed";
                    TenancyContractRec.Modify();
                    Message('Tenancy Contract ID %1 updated to "Active-Contract Renewed".', ContractIDInt);
                end else
                    Error('No Tenancy Contract found with Contract ID %1.', ContractIDInt);
                EmailRec.SendEmail(RenewalRec);
            end else
                Error('Failed to convert Original Contract ID "%1" to Integer.', RenewalRec."BLROriginal Contract ID");
    end;
}
