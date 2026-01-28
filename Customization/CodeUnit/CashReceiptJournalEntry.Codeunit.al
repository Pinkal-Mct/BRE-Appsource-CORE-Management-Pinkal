codeunit 50514 "Cash Receipt Journal Entry"
{
    Subtype = Normal;
    trigger OnRun()
    begin
    end;

    procedure CreateCashReceiptJournal(PaymentSeriesCode: Record "Payment Mode2"; postingDate: Date)
    var
        PaymentSeriesRec: Record "Payment Mode2";
        PaymentScheduleRec: Record "Payment Schedule2";
        GenJournalLineRec: Record "Gen. Journal Line";
        ContractRec: Record "Tenancy Contract";
        BankAccountRec: Record "Bank Account";
        COASetup: Record "COA Setup";
        CustRec: Record Customer;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        LineNumber: Integer;
        PDCCollectionGL: Code[20];
        PropertyClassification: Text[100];
        PDCAccount: Code[20];
        balAccountType: Enum "Gen. Journal Account Type";
        CashAccount: Code[20];
        BankaccountNo: Code[20];
    begin
        PaymentSeriesRec.SetFilter("Payment Series", '%1', PaymentSeriesCode."Payment Series");
        PaymentSeriesRec.SetFilter("Contract ID", Format(PaymentSeriesCode."Contract ID"));
        if PaymentSeriesRec.FindFirst() then begin
            if PaymentSeriesCode."Payment Status" = PaymentSeriesCode."Payment Status"::Received then begin
                GenJournalLineRec.Reset();
                GenJournalLineRec.SetRange("Journal Template Name", 'CASH RECE');
                GenJournalLineRec.SetRange("Journal Batch Name", 'DEFAULT');

                if GenJournalLineRec.FindSet() then
                    GenJournalLineRec.DeleteAll();

                ContractRec.Reset();
                ContractRec.SetRange("Contract ID", PaymentSeriesRec."Contract ID");
                if ContractRec.FindFirst() then
                    PropertyClassification := ContractRec."Property Classification";
                if CustRec.Get(PaymentScheduleRec."Tenant Id") then
                    if ContractRec."Property Classification" <> '' then begin
                        CustRec.Validate("Customer Posting Group", ContractRec."Property Classification");
                        CustRec.Validate("Gen. Bus. Posting Group", ContractRec."Property Classification");
                        CustRec.Modify();
                    end
            end else
                Error('No contract found with ID %1', PaymentSeriesRec."Contract ID");

            COASetup.Get();
            if PaymentSeriesRec."Payment Mode" = 'Cheque' then begin
                if COASetup."PDC Collection/Return" <> '' then
                    PDCAccount := COASetup."PDC Collection/Return"
                else
                    Error('COA Setup doest not exist for PDC Collection/Return account');
            end else begin
                BankAccountRec.Reset();
                BankAccountRec.SetRange("Search Name", PaymentSeriesRec."Deposit Bank");
                if BankAccountRec.FindSet() then begin
                    if BankAccountRec."Bank Acc. Posting Group" <> ''
                    then
                        BankaccountNo := BankAccountRec."No."
                    else
                        Error('Bank Account Posting Group is blank in Bank Account %1', BankAccountRec."No.");
                end
                else
                    if COASetup.Cash <> '' then
                        CashAccount := COASetup.Cash
                    else
                        Error('COA Setup doest not exist for Cash account')
            end;

            PaymentScheduleRec.SetRange("Payment Series", PaymentSeriesRec."Payment Series");
            PaymentScheduleRec.SetRange("Contract ID", PaymentSeriesRec."Contract ID");
            if not PaymentScheduleRec.IsEmpty() then begin
                LineNumber := 0;
                LineNumber := GenJournalLineRec."Line No." + 10000;
                Clear(GenJournalLineRec);
                GenJournalLineRec.Init();
                GenJournalLineRec."Journal Template Name" := 'CASH RECE';
                GenJournalLineRec."Journal Batch Name" := 'DEFAULT';
                GenJournalLineRec."Document No." := Format(PaymentSeriesCode."Entry No.");
                GenJournalLineRec."Posting Date" := postingDate;
                GenJournalLineRec."Line No." := LineNumber;
                GenJournalLineRec."Contract ID" := PaymentSeriesRec."Contract ID";
                GenJournalLineRec."Document Type" := GenJournalLineRec."Document Type"::Payment;

                if PaymentSeriesRec."Payment Mode" = 'Cheque' then begin
                    GenJournalLineRec."Account Type" := GenJournalLineRec."Account Type"::Customer;
                    GenJournalLineRec."Account No." := PaymentSeriesRec."Tenant Id";
                    GenJournalLineRec.Description := PaymentSeriesRec."Cheque Number";
                    GenJournalLineRec."Bal. Account Type" := GenJournalLineRec."Bal. Account Type"::"G/L Account";
                    GenJournalLineRec."Bal. Account No." := PDCAccount;
                end else begin
                    GenJournalLineRec."Account Type" := GenJournalLineRec."Account Type"::Customer;
                    GenJournalLineRec."Account No." := PaymentSeriesRec."Tenant Id";
                end;

                GenJournalLineRec.Description := PaymentSeriesRec."Invoice #";
                GenJournalLineRec.Validate(Amount, Round(-PaymentSeriesRec."Amount Including VAT"));
                GenJournalLineRec."Applies-to Doc. Type" := GenJournalLineRec."Applies-to Doc. Type"::Invoice;
                GenJournalLineRec."Applies-to Doc. No." := CopyStr(PaymentSeriesRec."Invoice #", 1, 20);

                if PaymentSeriesRec."Payment Mode" <> 'Cheque' then begin
                    BankAccountRec.Reset();
                    BankAccountRec.SetRange("Search Name", PaymentSeriesRec."Deposit Bank");
                    if not BankAccountRec.IsEmpty() then begin
                        GenJournalLineRec."Bal. Account Type" := GenJournalLineRec."Bal. Account Type"::"Bank Account";
                        GenJournalLineRec."Bal. Account No." := BankaccountNo;
                    end
                    else begin
                        GenJournalLineRec."Bal. Account Type" := GenJournalLineRec."Bal. Account Type"::"G/L Account";
                        GenJournalLineRec."Bal. Account No." := CashAccount;
                    end;
                end;

                GenJournalLineRec.Insert();
                GenJnlPostLine.RunWithCheck(GenJournalLineRec);
                GenJournalLineRec.Reset();
                GenJournalLineRec.SetRange("Journal Template Name", 'CASH RECE');
                GenJournalLineRec.SetRange("Journal Batch Name", 'DEFAULT');
                GenJournalLineRec.SetRange("Document No.", Format(PaymentSeriesCode."Entry No."));
                GenJournalLineRec."Posting Date" := postingDate;
                if GenJournalLineRec.FindSet() then
                    GenJournalLineRec.DeleteAll();
                Message('Cash Receipt journal created successfully.');
            end;
        end;
    end;

    procedure ProcessPDCTransaction(PDCTransactionRec: Record "PDC Transaction")
    var
        CustRec: Record Customer;
        ContractRec: Record "Tenancy Contract";
        GenJournalLine: Record "Gen. Journal Line";
        COASetup: Record "COA Setup";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        LineNo: Integer;
        PDCAccount: Code[20];
        PropertyClassification: Text[100];
    begin
        LineNo := 0;

        if PDCTransactionRec."Contract ID" <> 0 then begin
            ContractRec.Reset();
            ContractRec.SetRange("Contract ID", PDCTransactionRec."Contract ID");
            if ContractRec.FindFirst() then begin
                PropertyClassification := ContractRec."Property Classification";
                if CustRec.Get(PDCTransactionRec."Tenant Id") then
                    if ContractRec."Property Classification" <> '' then begin
                        CustRec.Validate("Customer Posting Group", ContractRec."Property Classification");
                        CustRec.Validate("Gen. Bus. Posting Group", ContractRec."Property Classification");
                        CustRec.Modify();
                    end
            end else
                Error('No contract found with ID %1', PDCTransactionRec."Contract ID");
        end else
            Error('Contract ID is missing in PDC record.');

        COASetup.Get();
        if COASetup."PDC Received" <> '' then
            PDCAccount := COASetup."PDC Received"
        else
            Error('COA Setup doest not exist for PDC Received account');

        LineNo := GenJournalLine."Line No." + 10000;
        Clear(GenJournalLine);
        GenJournalLine.Init();
        GenJournalLine."Journal Template Name" := 'CASH RECE';
        GenJournalLine."Journal Batch Name" := 'DEFAULT';
        GenJournalLine."Document No." := PDCTransactionRec."PDC ID";
        GenJournalLine."Posting Date" := Today;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Document Type" := GenJournalLine."Document Type"::Payment;
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
        GenJournalLine."Contract ID" := PDCTransactionRec."Contract ID";
        GenJournalLine."Account No." := PDCTransactionRec."Tenant Id";
        GenJournalLine.Description := COPYSTR('PDC Received - Cheque No. ' + PDCTransactionRec."Cheque Number", 1, StrLen(PDCTransactionRec."Cheque Number"));
        GenJournalLine.Validate(Amount, Round(-PDCTransactionRec.Amount));
        GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine."Bal. Account No." := PDCAccount;
        GenJournalLine.Insert();
        GenJnlPostLine.RunWithCheck(GenJournalLine);
        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", 'CASH RECE');
        GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
        GenJournalLine."Posting Date" := Today;
        if GenJournalLine.FindSet() then
            GenJournalLine.DeleteAll();
        Message('Cash Receipt journal created successfully.');
    end;
}