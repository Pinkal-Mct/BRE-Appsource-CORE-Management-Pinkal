codeunit 73209584 "BLRContract Renewal Request"
{
    [EventSubscriber(ObjectType::Table, Database::"BLRContractRenewal", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyTenancyContract(var Rec: Record "BLRContractRenewal"; xRec: Record "BLRContractRenewal"; RunTrigger: Boolean)
    var
        ApprovalStatusList: Record "BLRApprovalContractStatus";
        UserPersonalizationRec: Record "User Personalization";
        CompanyInfo: Record "Company Information";
        UserRec: Record User;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit "Email";
        EmailList: List of [Text];
        LeaseManagerName: Text;
        TenancyContractStatus: Text;
        EmailBody: Text;
    begin
        if Rec."BLRApproval For Renewal" <> xRec."BLRApproval For Renewal" then begin
            ApprovalStatusList.Init();
            ApprovalStatusList."BLRContract ID" := 0;
            ApprovalStatusList."BLRStatus" := 'Pending';
            ApprovalStatusList."BLRRenewal Contract ID" := Rec."BLRId";
            ApprovalStatusList."BLRLease ID" := Rec."BLRCreated By";
            TenancyContractStatus := GetTenancyStatusFromUpdateStatus(Format(Rec."BLRApproval For Renewal"));
            ApprovalStatusList."BLRTenancy Contract Status" := CopyStr(TenancyContractStatus, 1, StrLen(TenancyContractStatus));
            ApprovalStatusList.Insert();
            LeaseManagerName := '';
            UserPersonalizationRec.SetRange("Profile ID", 'PROPERTY MANAGER');
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
                Error('No valid email addresses found for PROPERTY MANAGER.');
            if CompanyInfo.Get() then begin
                EmailBody :=
                        '<html><body>' +
                        '<p>Dear Property Manager,</p>' +
                        '<p>This is an automated notification from the system.</p>' +
                        '<p>A recent update has been made to the Contract Renewal with <b>Renewal Contract ID - ' + Format(Rec."BLRId") + '</b>.</p>' +
                        '<p>Please review the <b>Approval Contract Status List</b> and take the necessary action as required.</p>' +
                        '<p>To proceed, please log in to the system and review the pending status under the <b>Approval Contract Status List</b> section.</p>' +
                        '<p>This is a system-generated email. Please do not reply to this message.</p>' +
                        '<p>Thank you,</p>' +
                        '</body></html>';
                EmailMessage.Create(
                    EmailList,
                    'System Notification: Action Required - Review Approval Contract Renewal Status For Approval - Contract ID - ' + Format(Rec."BLRContract ID"),
                    EmailBody,
                    true
                );
                if not Email.Send(EmailMessage) then
                    Error('Email failed to send. Please check SMTP settings.');
            end;
        end;
    end;

    local procedure GetTenancyStatusFromUpdateStatus(UpdateStatus: Text): Text
    begin
        case UpdateStatus of
            'Request For Renewal':
                exit('Contract Renewal');
            else
                exit('Unknown');
        end;
    end;
}
