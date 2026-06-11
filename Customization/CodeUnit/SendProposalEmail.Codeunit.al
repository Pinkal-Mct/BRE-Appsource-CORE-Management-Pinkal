codeunit 73209617 "BLRSend Proposal Email"
{
    procedure SendEmail(Rec: Record "BLRLeaseProposalDetails"): Text;
    var
        CompanyInfo: Record "Company Information";
        ConsolidatedInvoiceHeader: Record "BLRLeaseProposalDetails";
        AdditionalDetailsTable: Record "BLRRevenueItemSubpage";
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        SecondTempBlob: Codeunit "Temp Blob";
        RecRef: RecordRef;
        SecondRecRef: RecordRef;
        OutStream: OutStream;
        SecondOutStream: OutStream;
        InStream: InStream;
        SecondInStream: InStream;
        FileName: Text[250];
        SecondFileName: Text[250];
        ReportID: Integer;
        SecondReportID: Integer;
        Leaseamount: Decimal;
    begin
        ReportID := 73209587;
        SecondReportID := 73209585;

        ConsolidatedInvoiceHeader.SetRange("BLRProposal ID", Rec."BLRProposal ID");
        if ConsolidatedInvoiceHeader.FindSet() then begin

            if ConsolidatedInvoiceHeader."BLRTenant Contact Email" = '' then
                Error('The email ID is blank. Please enter the email ID first.');

            RecRef.GetTable(ConsolidatedInvoiceHeader);
            TempBlob.CreateOutStream(OutStream);
            Report.SaveAs(ReportID, '', ReportFormat::Pdf, OutStream, RecRef);
            TempBlob.CreateInStream(InStream);
            FileName := 'proposal_' + Format(ConsolidatedInvoiceHeader."BLRProposal ID") + '.pdf';
            AdditionalDetailsTable.SetRange("BLRProposalID", Rec."BLRProposal ID");
            if AdditionalDetailsTable.FindSet() then begin
                SecondRecRef.GetTable(AdditionalDetailsTable);
                SecondTempBlob.CreateOutStream(SecondOutStream);
                Report.SaveAs(SecondReportID, '', ReportFormat::Pdf, SecondOutStream, SecondRecRef);
                SecondTempBlob.CreateInStream(SecondInStream);
                SecondFileName := 'additional_details_' + Format(AdditionalDetailsTable."BLRProposalID") + '.pdf';
            end else
                Error('No data found for the second report.');

            Leaseamount := Round(ConsolidatedInvoiceHeader."BLRAnnual Rent Amount", 0.01);

            if CompanyInfo.Get() then
                EmailMessage.Create(
                    ConsolidatedInvoiceHeader."BLRTenant Contact Email",
                    'Lease Proposal for Your Consideration_' + Format(ConsolidatedInvoiceHeader."BLRProposal ID"),
                    '<html>' +
                    '<body>' +
                    '<p>Dear ' + ConsolidatedInvoiceHeader."BLRTenant Full Name" + ',</p>' +
                    '<p>Thank you for your interest in leasing one of our properties. We are pleased to share the lease proposal for your review.</p>' +
                    '<h3>Property Details:</h3>' +
                    '<p><b>Property Name:</b> ' + ConsolidatedInvoiceHeader."BLRProperty Name" + '<br/>' +
                    '<b>Unit Number:</b> ' + ConsolidatedInvoiceHeader."BLRUnit Number" + '<br/>' +
                    '<b>Area:</b> ' + Format(ConsolidatedInvoiceHeader."BLRUnit Size") + '<br/>' +
                    '<b>Lease Amount:</b> ' + Format(Leaseamount) + '<br/>' +
                    '<b>Lease Term:</b> ' + ConsolidatedInvoiceHeader."BLRLease Duration" + '</p>' +
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
            EmailMessage.AddAttachment(SecondFileName, '', SecondInStream);
            if Email.Send(EmailMessage) then
                Message('Email sent successfully to: %1', ConsolidatedInvoiceHeader."BLRTenant Contact Email")
            else
                Error('Failed to send email. Please verify SMTP settings and email addresses.');

        end else
            Error('No lease proposal details found for Proposal ID: %1', Rec."BLRTenant ID");
    end;
}
