codeunit 73209606 "Send Contract Email"
{
    procedure SendEmail(Rec: Record "BLRTenancyContract"): Text;
    var
        CompanyInfo: Record "Company Information";
        TempBlob: Codeunit "Temp Blob";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit "Email";
        RecRef: RecordRef;
        OutStream: OutStream;
        InStream: InStream;
        FileName: Text[250];
        ReportID: Integer;
        Emirate: Enum Emirates;
        CurrentEmirateValue: Enum Emirates;
        Leaseamount: Decimal;
    begin
        if Evaluate(CurrentEmirateValue, Rec."BLREmirate") then
            case CurrentEmirateValue of
                Emirate::Dubai, Emirate::"Abu Dhabi", Emirate::Sharjah, Emirate::Ajman, Emirate::Fujairah, Emirate::"Ras Al Khaimah":
                    ReportID := 73209591;
                Emirate::"Umm Al Quwain":
                    ReportID := 73209594;
                else
                    Error('Unsupported emirate: %1', Rec."BLREmirate");
            end
        else
            Error('Invalid emirate value: %1', Rec."BLREmirate");

        if Rec."BLRTenant ID" <> '' then begin
            TempBlob.CreateOutStream(OutStream);
            Rec.SetRecFilter();
            RecRef.GetTable(Rec);
            Report.SaveAs(ReportID, '', ReportFormat::Pdf, OutStream, RecRef);
            TempBlob.CreateInStream(InStream);
            FileName := 'Contract_' + Format(Rec."BLRTenant ID") + '.pdf';

            Leaseamount := Round(Rec."BLRAnnual Rent Amount", 0.01);

            if CompanyInfo.Get() then
                EmailMessage.Create(Rec."BLREmail Address",
                                    'Tenancy Contract Document Attached_' + Format(Rec."BLRTenant ID"),
                                    '<html>' +
                                    '<body>' +
                                    '<p>Dear ' + Rec."BLRCustomer Name" + ',</p>' +
                                    '<p>We are pleased to inform you that the tenancy contract for your property has been finalized. Please find the contract document attached to this email for your review and records.</p>' +
                                    '<h3>Contract Summary:</h3>' +
                                    '<p><b>Contract ID:</b> ' + Format(Rec."BLRContract ID") + '<br/>' +
                                    '<b>Unit Number:</b> ' + Rec."BLRUnit Number" + '<br/>' +
                                    '<b>Property Name:</b> ' + Rec."BLRProperty Name" + '<br/>' +
                                    '<b>Location:</b> ' + Format(CurrentEmirateValue) + '   ' + Rec."BLRCommunity" + '<br/>' +
                                    '<b>Contract Period:</b> ' + Format(Rec."BLRContract Start Date") + '  ' + 'To' + '  ' + Format(Rec."BLRContract End Date") + '<br/>' +
                                    '<b>Lease Amount:</b> ' + Format(Leaseamount) + '<br/>' +
                                    '<b>Payment Mode:</b> ' + Format(Rec."BLRNo of Installments") + '  ' + Format(Rec."BLRPayment Method") + '</p>' + '<br/>' +
                                    '<p>Kindly review the attached document thoroughly. If you have any questions or need further clarification, please do not hesitate to contact us.</p>' +
                                    '<p>Thank you for choosing ' + CompanyInfo.Name + '.</p>' +
                                    '<p>We look forward to serving you and ensuring a seamless tenancy experience.</p>' +
                                    '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +
                                    '</body>' +
                                    '</html>',
                                    true);
            EmailMessage.AddAttachment(FileName, '', InStream);
            if Email.Send(EmailMessage) then
                Message('Email sent successfully to: %1', Rec."BLREmail Address")
            else
                Error('Failed to send email. Please verify SMTP settings and email addresses.');
        end else
            Error('No tenancy contract details found for Tenant ID: %1', Rec."BLRTenant ID");
    end;
}
