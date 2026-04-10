codeunit 50510 "SendApprovalToFinanceManager"
{
    procedure SendPaymentModeApprovalToFinanceManger(PaymentTransactionId: Code[50]; TenantId: Code[20]; ContractId: Integer; IsUpdate: Boolean)
    var
        UserRec: Record User;
        UserPersonalizationRec: Record "User Personalization";
        CompanyInfo: Record "Company Information";
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        EmailBody: Text;
        FinanceManagerFullName: Text;
        EmailAddress: List of [Text];
        CCMail: List of [Text];
        BCCMail: List of [Text];
    begin
        UserPersonalizationRec.SetRange("Profile ID", 'FINANCE MANAGER');
        if UserPersonalizationRec.FindSet() then
            repeat
                if UserRec.Get(UserPersonalizationRec."User SID") then begin
                    EmailAddress.Add(UserRec."Contact Email");
                    FinanceManagerFullName := UserRec."User Name";
                end else
                    Error('Finance Manager user not found.');
            until UserPersonalizationRec.Next() = 0
        else
            Error('No user with Profile ID "FINANCE MANAGER" found.');
        if CompanyInfo.Get() then begin
            if IsUpdate then
                EmailBody := ComposeUpdatedEmailBody(PaymentTransactionId, TenantId, ContractId)
            else
                EmailBody := ComposeNewEmailBody(PaymentTransactionId, TenantId, ContractId);
        end else
            if IsUpdate then
                EmailBody := ComposeUpdatedEmailBody(PaymentTransactionId, TenantId, ContractId)
            else
                EmailBody := ComposeNewEmailBody(PaymentTransactionId, TenantId, ContractId);
        EmailMessage.Create(EmailAddress, 'Payment Transaction Approval Required', EmailBody, true, CCMail, BCCMail);
        EmailMessage.SetBodyHTMLFormatted(true);
        if Email.Send(EmailMessage) then
            Message('Approval email sent successfully.')
        else
            Error('Failed to send approval email.');
    end;

    procedure ComposeNewEmailBody(PaymentTransactionId: Text; TenantId: Text; ContractId: Integer): Text
    var
        EnvInformation: Codeunit "Environment Information";
        AzureADTenant: Codeunit "Azure AD Tenant";
        CompanyInfo: Record "Company Information";
        CompanyName: Text;
        EmailBody: Text;
        BCTenantID: Text;
        BCEnvName: Text;
        urlpage: Text;
    begin
        if CompanyInfo.Get() then
            CompanyName := CompanyInfo."Name";

        EmailBody :=
            '<p>Dear Finance Team,<br>' +
            'A new Payment Transaction has been created and requires your approval. Below are the transaction details:<br>' +
            '<table style="border: 1px solid black; border-collapse: collapse; width: 100%; text-align: left;">' +
            '<tr style="background-color: #f2f2f2;">' +
            '<th style="border: 1px solid black; padding: 8px;">Field</th>' +
            '<th style="border: 1px solid black; padding: 8px;">Value</th>' +
            '</tr>' +
            '<tr><td>Payment Mode ID</td><td>%1</td></tr>' +
            '<tr><td>Tenant ID</td><td>%2</td></tr>' +
            '<tr><td>Contract ID</td><td>%3</td></tr>' +
            '</table>' +
            '<br>' +
            'For any questions or concerns, feel free to contact the initiator of this transaction.<br>' +
            '<br>' +
            'Best regards,<br>' +
            CompanyName +
            // '[Your Name]<br>' +
            // '[Your Position]<br>' +
            // '[Company Name]'+
            '</p>';

        exit(StrSubstNo(EmailBody, PaymentTransactionId, TenantId, ContractId));
    end;


    procedure ComposeUpdatedEmailBody(PaymentTransactionId: Text; TenantId: Text; ContractId: Integer): Text
    var
        CompanyInfo: Record "Company Information";
        CompanyName: Text;
        EmailBody: Text;
    begin
        if CompanyInfo.Get() then
            CompanyName := CompanyInfo."Name";
        EmailBody :=
            '<p>Dear Finance Manager,<br>' +
            'We have updated the payment details as per the feedback. Kindly review and approve the revised entry for the <strong> contract ' + Format(ContractId) + '</strong> for further processing.<br>' +
            '<br>' +
            'Please review and provide your approval at your earliest convenience.<br>' +
            '<br>' +
            'Best regards,<br>' +
            CompanyName +
            '</p>';
        exit(StrSubstNo(EmailBody, ContractId, PaymentTransactionId));
    end;
}