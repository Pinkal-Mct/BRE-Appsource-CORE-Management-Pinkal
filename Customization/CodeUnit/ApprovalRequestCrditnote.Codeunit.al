codeunit 73209576 "BLRApprovalRequestCrditnote "
{
    procedure SubmitCreditNote(var RequestCreditNote: Record "BLRRequestCreditNote")
    var
        ApprovalStatusList: Record "BLRReqCreditNoteApprovalList";
        UserPersonalizationRec: Record "User Personalization";
        UserRec: Record User;
        CompanyInfo: Record "Company Information";
        requestcreditnotegrid: Record "BLRRequestCreditNoteGrid";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit "Email";
        EmailList: List of [Text];
        fianancemanager: Text;
        EmailBody: Text;
        AcutalRentAmount: Decimal;
        Totalreductionamount: Decimal;
    begin
        requestcreditnotegrid.SetRange("BLRRequest No.", RequestCreditNote."BLRRequest No.");
        requestcreditnotegrid.SetRange("BLRContract ID", RequestCreditNote."BLRContract ID");
        if requestcreditnotegrid.FindSet() then
            repeat
                AcutalRentAmount += requestcreditnotegrid."BLRCurrent Charges Amount";
                Totalreductionamount += requestcreditnotegrid."BLRTotal Reduction";
            until requestcreditnotegrid.Next() = 0;
        ApprovalStatusList.Init();
        ApprovalStatusList."BLRRequest No." := RequestCreditNote."BLRRequest No.";
        ApprovalStatusList."BLRContract ID" := RequestCreditNote."BLRContract ID";
        ApprovalStatusList."BLRTenant No." := RequestCreditNote."BLRTenant No.";
        ApprovalStatusList."BLRTotal Rent Amount" := RequestCreditNote."BLRCurrent Rent Amount";
        ApprovalStatusList."BLRTotal Reduction Amount" := RequestCreditNote."BLRTotal Reduction";
        ApprovalStatusList."BLRStatus" := 'Pending';
        ApprovalStatusList.Insert();
        RequestCreditNote."BLRStatus" := RequestCreditNote."BLRStatus"::Pending;
        RequestCreditNote.Modify();
        fianancemanager := '';
        UserPersonalizationRec.SetRange("Profile ID", 'FINANCE MANAGER');
        if UserPersonalizationRec.FindSet() then
            repeat
                if UserRec.Get(UserPersonalizationRec."User SID") then
                    if UserRec."Contact Email" <> '' then begin
                        EmailList.Add(UserRec."Contact Email");
                        if fianancemanager = '' then
                            fianancemanager := UserRec."User Name"
                        else
                            fianancemanager += ', ' + UserRec."User Name";
                    end;
            until UserPersonalizationRec.Next() = 0;
        if EmailList.Count = 0 then
            Error('No valid email addresses found for Finance Manager.');
        if CompanyInfo.Get() then begin
            EmailBody :=
                '<html><body>' +
                '<p>Dear <b>Finance Manager</b>,</p>' +
                '<p>This is an automated notification from the system.</p>' +
                '<p>A new Credit Note has been submitted with the following details:</p>' +
                '<p>' +
                '<b>Request No.:</b> ' + Format(RequestCreditNote."BLRRequest No.") + '<br/>' +
                '<b>Contract ID: </b> ' + Format(RequestCreditNote."BLRContract ID") + '<br/>' +
                '<b>Tenant No:</b> ' + RequestCreditNote."BLRTenant No." + '<br/>' +
                '<b>Tenant Name: </b> ' + Format(RequestCreditNote."BLRCustomer Name") + '<br/>' +
                '<b>Request Date: </b> ' + Format(RequestCreditNote."BLRRequest Date") + '<br/>' +
               '<b>Total Rent Amount: </b> ' + Format(AcutalRentAmount) + '<br/>' +
               '<b>Total Reduction Amount: </b> ' + Format(Totalreductionamount) + '<br/>' +
                '</p>' +
                '<p>Please review the <b>Request Credit Note Approval List</b> and take the necessary action.</p>' +
                '<p>This is a system-generated email. Please do not reply.</p>' +
                '<p>Thank you,</p>' +
                '</body></html>';
            EmailMessage.Create(
                    EmailList,
                    'System Notification: Action Required - Review Credit Note for Approval - Contract ID ' + Format(RequestCreditNote."BLRContract ID"),
                    EmailBody,
                    true
                );
            if not Email.Send(EmailMessage) then
                Error('Email failed to send. Please check SMTP settings.');
        end;
    end;
}
