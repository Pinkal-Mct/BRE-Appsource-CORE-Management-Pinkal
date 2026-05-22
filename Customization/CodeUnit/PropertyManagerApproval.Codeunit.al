codeunit 73209598 "Property Manager Approval"
{
    procedure UpdateContractStatus(var Rec: Record "BLRTenancyContract"; NewStatus: Option)
    var
        xRec: Record "BLRTenancyContract";
    begin
        xRec := Rec;
        if Rec."BLRUpdate Contract Status" <> NewStatus then begin
            Rec."BLRUpdate Contract Status" := NewStatus;
            Rec.Modify(true);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"BLRTenancyContract", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyTenancyContract(var Rec: Record "BLRTenancyContract"; xRec: Record "BLRTenancyContract"; RunTrigger: Boolean)
    begin
        if Rec."BLRUpdate Contract Status" <> xRec."BLRUpdate Contract Status" then
            HandleContractStatusUpdate(Rec);
    end;

    procedure HandleContractStatusUpdate(Rec: Record "BLRTenancyContract")
    var
        ApprovalStatusList: Record "BLRApprovalContractStatus";
        UserPersonalizationRec: Record "User Personalization";
        UserRec: Record User;
        CompanyInfo: Record "Company Information";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit "Email";
        EmailList: List of [Text];
        LeaseManagerName: Text;
        EmailBody: Text;
        EmailSubject: Text;
        StatusText: Text;
    begin
        StatusText := GetTenancyStatusFromUpdateStatus(Format(Rec."BLRUpdate Contract Status"));
        ApprovalStatusList.Init();
        ApprovalStatusList."BLRContract ID" := Rec."BLRContract ID";
        ApprovalStatusList."BLRStatus" := 'Pending';
        ApprovalStatusList."BLRRenewal Contract ID" := 0;
        ApprovalStatusList."BLRLease ID" := Rec."BLRCreated By";
        ApprovalStatusList."BLRTenancy Contract Status" := CopyStr(StatusText, 1, StrLen(StatusText));
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
            case StatusText of
                'Activation':
                    EmailSubject := 'Review Approval Contract Status For Activation - Contract ID - ' + Format(Rec."BLRContract ID");
                'Termination':
                    EmailSubject := 'Review Approval Contract Status For Termination - Contract ID - ' + Format(Rec."BLRContract ID");
                'Suspension':
                    EmailSubject := 'Review Approval Contract Status For Suspension - Contract ID - ' + Format(Rec."BLRContract ID");
                'Suspended-Unit Released':
                    EmailSubject := 'Review Approval Contract Status For Suspension - Contract ID - ' + Format(Rec."BLRContract ID");
                else
                    EmailSubject := 'Review Approval Contract Status - Contract ID - ' + Format(Rec."BLRContract ID");
            end;
            EmailBody :=
                '<html><body>' +
                '<p>Dear Property Manager,</p>' +
                '<p>This is an automated notification from the system.</p>' +
                '<p>A recent update has been made to the tenancy contract with <b>Contract ID: ' + Format(Rec."BLRContract ID") + '</b>.</p>' +
                '<p>Please review the <b>Approval Contract Status List</b> and take the necessary action as required.</p>' +
                '<p>To proceed, please log in to the system and review the pending status under the <b>Approval Contract Status List</b> section.</p>' +
                '<p>This is a system-generated email. Please do not reply to this message.</p>' +
                '<p>Thank you,</p>' +
                '</body></html>';
            EmailMessage.Create(
                EmailList,
                EmailSubject,
                EmailBody,
                true
            );
            if not Email.Send(EmailMessage) then
                Error('Email failed to send. Please check SMTP settings.');
        end;
    end;

    local procedure GetTenancyStatusFromUpdateStatus(UpdateStatus: Text): Text
    begin
        case UpdateStatus of
            'Initiate Activation Process':
                exit('Activation');
            'Initiate Termination Process':
                exit('Termination');
            'Initiate Suspension Process':
                exit('Suspension');
            'Initiate Under Suspension-Unit Released':
                exit('Suspended-Unit Released');
            else
                exit('Unknown');
        end;
    end;
}
