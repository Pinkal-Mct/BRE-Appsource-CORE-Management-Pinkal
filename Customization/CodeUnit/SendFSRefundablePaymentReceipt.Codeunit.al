codeunit 50117 "FS Refundable Payment Receipt"
{
    procedure SendEmail(Rec: Record FinalSettlementRefund): Text;
    var
        customerRec: Record Customer;
        CompanyInfo: Record "Company Information";
        ConsolidatedInvoiceHeader: Record FinalSettlementRefund;
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
        ReportID := 50120;
        ConsolidatedInvoiceHeader.SetRange("Contract ID", Rec."Contract ID");

        if ConsolidatedInvoiceHeader.FindSet() then begin
            RecRef.GetTable(ConsolidatedInvoiceHeader);
            TempBlob.CreateOutStream(OutStream);

            Report.SaveAs(ReportID, '', ReportFormat::Pdf, OutStream, RecRef);

            TempBlob.CreateInStream(InStream);
            FileName := 'Payment Receipt_' + Format(ConsolidatedInvoiceHeader."Contract ID") + '.pdf';

            // Debugging to confirm email creation parameters
            // Message('Preparing to send email to: %1', ConsolidatedInvoiceHeader."Tenant Email");

            if CompanyInfo.Get() then
                if customerRec.Get(ConsolidatedInvoiceHeader."Tenant ID") then begin

                    EmailMessage.Create(
                                       customerRec."E-Mail",
                                       'Payment Receipt Attached_' + Format(ConsolidatedInvoiceHeader."Contract ID"),
                                       '<html>' +
                                       '<body>' +
                                        '<p>Dear ' + customerRec.Name + ',</p>' +
                                       '<p>Your payment has been received. Please find your receipt attached.</p>' +
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

            exit('Email send successfully');
        end else
            Error('No lease proposal details found for Proposal ID: %1', Rec."Contract ID");
    end;
}