codeunit 73209619 "BLRSendTenantMail"
{
    procedure SendEmailToTenant(Rec: Record "BLRContractEndProcessApproval"): Text;
    var
        CompanyInfo: Record "Company Information";
        TenancyRec: Record "BLRTenancyContract";
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        RemainingDays: Integer;
    begin
        RemainingDays := Rec."BLREnd Date" - Today;
        if Rec."BLRProperty_M Status" = 'Approved' then
            if CompanyInfo.Get() then begin
                EmailMessage.Create(
                    Rec."BLRTenant Email",
                    'Contract Renewal Confirmation : Contract ID - ' + Format(Rec."BLRContract Id"),
                    '<html><body>' +
                    '<p>Dear ' + Rec."BLRTenant Name" + ',</p>' +
                     '<p>I hope this email finds you well. This is a kind reminder that your contract with Contract ID - ' +
            Format(Rec."BLRContract Id") +
            ' is set to expire in the next <b>' +
            Format(RemainingDays) +
            ' days</b>. To ensure continuity, we would like to know if you are interested in renewing your contract.</p>' +
                    '<p>Please let us know your decision at your earliest convenience so we can proceed accordingly. If you have any questions or require assistance, feel free to reach out to us.</p>' +
                    '<p>Looking forward to your response.</p>' +
                    '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +
                    '</body></html>',
                    true
                );
                if Email.Send(EmailMessage) then begin
                    Message('Email sent successfully for Contract Renewal Confirmation: %1', Rec."BLRTenant Email");
                    if TenancyRec.Get(Rec."BLRContract Id") then begin
                        TenancyRec."BLRRenewal Contract Status" := TenancyRec."BLRRenewal Contract Status"::"Notify Tenant For Renewal";
                        TenancyRec.Modify();
                    end;
                end else
                    Error('Failed to send email. Please verify SMTP settings and email addresses.');
            end;
    end;
}