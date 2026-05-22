codeunit 73209582 "Contract End Status Updater"
{
    Subtype = Normal;
    trigger OnRun()
    begin
        UpdateStatusesOnContractEnd();
    end;

    local procedure UpdateStatusesOnContractEnd()
    var
        TenancyRec: Record "BLRTenancyContract";
        RenewalRec: Record "BLRContractRenewal";
    begin
        if TenancyRec.FindSet() then
            repeat
                if (TenancyRec."BLRTenant Contract Status" = TenancyRec."BLRTenant Contract Status"::"Active-Contract Renewed") and
                   (TenancyRec."BLRContract End Date" <= Today()) then begin
                    TenancyRec."BLRTenant Contract Status" := TenancyRec."BLRTenant Contract Status"::"Contract Renewed";
                    TenancyRec.Modify();
                    RenewalRec.SetRange("BLRContract ID", TenancyRec."BLRContract ID");
                    if RenewalRec.FindSet() then
                        repeat
                            RenewalRec."BLRContract Status" := RenewalRec."BLRContract Status"::Active;
                            RenewalRec.Modify();
                            TenancyRec.Reset();
                            TenancyRec.SetRange("BLRRenewal Proposal ID", RenewalRec."BLRId");
                            if TenancyRec.FindSet() then
                                repeat
                                    TenancyRec."BLRTenant Contract Status" := TenancyRec."BLRTenant Contract Status"::Active;
                                    TenancyRec.Modify();
                                until TenancyRec.Next() = 0;
                        until RenewalRec.Next() = 0;
                end;
            until TenancyRec.Next() = 0;
    end;
}
