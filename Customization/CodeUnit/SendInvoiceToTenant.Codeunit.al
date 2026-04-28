codeunit 73209612 SendInvoiceToTenant
{
    procedure SendInvoice(pSalesInvHeader: Record "Sales Invoice Header"; FileName: Text[250]; InStream: InStream)
    var
        customer: Record Customer;
        UserPersonalizationRec: Record "User Personalization";
        CompanyInfo: Record "Company Information";
        SalesLine: Record "Sales Line";
        UserRec: Record User; // Record for User
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        Tomail: List of [Text];
        EmailAddress: List of [Text];
        BCCMail: List of [Text];

        TotalAmount: Decimal;
        ConfirmationResult: Boolean;


    begin

        UserPersonalizationRec.SetRange("Profile ID", 'LEASE MANAGER'); // Accounting Manager
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
            Error('No users with the "Lease Manager" profile have a valid email address.');

        TotalAmount := 0;
        SalesLine.SetRange("Document No.", pSalesInvHeader."Pre-Assigned No.");
        if SalesLine.FindSet() then
            repeat

                TotalAmount += Round(SalesLine."Amount Including VAT");


            until SalesLine.Next() = 0;
        if CompanyInfo.Get() then
            if pSalesInvHeader."Sell-to E-Mail" = '' then begin
                customer.Get(pSalesInvHeader."Sell-to Customer No.");
                Tomail.Add(customer."E-Mail");
                EmailMessage.Create(Tomail, 'Your Invoice ' + pSalesInvHeader."No.",
                '<html>' +
                 '<body>' +
                 '<p>Dear ' + pSalesInvHeader."Sell-to Customer Name" + ',</p>' +
                 '<h3>Invoice Details:</h3>' +
                                   '<p><b>Contract ID:</b> ' + Format(pSalesInvHeader."Contract ID") + '<br/>' +
                                   '<b>Property Name:</b> ' + pSalesInvHeader."Property Name" + '<br/>' +
                                     '<b>Total Amount:</b> ' + Format(TotalAmount) + '<br/>' +
                                     '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +
                 '</body>' +
                 '</html>',
                  true, EmailAddress, BCCMail);

            end
            else begin
                Tomail.Add(pSalesInvHeader."Sell-to E-Mail");
                EmailMessage.Create(Tomail, 'Your Invoice ' + pSalesInvHeader."No.",
                '<html>' +
                 '<body>' +
                 '<p>Dear ' + pSalesInvHeader."Sell-to Customer Name" + ',</p>' +
                 '<h3>Invoice Details:</h3>' +
                                   '<p><b>Invoice ID:</b> ' + pSalesInvHeader."No." + '<br/>' +
                                   '<b>Contract ID:</b> ' + Format(pSalesInvHeader."Contract ID") + '<br/>' +
                                                      '<b>Property Name:</b> ' + pSalesInvHeader."Property Name" + '<br/>' +
                                                        '<b>Total Amount:</b> ' + Format(TotalAmount) + '<br/>' +
                                                        '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +

                                    '</body>' +
                                    '</html>',
                  true, EmailAddress, BCCMail);
            end;

        EmailMessage.AddAttachment(FileName, '', InStream);
        ConfirmationResult := Confirm('Do you want to send the invoice email to ' + pSalesInvHeader."Sell-to Customer Name" + '?', false);
        if ConfirmationResult then begin
            if Email.Send(EmailMessage) then
                Message('Email sent successfully :)');
        end else
            Message('Email sending canceled.');
    end;



}