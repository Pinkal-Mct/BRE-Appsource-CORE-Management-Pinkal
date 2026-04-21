codeunit 73209608 "Send Credit Memo to Tenant"
{
    procedure SendMailToTenantForCreditMemo(pSalesCrMemoHeader: Record "Sales Cr.Memo Header"; FileName: Text[250]; InStream: InStream)
    var

        CompanyInfo: Record "Company Information";
        SalesLine: Record "Sales Line";
        UserRec: Record User; // Record for User
        customer: Record Customer;
        UserPersonalizationRec: Record "User Personalization";
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        // SalesHeader: Record "Sales Header";

        Tomail: List of [Text];
        EmailAddress: List of [Text];

        BCCMail: List of [Text];
        // Record for User Personalization

        TotalAmount: Decimal;
        ConfirmationResult: Boolean;
    begin

        UserPersonalizationRec.SetRange("Profile ID", 'LEASE_MANAGER'); // Accounting Manager
        // if UserPersonalizationRec.FindFirst() then begin
        //     UserRec.Get(UserPersonalizationRec."User SID");
        //     EmailAddress.Add(UserRec."Contact Email");
        //     Username := UserRec."User Name";
        //     //CCMail.Add('dhruvp6373@gmail.com');

        // end;
        if UserPersonalizationRec.FindSet() then
            repeat
                if UserRec.Get(UserPersonalizationRec."User SID") then
                    if UserRec."Contact Email" <> '' then
                        EmailAddress.Add(UserRec."Contact Email");
            until UserPersonalizationRec.Next() = 0;
        if EmailAddress.Count() = 0 then
            Error('No users with the "LEASE_MANAGER" profile have a valid email address.');





        // SalesHeader.SetRange("No.", pSalesCrMemoHeader."No.");
        // // SalesHeader.SetRange("Document Type", pSalesCrMemoHeader."Document Type"::"Credit Memo");
        // if SalesHeader.FindSet() then
        //     repeat
        //         RecRef.GetTable(SalesHeader);

        //         TempBlob.CreateOutStream(OutStream);

        //         Report.SaveAs(ReportID, '', ReportFormat::Pdf, OutStream, RecRef);

        //         TempBlob.CreateInStream(InStream);

        //         FileName := 'CreditMemo' + SalesHeader."No." + '.pdf';
        TotalAmount := 0;
        SalesLine.SetRange("Document No.", pSalesCrMemoHeader."Pre-Assigned No.");
        if SalesLine.FindSet() then
            repeat

                TotalAmount += Round(SalesLine."Amount Including VAT");


            until SalesLine.Next() = 0;
        if CompanyInfo.Get() then
            if pSalesCrMemoHeader."Sell-to E-Mail" = '' then begin
                customer.Get(pSalesCrMemoHeader."Sell-to Customer No.");
                Tomail.Add(customer."E-Mail");
                EmailMessage.Create(Tomail, 'Your Credit Memo ' + pSalesCrMemoHeader."No.",
                '<html>' +
                 '<body>' +
                 '<p>Dear ' + pSalesCrMemoHeader."Sell-to Customer Name" + ',</p>' +
                 '<h3>Credit Memo Details:</h3>' +
                                    '<p><b>Credit Note No.</b> ' + pSalesCrMemoHeader."No." + '<br/>' +
                                   '<p><b>Contract ID:</b> ' + Format(pSalesCrMemoHeader."Contract ID") + '<br/>' +
                                   '<p><b>Original Invoice No.</b> ' + pSalesCrMemoHeader."Applies-to Doc. No." + '<br/>' +
                                   '<b>Property Name:</b> ' + pSalesCrMemoHeader."Property Name" + '<br/>' +
                                     '<b>Total Amount:</b> ' + Format(TotalAmount) + '<br/>' +
                                     '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +
                 '</body>' +
                 '</html>',
                  true, EmailAddress, BCCMail);

            end
            else begin
                Tomail.Add(pSalesCrMemoHeader."Sell-to E-Mail");
                EmailMessage.Create(Tomail, 'Your Credit Memo ' + pSalesCrMemoHeader."No.",
                '<html>' +
                 '<body>' +
                 '<p>Dear ' + pSalesCrMemoHeader."Sell-to Customer Name" + ',</p>' +
                 '<h3>Credit Memo Details:</h3>' +
                                     '<p><b>Credit Note No.</b> ' + pSalesCrMemoHeader."No." + '<br/>' +
                                    '<p><b>Contract ID:</b> ' + Format(pSalesCrMemoHeader."Contract ID") + '<br/>' +
                                   '<p><b>Original Invoice No.</b> ' + pSalesCrMemoHeader."Applies-to Doc. No." + '<br/>' +
                                   '<b>Property Name:</b> ' + pSalesCrMemoHeader."Property Name" + '<br/>' +
                                     '<b>Total Amount:</b> ' + Format(TotalAmount) + '<br/>' +
                                     '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +
                                    '</body>' +
                                    '</html>',
                  true, EmailAddress, BCCMail);
            end;
        EmailMessage.AddAttachment(FileName, '', InStream);
        ConfirmationResult := Confirm('Do you want to send the Credit Note email to ' + pSalesCrMemoHeader."Sell-to Customer Name" + '?', false);
        if ConfirmationResult then begin
            if Email.Send(EmailMessage) then
                Message('Email sent successfully :)');
        end else
            Message('Email sending canceled.');






    end;
}