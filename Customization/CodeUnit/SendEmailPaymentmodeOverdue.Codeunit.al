codeunit 73209609 "Send Email Paymentmode Overdue"
{
    procedure SendEmailOverdue(Rec: Record "BLROverDuePaymentmode"): Text;
    var
        CompanyInfo: Record "Company Information";
        PaymentMode: Record "BLRPaymentMode"; // Add Payment Mode record variable
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        EmailAddress: Text[250]; // Variable to store the email address
    begin
        // Find matching Payment Mode record by Tenant ID
        PaymentMode.Reset();
        PaymentMode.SetRange("BLRTenant Id", Rec."BLRTenant Id");
        PaymentMode.SetRange("BLRContract ID", Rec."BLRContract ID");

        if PaymentMode.FindFirst() then begin
            EmailAddress := PaymentMode."BLRTenant Email";

            if EmailAddress = '' then
                Error('Email address not found for Tenant ID: %1', Rec."BLRTenant Id");

        end else
            Error('Payment Mode record not found for Tenant ID: %1', Rec."BLRTenant Id");

        if CompanyInfo.Get() then begin
            EmailMessage.Create(
                EmailAddress,
                'Payment Mode Details - ' + Format(Rec."BLRContract ID"),
                '<html><body>' +
                '<p>Dear ' + Rec."BLRTenant Name" + ',</p>' +
                '<p>I hope this message finds you well. This is a kind reminder that your payment for (Rent/Charges) is Overdue.</p>' +
                '<h3>Details of the Payment:</h3>' +
                '<b>Contract ID:</b> ' + Format(Rec."BLRContract ID") + '<br/>' +
                '<b>Payment ID:</b> ' + Rec."BLRPayment Series" + '<br/>' +
                '<b>Due Date:</b> ' + Format(Rec."BLRDue Date", 0, '<Day,2>-<Month,2>-<Year4>') + '<br/>' +
                '<b>Payment Status:</b> ' + Format(Rec."BLRPayment Status") + '</p>' +
                '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +
                '</body></html>',
                true
            );

            // Send the email
            if Email.Send(EmailMessage) then
                Message('Email sent successfully for Payment Mode: %1', EmailAddress)
            else
                Error('Failed to send email. Please verify SMTP settings and email addresses.');
        end;
    end;

}