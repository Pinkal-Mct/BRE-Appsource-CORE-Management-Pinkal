codeunit 73209615 "Send Payment Receipt"
{
    procedure SendEmail(Rec: Record "BLRPaymentMode2"): Text;
    var
        CompanyInfo: Record "Company Information";
        ConsolidatedInvoiceHeader: Record "BLRPaymentMode2";
        PaymentMode: Record "BLRPaymentMode";
        TempBlob: Codeunit "Temp Blob";
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        NoSeriesManagement: Codeunit "No. Series";
        RecRef: RecordRef;
        OutStream: OutStream;
        InStream: InStream;
        FileName: Text[250];
        ReportID: Integer;
        ReceiptNo: Code[20];
        EmailAddress: Text[250];
    begin
        ReportID := 73209586;
        // Apply filters to fetch the specific record
        ConsolidatedInvoiceHeader.Reset();
        ConsolidatedInvoiceHeader.SetRange("BLRTenant Id", Rec."BLRTenant Id");
        ConsolidatedInvoiceHeader.SetRange("BLRContract ID", Rec."BLRContract ID");
        ConsolidatedInvoiceHeader.SetRange("BLRPayment Series", Rec."BLRPayment Series");
        if ConsolidatedInvoiceHeader.FindFirst() then begin
            PaymentMode.Reset();
            PaymentMode.SetRange("BLRTenant Id", ConsolidatedInvoiceHeader."BLRTenant Id");
            PaymentMode.SetRange("BLRContract ID", ConsolidatedInvoiceHeader."BLRContract ID");
            if PaymentMode.FindFirst() then begin
                EmailAddress := PaymentMode."BLRTenant Email"; // Get email from Payment Mode table

                // Check if email address is not empty
                if EmailAddress = '' then
                    Error('Email address not found for Tenant ID: %1', ConsolidatedInvoiceHeader."BLRTenant Id");

            end else
                Error('Payment Mode record not found for Tenant ID: %1', ConsolidatedInvoiceHeader."BLRTenant Id");

            // Prepare the report output
            RecRef.GetTable(ConsolidatedInvoiceHeader);
            TempBlob.CreateOutStream(OutStream);
            Report.SaveAs(ReportID, '', ReportFormat::Pdf, OutStream, RecRef);
            TempBlob.CreateInStream(InStream);
            FileName := 'Receipt_' + Format(ConsolidatedInvoiceHeader."BLRReceipt #") + '.pdf';
            // Debugging to confirm email creation parameters
            Message('Preparing to send email to: %1', EmailAddress);
            // Retrieve company information
            if CompanyInfo.Get() then begin
                // Create email with detailed contract information
                EmailMessage.Create(EmailAddress,
                                    'Payment Receipt Attached_' + Format(ConsolidatedInvoiceHeader."BLRReceipt #"),
                                    '<html>' +
                                    '<body>' +
                                    '<p>Dear ' + ConsolidatedInvoiceHeader."BLRTenant Name" + ',' +
                                    'Your payment has been received. Please find your receipt attached.</p>' +
                                    '</body>' +
                                    '</html>',
                                    true);
                // Attach the PDF document
                EmailMessage.AddAttachment(FileName, '', InStream);
                // Send the email
                if Email.Send(EmailMessage) then
                    Message('Email sent successfully to: %1', EmailAddress)
                else
                    Error('Failed to send email. Please verify SMTP settings and email addresses.');
            end;
            exit('Email sent successfully');
        end else
            Error('No Payment Receipt details found for Tenant ID: %1, Contract ID: %2, Payment Series: %3', Rec."BLRTenant Id", Rec."BLRContract ID", Rec."BLRPayment Series");
    end;
}