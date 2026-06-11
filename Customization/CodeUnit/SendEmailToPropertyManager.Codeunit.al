codeunit 73209610 "BLRSendEmailToPropertyManager"
{
    procedure SendEmail(Rec: Record "BLRContractEndProcessApproval"): Text;
    var
        CompanyInfo: Record "Company Information";
        UserPersonalizationRec: Record "User Personalization";
        UserRec: Record User;
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        Username: Text;
        EmailAddress: List of [Text];
    begin
        UserPersonalizationRec.SetRange("Profile ID", 'PROPERTY MANAGER');
        if UserPersonalizationRec.FindSet() then
            repeat
                if UserRec.Get(UserPersonalizationRec."User SID") then
                    if UserRec."Contact Email" <> '' then
                        EmailAddress.Add(UserRec."Contact Email");
                Username := UserRec."User Name";
            until UserPersonalizationRec.Next() = 0
        else
            Error('No users found with PROFILE ID PROPERTY MANAGER.');

        if EmailAddress.Count = 0 then
            Error('No email addresses found for users with PROFILE ID PROPERTY MANAGER.');
        if Rec."BLRLease_M Status" = 'Approved' then
            if CompanyInfo.Get() then begin
                EmailMessage.Create(
                    EmailAddress,
                  'Contract Renewal Approved - ' + Format(Rec."BLRContract Id"),
                    '<html><body>' +
                    '<p>Dear ' + Username + ',</p>' +
                    '<p>The Leasing Team has approved Contract ID - <b>' + Format(Rec."BLRContract Id") + '</b> for renewal, and it has been successfully verified.</p>' +
                    '<p>Please verified and approved request for contract renewal.</p>' +
                    '<p>Please review the Contract End Process Approval List in Business central and take the necessary action as required.</p>' +
                    '<h3><u>Contract Details:</u></h3>' +
                    '<b>Contract ID:</b> ' + Format(Rec."BLRContract Id") + '<br/>' +
                    '<b>Tenant Name:</b> ' + Rec."BLRTenant Name" + '<br/>' +
                    '<b>Contract Start Date:</b> ' + Format(Rec."BLRStart Date", 0, '<Day>/<Month>/<Year4>') + '<br/>' +
                    '<b>Contract End Date:</b> ' + Format(Rec."BLREnd Date", 0, '<Day>/<Month>/<Year4>') + '<br/>' +
                    '<b>Status:</b> ' + Rec."BLRLease_M Status" + '<br/><br/>' +
                    '<p>Please review the details and proceed with the necessary steps.</p>' +
                    '<p>Best regards,<br/>' + CompanyInfo.Name + '<br/>Leasing Team</p>' +
                    '</body></html>',
                    true
                );
                if Email.Send(EmailMessage) then
                    Message('Email sent successfully to Property Manager for Verification.')
                else
                    Error('Failed to send email. Please verify SMTP settings and email addresses.');
            end;
    end;
}