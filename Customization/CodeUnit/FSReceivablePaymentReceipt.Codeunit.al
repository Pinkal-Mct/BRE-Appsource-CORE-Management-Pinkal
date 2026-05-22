codeunit 73209592 "FS_Receivable Payment Receipt"
{
    procedure SendEmail(Rec: Record "BLRFinalSettlement"): Text;
    var
        CompanyInfo: Record "Company Information";
        ConsolidatedInvoiceHeader: Record "BLRFinalSettlement";
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
        ConsolidatedInvoiceHeader.SetRange("BLRContract ID", Rec."BLRContract ID");
        if ConsolidatedInvoiceHeader.FindSet() then begin
            RecRef.GetTable(ConsolidatedInvoiceHeader);
            TempBlob.CreateOutStream(OutStream);
            Report.SaveAs(ReportID, '', ReportFormat::Pdf, OutStream, RecRef);
            TempBlob.CreateInStream(InStream);
            FileName := 'Payment Receipt_' + Format(ConsolidatedInvoiceHeader."BLRContract ID") + '.pdf';
            if CompanyInfo.Get() then begin

                EmailMessage.Create(
                                   ConsolidatedInvoiceHeader."BLRTenant Email",
                                   'Payment Receipt Attached_' + Format(ConsolidatedInvoiceHeader."BLRContract ID"),
                                   '<html>' +
                                   '<body>' +
                                    '<p>Dear ' + ConsolidatedInvoiceHeader."BLRTenant Name" + ',</p>' +
                                   '<p>Your payment has been received. Please find your receipt attached.</p>' +
                                   '</body>' +
                                   '</html>',
                                   true
                               );
                EmailMessage.AddAttachment(FileName, '', InStream);
            end;
            if Email.Send(EmailMessage) then
                Message('Email sent successfully to: %1', ConsolidatedInvoiceHeader."BLRTenant Email")
            else
                Error('Failed to send email. Please verify SMTP settings and email addresses.');
        end else
            Error('No lease proposal details found for Proposal ID: %1', Rec."BLRContract ID");
    end;
}