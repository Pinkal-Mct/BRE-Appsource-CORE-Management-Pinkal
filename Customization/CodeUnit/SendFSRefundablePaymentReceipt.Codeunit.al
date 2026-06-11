codeunit 73209611 "BLRFSRefundablePaymentReceipt"
{
    procedure SendEmail(Rec: Record "BLRFinalSettlementRefund"): Text;
    var
        customerRec: Record Customer;
        CompanyInfo: Record "Company Information";
        ConsolidatedInvoiceHeader: Record "BLRFinalSettlementRefund";
        RecRef: RecordRef;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit "Email";
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        InStream: InStream;
        FileName: Text[250];
        ReportID: Integer;

    // NoSeriesManagement: Codeunit "No. Series";
    // ReceiptNo: Code[20];
    begin
        ReportID := 73209582;
        ConsolidatedInvoiceHeader.SetRange("BLRContract ID", Rec."BLRContract ID");

        if ConsolidatedInvoiceHeader.FindSet() then begin
            RecRef.GetTable(ConsolidatedInvoiceHeader);
            TempBlob.CreateOutStream(OutStream);

            Report.SaveAs(ReportID, '', ReportFormat::Pdf, OutStream, RecRef);

            TempBlob.CreateInStream(InStream);
            FileName := 'Payment Receipt_' + Format(ConsolidatedInvoiceHeader."BLRContract ID") + '.pdf';

            // Debugging to confirm email creation parameters
            // Message('Preparing to send email to: %1', ConsolidatedInvoiceHeader."Tenant Email");

            if CompanyInfo.Get() then
                if customerRec.Get(ConsolidatedInvoiceHeader."BLRTenant ID") then begin

                    EmailMessage.Create(
                                       customerRec."E-Mail",
                                       'Payment Receipt Attached_' + Format(ConsolidatedInvoiceHeader."BLRContract ID"),
                                       '<html>' +
                                       '<body>' +
                                        '<p>Dear ' + customerRec.Name + ',</p>' +
                                       '<p>Your payment has been processed. Please find your receipt attached.</p>' +
                                       '</body>' +
                                       '</html>',
                                       true // Ensure the email is sent as an HTML email
                                  );


                    EmailMessage.AddAttachment(FileName, '', InStream);
                end;

            // Debugging to confirm the email sending process
            if Email.Send(EmailMessage) then
                Message('Email sent successfully to: %1', customerRec."E-Mail")
            else
                Error('Failed to send email. Please verify SMTP settings and email addresses.');

        end else
            Error('No lease proposal details found for Proposal ID: %1', Rec."BLRContract ID");
    end;
}