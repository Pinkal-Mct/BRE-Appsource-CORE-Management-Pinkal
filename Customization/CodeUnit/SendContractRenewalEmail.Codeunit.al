codeunit 73209607 "Send Contract Renewal Email"
{
    procedure SendEmail(Rec: Record "BLRContractRenewal"): Text;
    var
        CompanyInfo: Record "Company Information";
        ConsolidatedInvoiceHeader: Record "BLRContractRenewal";
        TempBlob: Codeunit "Temp Blob";
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        RecRef: RecordRef;
        OutStream: OutStream;
        InStream: InStream;
        FileName: Text[250];
        ReportID: Integer;
    begin
        ReportID := 73209579;
        ConsolidatedInvoiceHeader.SetRange("BLRId", Rec."BLRId");
        if ConsolidatedInvoiceHeader.FindSet() then begin
            RecRef.GetTable(ConsolidatedInvoiceHeader);
            TempBlob.CreateOutStream(OutStream);
            Report.SaveAs(ReportID, '', ReportFormat::Pdf, OutStream, RecRef);
            TempBlob.CreateInStream(InStream);
            FileName := 'proposal_' + Format(ConsolidatedInvoiceHeader."BLRId") + '.pdf';
            Message('Preparing to send email to: %1', ConsolidatedInvoiceHeader."BLREmail Address");
            if CompanyInfo.Get() then
                EmailMessage.Create(
                                   ConsolidatedInvoiceHeader."BLREmail Address",
                                   'Lease Proposal for Your Consideration_' + Format(ConsolidatedInvoiceHeader."BLRId"),
                                   '<html>' +
                                   '<body>' +
                                   '<p>Dear ' + ConsolidatedInvoiceHeader."BLRTenant Full Name" + ',</p>' +
                                   '<p>Thank you for your interest in leasing one of our properties. We are pleased to share the lease proposal for your review.</p>' +
                                   '<h3>Property Details:</h3>' +
                                   '<p><b>Property Name:</b> ' + ConsolidatedInvoiceHeader."BLRProperty Name" + '<br/>' +
                                   '<b>Unit Number:</b> ' + ConsolidatedInvoiceHeader."BLRUnit Number" + '<br/>' +
                                   '<b>Area:</b> ' + ConsolidatedInvoiceHeader."BLRProperty Size" + '<br/>' +
                                   '<b>Lease Amount:</b> ' + Format(ConsolidatedInvoiceHeader."BLRContract Amount") + '<br/>' +
                                   '<h3>Terms and Conditions:</h3>' +
                                   '<p>The tenancy contract will be renewable annually upon the successful completion of the yearly rental payment.<br/>' +
                                   'Renewal options are available with 90 days prior notice in alignment with the RERA Calculator.<br/>' +
                                   'Insurance: The tenant shall maintain insurance for the premises at their own expense, while the landlord will maintain insurance for the building.</p>' +
                                   '<p>We value your consideration of our property and look forward to your response. Should you have any questions or require further information, please do not hesitate to contact us.</p>' +
                                   '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +
                                   '</body>' +
                                   '</html>',
                                   true
                               );
            EmailMessage.AddAttachment(FileName, '', InStream);
            if Email.Send(EmailMessage) then
                Message('Email sent successfully to: %1', ConsolidatedInvoiceHeader."BLREmail Address")
            else
                Error('Failed to send email. Please verify SMTP settings and email addresses.');
            exit('Email send successfully');
        end else
            Error('No lease proposal details found for Proposal ID: %1', Rec."BLRTenant ID");
    end;
}