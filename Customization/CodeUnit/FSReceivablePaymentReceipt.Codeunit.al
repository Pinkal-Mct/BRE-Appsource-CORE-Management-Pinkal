codeunit 73209592 "FS_Receivable Payment Receipt"
{
    procedure SendEmail(Rec: Record FinalSettlement): Text;
    var
        CompanyInfo: Record "Company Information";
        ConsolidatedInvoiceHeader: Record FinalSettlement;
        TempBlob: Codeunit "Temp Blob";
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        RecRef: RecordRef;
        OutStream: OutStream;
        InStream: InStream;
        FileName: Text[250];
        ReportID: Integer;
    begin
        ReportID := 73209581;
        ConsolidatedInvoiceHeader.SetRange("Contract ID", Rec."Contract ID");
        if ConsolidatedInvoiceHeader.FindSet() then begin
            RecRef.GetTable(ConsolidatedInvoiceHeader);
            TempBlob.CreateOutStream(OutStream);
            Report.SaveAs(ReportID, '', ReportFormat::Pdf, OutStream, RecRef);
            TempBlob.CreateInStream(InStream);
            FileName := 'Payment Receipt_' + Format(ConsolidatedInvoiceHeader."Contract ID") + '.pdf';
            if CompanyInfo.Get() then begin

                EmailMessage.Create(
                                   ConsolidatedInvoiceHeader."Tenant Email",
                                   'Payment Receipt Attached_' + Format(ConsolidatedInvoiceHeader."Contract ID"),
                                   '<html>' +
                                   '<body>' +
                                    '<p>Dear ' + ConsolidatedInvoiceHeader."Tenant Name" + ',</p>' +
                                   '<p>Your payment has been received. Please find your receipt attached.</p>' +
                                   '</body>' +
                                   '</html>',
                                   true
                               );
                EmailMessage.AddAttachment(FileName, '', InStream);
            end;
            if Email.Send(EmailMessage) then
                Message('Email sent successfully to: %1', ConsolidatedInvoiceHeader."Tenant Email")
            else
                Error('Failed to send email. Please verify SMTP settings and email addresses.');
            exit('Email send successfully');
        end else
            Error('No lease proposal details found for Proposal ID: %1', Rec."Contract ID");
    end;
}