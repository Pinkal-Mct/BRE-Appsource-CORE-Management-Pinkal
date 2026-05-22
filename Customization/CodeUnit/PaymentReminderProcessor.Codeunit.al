codeunit 73209597 "Payment Reminder Processor"
{
    Subtype = Normal;
    trigger OnRun()
    begin
        ProcessPaymentReminders();
    end;

    local procedure ProcessPaymentReminders()
    var
        PaymentRec: Record "BLRPaymentMode2";
        TodayDate: Date;
        ReminderDate: Date;
        ReminderDays: Integer;
    begin
        TodayDate := Today;
        PaymentRec.Reset();
        PaymentRec.SetFilter("BLRDue Date", '<>%1', 0D);
        PaymentRec.SetFilter("BLRPayment Reminder", '>0');
        if PaymentRec.FindSet() then
            repeat
                ReminderDays := PaymentRec."BLRPayment Reminder";
                ReminderDate := PaymentRec."BLRDue Date" - ReminderDays;
                Message(
                    'Checking Reminder: Due Date = %1 | Reminder Days = %2 | Reminder Date = %3 | Today = %4',
                    PaymentRec."BLRDue Date", ReminderDays, ReminderDate, TodayDate
                );
                if ReminderDate = TodayDate then
                    SendReminderEmail(PaymentRec);
            until PaymentRec.Next() = 0;
    end;

    local procedure SendReminderEmail(PaymentRec: Record "BLRPaymentMode2")
    var
        CompanyInfo: Record "Company Information";
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        RecipientEmail: Text;
        EmailBody: Text;
    begin
        RecipientEmail := PaymentRec."BLRTenant Email";
        if DelChr(RecipientEmail, '=', ' ') = '' then begin
            Message('Skipped: No email for tenant %1.', PaymentRec."BLRTenant Name");
            exit;
        end;
        if not CompanyInfo.Get() then
            Error('Company information not found.');
        EmailBody :=
     '<html><body>' +
     '<p>Dear ' + PaymentRec."BLRTenant Name" + ',</p>' +
     '<p>I hope this message finds you well. This is a kind reminder that your payment for <b>(Rent/Charges)</b> is due on <b>' +
     Format(PaymentRec."BLRDue Date", 0, '<Day>/<Month>/<Year4>') + '</b>, which is <b>' + Format(PaymentRec."BLRPayment Reminder") + ' days</b> from now.</p>' +
     '<p><b>Details of the Payment:</b><br/>' +
     'Contract ID: ' + Format(PaymentRec."BLRContract ID") + '<br/>' +
     'Amount Due: ' + Format(PaymentRec."BLRAmount") + '<br/>' +
     'Due Date: ' + Format(PaymentRec."BLRDue Date", 0, '<Day>/<Month>/<Year4>') + '<br/>' +
     'Payment Mode: ' + Format(PaymentRec."BLRPayment Mode") + '<br/>' +
     'Payment ID: ' + Format(PaymentRec."BLRPayment Series") + '</p>' +
     '<p>If you have any questions or require assistance, feel free to reach out to us.</p>' +
     '<p><i>This is a system-generated email.</i></p>' +
           '<p>Best regards,<br/><b>' + CompanyInfo."Name" + '</b></p>' +

     '</body></html>';
        EmailMessage.Create(
            RecipientEmail,
            'Reminder: Upcoming Payment Due',
            EmailBody,
            true
        );
        if Email.Send(EmailMessage) then
            Message('✅ Payment reminder email sent to %1.', RecipientEmail)
        else
            Error('❌ Failed to send email to %1. Check email setup.', RecipientEmail);
    end;
}
