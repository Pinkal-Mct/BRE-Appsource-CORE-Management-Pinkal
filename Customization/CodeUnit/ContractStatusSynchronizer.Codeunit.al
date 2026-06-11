codeunit 73209586 "BLRContractStatusSynchronizer"
{
    procedure SyncToTenancyContract(ContractStatusRec: Record "BLRApprovalContractStatus")
    var
        TenancyContract: Record "BLRTenancyContract";
    begin
        TenancyContract.Reset();
        TenancyContract.SetRange("BLRContract ID", ContractStatusRec."BLRContract ID");
        if not TenancyContract.FindFirst() then begin
            Message('No Tenancy Contract found for Contract ID %1', ContractStatusRec."BLRContract ID");
            exit;
        end;
        if ContractStatusRec."BLRStatus" = 'Approved' then begin
            case ContractStatusRec."BLRTenancy Contract Status" of
                'Activation':
                    begin
                        TenancyContract."BLRPrevious Status" := Format(TenancyContract."BLRTenant Contract Status");
                        TenancyContract.Validate("BLRTenant Contract Status", TenancyContract."BLRTenant Contract Status"::Active);
                    end;
                'Termination':
                    begin
                        TenancyContract."BLRPrevious Status" := Format(TenancyContract."BLRTenant Contract Status");
                        TenancyContract.Validate("BLRTenant Contract Status", TenancyContract."BLRTenant Contract Status"::Terminated);
                    end;
                'Suspension':
                    begin
                        TenancyContract."BLRPrevious Status" := Format(TenancyContract."BLRTenant Contract Status");
                        TenancyContract.Validate("BLRTenant Contract Status", TenancyContract."BLRTenant Contract Status"::Suspended);
                    end;
                'Under Suspension-Unit Release':
                    begin
                        TenancyContract."BLRPrevious Status" := Format(TenancyContract."BLRTenant Contract Status");
                        TenancyContract.Validate("BLRTenant Contract Status", TenancyContract."BLRTenant Contract Status"::"Under Suspension-Unit Released");
                    end;
                else
                    Message('Unsupported Tenancy Contract Status: %1', ContractStatusRec."BLRTenancy Contract Status");
            end;
            TenancyContract."BLRUpdate Contract Status" := TenancyContract."BLRUpdate Contract Status"::" ";
            TenancyContract.Modify();
        end;
        if ContractStatusRec."BLRStatus" = 'Declined' then begin
            TenancyContract."BLRUpdate Contract Status" := TenancyContract."BLRUpdate Contract Status"::" ";
            TenancyContract.Modify();
        end;
    end;
}
