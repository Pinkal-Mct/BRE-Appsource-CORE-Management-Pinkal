codeunit 73209620 "Tenant Loyalty Reminder"
{
    Subtype = Normal;
    trigger OnRun()
    begin
        ProcessLoyaltyReminders();
    end;

    local procedure ProcessLoyaltyReminders()
    var
        TenantContract: Record "BLRTenancyContract";
        ContractEndApproval: Record "BLRContractEndProcessApproval";
        UserPersonalizationRec: Record "User Personalization";
        CompanyInfo: Record "Company Information";
        UserRec: Record User;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit "Email";
        ReminderDays: Integer;
        ReminderTargetDate: Date;
        Today: Date;
        EmailBody: Text;
        EmailList: List of [Text];
        LeaseManagerName: Text;
    begin
        Today := Today();
        if TenantContract.FindSet() then
            repeat
                ReminderDays := TenantContract."BLRTenantLoyaltyCheckReminder";
                if (ReminderDays > 0) and (TenantContract."BLRContract End Date" <> 0D) then begin
                    ReminderTargetDate := TenantContract."BLRContract End Date" - ReminderDays;
                    if Today = ReminderTargetDate then
                        if TenantContract."BLRTenant Contract Status" = TenantContract."BLRTenant Contract Status"::Active then begin
                            ContractEndApproval.Init();
                            ContractEndApproval."BLRContract Id" := TenantContract."BLRContract ID";
                            ContractEndApproval."BLRTenant Id" := TenantContract."BLRTenant ID";
                            ContractEndApproval."BLRTenant Name" := TenantContract."BLRCustomer Name";
                            ContractEndApproval."BLRLease_M Status" := 'Pending';
                            ContractEndApproval."BLRProperty_M Status" := 'Pending';
                            ContractEndApproval."BLRStart Date" := TenantContract."BLRContract Start Date";
                            ContractEndApproval."BLREnd Date" := TenantContract."BLRContract End Date";
                            ContractEndApproval."BLRTenant Email" := TenantContract."BLREmail Address";
                            ContractEndApproval."BLRRenewalNotiftoTenant" := TenantContract."BLRRenewalNotiftoTenant";
                            ContractEndApproval.Insert();
                            Clear(ContractEndApproval);
                            LeaseManagerName := '';
                            UserPersonalizationRec.SetRange("Profile ID", 'LEASE MANAGER');
                            if UserPersonalizationRec.FindSet() then
                                repeat
                                    if UserRec.Get(UserPersonalizationRec."User SID") then
                                        if UserRec."Contact Email" <> '' then begin
                                            EmailList.Add(UserRec."Contact Email");
                                            if LeaseManagerName = '' then
                                                LeaseManagerName := UserRec."User Name"
                                            else
                                                LeaseManagerName += ', ' + UserRec."User Name";
                                        end;
                                until UserPersonalizationRec.Next() = 0;
                            if EmailList.Count = 0 then
                                Error('No valid email addresses found for LEASE MANAGER.');
                            if CompanyInfo.Get() then begin
                                EmailBody :=
                                      '<html><body>' +
                                      '<p>Dear Lease Manager,</p>' +
                                      '<p>This is an automated notification from the system.</p>' +
                                      '<p>This is a reminder that <b>Contract ID: ' + Format(TenantContract."BLRContract ID") +
                                      '</b> has <b>' + Format(ReminderDays) + ' days remaining</b>. Please verify and approve the request for contract renewal.</p>' +
                                      '<p>Please review the <b>Contract End Process Approval List</b> and take the necessary action as required.</p>' +
                                      '<h3><u>Contract Details:</u></h3>' +
                                      '<b>Contract Start Date:</b> ' + Format(TenantContract."BLRContract Start Date", 0, '<Day>/<Month>/<Year4>') + '<br/>' +
                                      '<b>Contract End Date:</b> ' + Format(TenantContract."BLRContract End Date", 0, '<Day>/<Month>/<Year4>') + '<br/>' +
                                      '<b>Status:</b> Active<br/><br/>' +
                                      '<p>Best regards,<br/>' + CompanyInfo.Name +
                                       '</body></html>';
                                EmailMessage.Create(
                                    EmailList,
                                    'Reminder: Tenant Contract Ending Soon',
                                    EmailBody,
                                    true
                                );
                                if not Email.Send(EmailMessage) then
                                    Error('Email failed to send. Please check SMTP settings.');
                            end;
                        end;
                end;
            until TenantContract.Next() = 0;
    end;
}
