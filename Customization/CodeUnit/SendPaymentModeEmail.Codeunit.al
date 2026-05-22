codeunit 73209614 "Send PaymentMode Email"
{
    procedure SendEmail(Rec: Record "BLRPaymentMode2"): Text;
    var
        CompanyInfo: Record "Company Information";
        PaymentMode: Record "BLRPaymentMode";
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        EmailAddress: Text[250];
    begin
        if Rec."BLRPayment Status" = Rec."BLRPayment Status"::Received then begin

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
                EmailMessage.Create(EmailAddress,
                                    'Payment Mode Details - ' + Format(Rec."BLRContract ID"),
                                    '<html><body>' +
                                    '<p>Dear ' + Rec."BLRTenant Name" + ',</p>' +
                                    '<p>I hope this message finds you well. We confirm the receipt of your payment towards Rent/Charges.</p>' +
                                    '<h3>Details of the Payment:</h3>' +
                                    '<b>Contract ID:</b> ' + Format(Rec."BLRContract ID") + '<br/>' +
                                    '<b>Payment ID:</b> ' + Rec."BLRPayment Series" + '<br/>' +
                                    '<b>Amount Including VAT:</b> ' + Format(Rec."BLRAmount Including VAT") + '<br/>' +
                                    '<b>Due Date:</b> ' + Format(Rec."BLRDue Date", 0, '<Day,2>-<Month,2>-<Year4>') + '<br/>' +
                                    '<b>Payment Mode:</b> ' + Rec."BLRPayment Mode" + '<br/>' +
                                    '<b>Payment Status:</b> ' + Format(Rec."BLRPayment Status") + '</p>' +
                                    '<p>Kindly review the information provided and let us know if you have any questions or need further clarification.</p>' +
                                    '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +
                                    '</body></html>',
                                    true);

                if Email.Send(EmailMessage) then
                    Message('Email sent successfully for Payment Mode: %1', EmailAddress)
                else
                    Error('Failed to send email. Please verify SMTP settings and email addresses.');
            end;
        end;
    end;

    procedure SendEmailCancelled(Rec: Record "BLRPaymentMode2"): Text;
    var
        CompanyInfo: Record "Company Information";
        PaymentMode: Record "BLRPaymentMode";
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        EmailAddress: Text[250];
    begin
        if Rec."BLRPayment Status" = Rec."BLRPayment Status"::Cancelled then begin
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
                EmailMessage.Create(EmailAddress,
                                    'Payment Mode Details - ' + Format(Rec."BLRContract ID"),
                                    '<html><body>' +
                                    '<p>Dear ' + Rec."BLRTenant Name" + ',</p>' +
                                    '<p>I hope this message finds you well. This is to inform you that your payment towards Rent/Charges is Cancelled.</p>' +
                                    '<h3>Details of the Payment:</h3>' +
                                    '<b>Contract ID:</b> ' + Format(Rec."BLRContract ID") + '<br/>' +
                                    '<b>Payment ID:</b> ' + Rec."BLRPayment Series" + '<br/>' +
                                    '<b>Amount Including VAT:</b> ' + Format(Rec."BLRAmount Including VAT") + '<br/>' +
                                    '<b>Due Date:</b> ' + Format(Rec."BLRDue Date", 0, '<Day,2>-<Month,2>-<Year4>') + '<br/>' +
                                    '<b>Payment Mode:</b> ' + Rec."BLRPayment Mode" + '<br/>' +
                                    '<b>Payment Status:</b> ' + Format(Rec."BLRPayment Status") + '</p>' +
                                    '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +
                                    '</body></html>',
                                    true);

                if Email.Send(EmailMessage) then
                    Message('Email sent successfully for Payment Mode: %1', EmailAddress)
                else
                    Error('Failed to send email. Please verify SMTP settings and email addresses.');
            end;
        end;
    end;

    procedure SendEmailOverdue(Rec: Record "BLRPaymentMode2"): Text;
    var
        CompanyInfo: Record "Company Information";
        PaymentMode: Record "BLRPaymentMode";
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        EmailAddress: Text[250];
    begin
        if Rec."BLRPayment Status" = Rec."BLRPayment Status"::Overdue then begin
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
                EmailMessage.Create(EmailAddress,
                                    'Payment Mode Details - ' + Format(Rec."BLRContract ID"),
                                    '<html><body>' +
                                    '<p>Dear ' + Rec."BLRTenant Name" + ',</p>' +
                                    '<p>I hope this message finds you well. This is a kind reminder that your payment for (Rent/Charges) is Overdue.</p>' +
                                    '<h3>Details of the Payment:</h3>' +
                                    '<b>Contract ID:</b> ' + Format(Rec."BLRContract ID") + '<br/>' +
                                    '<b>Payment ID:</b> ' + Rec."BLRPayment Series" + '<br/>' +
                                    '<b>Amount Including VAT:</b> ' + Format(Rec."BLRAmount Including VAT") + '<br/>' +
                                    '<b>Due Date:</b> ' + Format(Rec."BLRDue Date", 0, '<Day,2>-<Month,2>-<Year4>') + '<br/>' +
                                    '<b>Payment Mode:</b> ' + Rec."BLRPayment Mode" + '<br/>' +
                                    '<b>Payment Status:</b> ' + Format(Rec."BLRPayment Status") + '</p>' +
                                    '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +
                                    '</body></html>',
                                    true);

                if Email.Send(EmailMessage) then
                    Message('Email sent successfully for Payment Mode: %1', EmailAddress)
                else
                    Error('Failed to send email. Please verify SMTP settings and email addresses.');
            end;
        end;
    end;
}