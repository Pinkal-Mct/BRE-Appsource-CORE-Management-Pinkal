codeunit 50514 "Cash Receipt Journal Entry"
{
    Subtype = Normal;
    trigger OnRun()
    begin
    end;

    procedure CreateCashReceiptJournal(PDCTransRec: Record "PDC Transaction"; postingDate: Date)
    var
        PaymentSeriesRec: Record "Payment Mode2"; // Your Payment Series Table
        PaymentScheduleRec: Record "Payment Schedule2"; // Your Payment Schedule Table
        COASetup: Record "COA Setup";
        BankAccountRec: Record "Bank Account";
        GenJournalLineRec: Record "Gen. Journal Line";
        CustRec: Record Customer;
        ContractRec: Record "Tenancy Contract";
        // GenJournalBatchRec: Record "Gen. Journal Batch";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        LineNumber: Integer;
        PropertyClassification: Text[100];
        PDCCollection: Code[20];
        CashAccount: Code[20];
        BankaccountNo: Code[20];
        PDCLiabilities: Code[20];
    begin
        // Find the Payment Series Record
        PaymentSeriesRec.Reset();
        PaymentSeriesRec.SetFilter("Payment Series", '%1', PDCTransRec."Payment Series");
        PaymentSeriesRec.SetFilter("Contract ID", Format(PDCTransRec."Contract ID"));
        if PaymentSeriesRec.FindFirst() then begin


            // Reset Existing Cash Receipt Journal Lines
            GenJournalLineRec.Reset();
            GenJournalLineRec.SetRange("Journal Template Name", 'CASH RECE');
            GenJournalLineRec.SetRange("Journal Batch Name", 'DEFAULT');
            // GenJournalLineRec.SetRange("Line No.", 10000);

            if GenJournalLineRec.FindSet() then
                GenJournalLineRec.DeleteAll();

            //  Get Contract Info
            ContractRec.Reset();
            ContractRec.SetRange("Contract ID", PaymentSeriesRec."Contract ID");
            if ContractRec.FindFirst() then
                // update Customer as before
                PropertyClassification := ContractRec."Property Classification";
            if CustRec.Get(PaymentSeriesRec."Tenant Id") then
                if ContractRec."Property Classification" <> '' then begin
                    CustRec.Validate("Customer Posting Group", ContractRec."Property Classification");
                    CustRec.Validate("Gen. Bus. Posting Group", ContractRec."Property Classification");
                    CustRec.Modify();

                end;



            ///////////////////////// COA Setup /////////////////////////////

            COASetup.Get();
            if PaymentSeriesRec."Payment Mode" = 'Cheque' then begin
                if COASetup."PDC Collection/Return" <> '' then
                    PDCCollection := COASetup."PDC Collection/Return"

                else
                    Error('COA Setup doest not exist for PDC Collection/Return account');

                if COASetup."PDC Liabilities" <> '' then
                    PDCLiabilities := COASetup."PDC Liabilities"

                else
                    Error('COA Setup doest not exist for PDC Liabilities account');

                BankAccountRec.Reset();
                BankAccountRec.SetRange("Search Name", PaymentSeriesRec."Deposit Bank");
                if BankAccountRec.FindSet() then
                    if BankAccountRec."Bank Acc. Posting Group" <> ''
                    then
                        BankaccountNo := BankAccountRec."No."
                    else
                        Error('Bank Account Posting Group is blank in Bank Account %1', BankAccountRec."No.");

            end else begin

                BankAccountRec.Reset();
                BankAccountRec.SetRange("Search Name", PaymentSeriesRec."Deposit Bank");
                if BankAccountRec.FindFirst() then
                    if BankAccountRec."Bank Acc. Posting Group" <> ''
                    then
                        BankaccountNo := BankAccountRec."No."
                    else
                        Error('Bank Account Posting Group is blank in Bank Account %1', BankAccountRec."No.")

                else

                    if COASetup.Cash <> '' then
                        CashAccount := COASetup.Cash
                    else
                        Error('COA Setup doest not exist for Cash account');

            end;



            ////////////////////////////// END COA Setup /////////////////////////

            // Loop through Payment Schedule and create individual lines
            PaymentScheduleRec.SetRange("Payment Series", PaymentSeriesRec."Payment Series");
            PaymentScheduleRec.SetRange("Contract ID", PaymentSeriesRec."Contract ID");
            if not PaymentScheduleRec.IsEmpty() then begin
                LineNumber := 0;

                LineNumber := GenJournalLineRec."Line No." + 10000;


                Clear(GenJournalLineRec);
                GenJournalLineRec.Init();
                GenJournalLineRec."Journal Template Name" := 'CASH RECE';
                GenJournalLineRec."Journal Batch Name" := 'DEFAULT';
                GenJournalLineRec."Document No." := Format(PaymentSeriesRec."Entry No.");
                GenJournalLineRec."Posting Date" := postingDate;
                GenJournalLineRec."Line No." := LineNumber;
                GenJournalLineRec."Contract ID" := PaymentSeriesRec."Contract ID";
                GenJournalLineRec."Document Type" := GenJournalLineRec."Document Type"::Payment;


                GenJournalLineRec.Validate("Account Type", GenJournalLineRec."Account Type"::"G/L Account");
                GenJournalLineRec.Validate("Account No.", PDCCollection);
                GenJournalLineRec.Description := 'Cheque Clearnace - ' + PaymentSeriesRec."Cheque Number"; // Customer from Payment Series
                GenJournalLineRec.Validate(Amount, Round(-PaymentSeriesRec."Amount Including VAT"));
                GenJournalLineRec.Validate("Bal. Account Type", GenJournalLineRec."Bal. Account Type"::"Bank Account");
                GenJournalLineRec.Validate("Bal. Account No.", BankaccountNo);




                GenJournalLineRec.Insert();
                GenJnlPostLine.RunWithCheck(GenJournalLineRec);


                GenJournalLineRec.Reset();
                GenJournalLineRec.SetRange("Journal Template Name", 'CASH RECE');
                GenJournalLineRec.SetRange("Journal Batch Name", 'DEFAULT');
                if GenJournalLineRec.FindSet() then
                    GenJournalLineRec.DeleteAll();

                PDCClearanceLiabilities(PDCTransRec, postingDate, PDCLiabilities);
                Message('Cash Receipt journal created successfully.');
                // end;
            end;
        end;
    end;

    procedure PDCClearanceLiabilities(PDCTransRec: Record "PDC Transaction"; postingDate: Date; PDCLiabilities: Code[20])
    var
        PaymentSeriesRec: Record "Payment Mode2"; // Your Payment Series Table
        PaymentScheduleRec: Record "Payment Schedule2"; // Your Payment Schedule Table
        GenJournalLineRec: Record "Gen. Journal Line";
        PostedSalesInvoice: Record "Sales Invoice Header";
        ContractRec: Record "Tenancy Contract";

        CustRec: Record Customer;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        LineNumber: Integer;

        PropertyClassification: Text[100];

    begin
        PaymentSeriesRec.Reset();
        PaymentSeriesRec.SetFilter("Payment Series", '%1', PDCTransRec."Payment Series");
        PaymentSeriesRec.SetFilter("Contract ID", Format(PDCTransRec."Contract ID"));
        if PaymentSeriesRec.FindFirst() then begin


            // Reset Existing Cash Receipt Journal Lines
            GenJournalLineRec.Reset();
            GenJournalLineRec.SetRange("Journal Template Name", 'CASH RECE');
            GenJournalLineRec.SetRange("Journal Batch Name", 'DEFAULT');
            // GenJournalLineRec.SetRange("Line No.", 10000);

            if GenJournalLineRec.FindSet() then
                GenJournalLineRec.DeleteAll();

            //  Get Contract Info
            ContractRec.Reset();
            ContractRec.SetRange("Contract ID", PaymentSeriesRec."Contract ID");
            if ContractRec.FindFirst() then
                // update Customer as before
                PropertyClassification := ContractRec."Property Classification";
            if CustRec.Get(PaymentSeriesRec."Tenant Id") then
                if ContractRec."Property Classification" <> '' then begin
                    CustRec.Validate("Customer Posting Group", ContractRec."Property Classification");
                    CustRec.Validate("Gen. Bus. Posting Group", ContractRec."Property Classification");
                    CustRec.Modify();
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
                GenJournalLineRec."Document No." := Format(PaymentSeriesRec."Entry No.");
                GenJournalLineRec."Posting Date" := postingDate;
                GenJournalLineRec."Line No." := LineNumber;
                GenJournalLineRec."Contract ID" := PaymentSeriesRec."Contract ID";
                GenJournalLineRec."Document Type" := GenJournalLineRec."Document Type"::Payment;


                GenJournalLineRec."Account Type" := GenJournalLineRec."Account Type"::Customer;
                GenJournalLineRec.Validate("Account Type", GenJournalLineRec."Account Type"::Customer);
                GenJournalLineRec.Validate("Account No.", PaymentSeriesRec."Tenant Id"); // Customer from Payment Series
                GenJournalLineRec.Description := 'Cheque Clearnace - ' + PaymentSeriesRec."Cheque Number"; // Customer from Payment Series
                GenJournalLineRec.Validate(Amount, Round(-PaymentSeriesRec."Amount Including VAT"));
                GenJournalLineRec."Bal. Account Type" := GenJournalLineRec."Bal. Account Type"::"G/L Account";
                GenJournalLineRec."Bal. Account No." := PDCLiabilities;

                PostedSalesInvoice.SetRange("No.", PaymentSeriesRec."Invoice #");
                PostedSalesInvoice.SetFilter("Posting Date", '>%1', postingDate);
                if not PostedSalesInvoice.IsEmpty() then
                    Message('Please apply the entries (Receipt with Invoice) manually in the system as there are posted invoices with posting date later than Receipt date.')
                else begin
                    GenJournalLineRec.Validate("Applies-to Doc. Type", GenJournalLineRec."Applies-to Doc. Type"::Invoice);
                    GenJournalLineRec.Validate("Applies-to Doc. No.", PaymentSeriesRec."Invoice #");
                end;


                GenJournalLineRec.Insert();
                // Optionally Post the Journal Entry
                GenJnlPostLine.RunWithCheck(GenJournalLineRec);


                GenJournalLineRec.Reset();
                GenJournalLineRec.SetRange("Journal Template Name", 'CASH RECE');
                GenJournalLineRec.SetRange("Journal Batch Name", 'DEFAULT');
                if GenJournalLineRec.FindSet() then
                    GenJournalLineRec.DeleteAll();

            end;
        end;
    end;

    procedure PaymentReceivedTransaction(PaymentSeriesRec: Record "Payment Mode2"; postingDate: Date)
    var

        GenJournalLineRec: Record "Gen. Journal Line";
        PostedSalesInvoice: Record "Sales Invoice Header";
        COASetup: Record "COA Setup";
        // GenJournalBatchRec: Record "Gen. Journal Batch";

        ContractRec: Record "Tenancy Contract";
        BankAccountRec: Record "Bank Account";
        CustRec: Record Customer;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        LineNo: Integer;

        PropertyClassification: Text[100];

        CashAccount: Code[20];
        BankaccountNo: Code[20];

    begin
        LineNo := 0;
        if PaymentSeriesRec."Contract ID" <> 0 then begin
            ContractRec.Reset();
            ContractRec.SetRange("Contract ID", PaymentSeriesRec."Contract ID"); // Use correct field name
            if ContractRec.FindFirst() then begin
                PropertyClassification := ContractRec."Property Classification";
                // update Customer as before
                if CustRec.Get(PaymentSeriesRec."Tenant Id") then
                    if ContractRec."Property Classification" <> '' then begin
                        CustRec.Validate("Customer Posting Group", ContractRec."Property Classification");
                        CustRec.Validate("Gen. Bus. Posting Group", ContractRec."Property Classification");
                        CustRec.Modify();

                    end

            end else
                Error('No contract found with ID %1', PaymentSeriesRec."Contract ID");
        end else
            Error('Contract ID is missing in Payment Mode record.');

        ///////////////////////// COA Setup /////////////////////////////

        BankAccountRec.Reset();
        BankAccountRec.SetRange("Search Name", PaymentSeriesRec."Deposit Bank");
        if BankAccountRec.FindSet() then begin
            if BankAccountRec."Bank Acc. Posting Group" <> ''
            then
                BankaccountNo := BankAccountRec."No."
            else
                Error('Bank Account Posting Group is blank in Bank Account %1', BankAccountRec."No.");
        end
        else begin
            COASetup.Get();
            if COASetup.Cash <> '' then
                CashAccount := COASetup.Cash
            else
                Error('COA Setup doest not exist for Cash account');
        end;

        GenJournalLineRec.Reset();
        GenJournalLineRec.SetRange("Journal Template Name", 'CASH RECE');
        GenJournalLineRec.SetRange("Journal Batch Name", 'DEFAULT');
        // GenJournalLineRec.SetRange("Line No.", 10000);

        if GenJournalLineRec.FindSet() then
            GenJournalLineRec.DeleteAll();

        LineNo := GenJournalLineRec."Line No." + 10000;
        Clear(GenJournalLineRec);
        GenJournalLineRec.Init();
        GenJournalLineRec."Journal Template Name" := 'CASH RECE';
        GenJournalLineRec."Journal Batch Name" := 'DEFAULT';
        GenJournalLineRec."Document No." := Format(PaymentSeriesRec."Entry No.");
        GenJournalLineRec."Posting Date" := postingDate;
        GenJournalLineRec."Line No." := LineNo;
        GenJournalLineRec."Document Type" := GenJournalLineRec."Document Type"::Payment;
        GenJournalLineRec.Validate("Account Type", GenJournalLineRec."Account Type"::Customer);
        GenJournalLineRec.Validate("Account No.", PaymentSeriesRec."Tenant Id"); // Customer from Payment Series
        GenJournalLineRec.Description := 'Payment Received - ' + PaymentSeriesRec."Invoice #";

        GenJournalLineRec."Contract ID" := PaymentSeriesRec."Contract ID";

        GenJournalLineRec.Validate(Amount, Round(-PaymentSeriesRec."Amount Including VAT"));
        // GenJournalLineRec."Amount (LCY)" := GenJournalLineRec.Amount;
        BankAccountRec.Reset();
        BankAccountRec.SetRange("Search Name", PaymentSeriesRec."Deposit Bank");
        if not BankAccountRec.IsEmpty() then begin
            GenJournalLineRec."Bal. Account Type" := GenJournalLineRec."Bal. Account Type"::"Bank Account";
            GenJournalLineRec."Bal. Account No." := BankaccountNo;

            PostedSalesInvoice.SetRange("No.", PaymentSeriesRec."Invoice #");
            PostedSalesInvoice.SetFilter("Posting Date", '>%1', postingDate);
            if PostedSalesInvoice.FindFirst() then
                Message('Please apply the entries (Receipt with Invoice) manually in the system as there are posted invoices with posting date later than Receipt date.')
            else begin

                GenJournalLineRec.Validate("Applies-to Doc. Type", GenJournalLineRec."Applies-to Doc. Type"::Invoice);
                GenJournalLineRec.Validate("Applies-to Doc. No.", PaymentSeriesRec."Invoice #");
            end;
        end
        else begin
            GenJournalLineRec."Bal. Account Type" := GenJournalLineRec."Bal. Account Type"::"G/L Account";
            GenJournalLineRec."Bal. Account No." := CashAccount;

            PostedSalesInvoice.SetRange("No.", PaymentSeriesRec."Invoice #");
            PostedSalesInvoice.SetFilter("Posting Date", '>%1', postingDate);
            if not PostedSalesInvoice.IsEmpty() then
                Message('Please apply the entries (Receipt with Invoice) manually in the system as there are posted invoices with posting date later than Receipt date.')
            else begin
                GenJournalLineRec.Validate("Applies-to Doc. Type", GenJournalLineRec."Applies-to Doc. Type"::Invoice);
                GenJournalLineRec.Validate("Applies-to Doc. No.", PaymentSeriesRec."Invoice #");
            end;
        end;

        GenJournalLineRec.Insert();

        GenJnlPostLine.RunWithCheck(GenJournalLineRec);


        GenJournalLineRec.Reset();
        GenJournalLineRec.SetRange("Journal Template Name", 'CASH RECE');
        GenJournalLineRec.SetRange("Journal Batch Name", 'DEFAULT');
        if GenJournalLineRec.FindSet() then
            GenJournalLineRec.DeleteAll();

        Message('Cash Receipt journal created successfully.');
    end;



    procedure PDCReceivedTransaction(PDCTransactionRec: Record "PDC Transaction")
    var
        GenJournalLine: Record "Gen. Journal Line";
        CustRec: Record Customer;
        ContractRec: Record "Tenancy Contract";
        COASetup: Record "COA Setup";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        LineNo: Integer;
        PropertyClassification: Text[100];
        PDCReceived: Code[20];
        PDCLiabilities: Code[20];

    begin
        LineNo := 0;
        if PDCTransactionRec."Contract ID" <> 0 then begin
            ContractRec.Reset();
            ContractRec.SetRange("Contract ID", PDCTransactionRec."Contract ID"); // Use correct field name
            if ContractRec.FindFirst() then begin
                PropertyClassification := ContractRec."Property Classification";
                // update Customer as before
                if CustRec.Get(PDCTransactionRec."Tenant Id") then
                    if ContractRec."Property Classification" <> '' then begin
                        CustRec.Validate("Customer Posting Group", ContractRec."Property Classification");
                        CustRec.Validate("Gen. Bus. Posting Group", ContractRec."Property Classification");
                        CustRec.Modify();

                    end;

            end else
                Error('No contract found with ID %1', PDCTransactionRec."Contract ID");
        end else
            Error('Contract ID is missing in PDC record.');

        ///////////////////////// COA Setup /////////////////////////////

        COASetup.Get();
        if COASetup."PDC Received" <> '' then
            PDCReceived := COASetup."PDC Received"

        else
            Error('COA Setup doest not exist for PDC Received account');
        COASetup.Get();
        if COASetup."PDC Liabilities" <> '' then
            PDCLiabilities := COASetup."PDC Liabilities"

        else
            Error('COA Setup doest not exist for PDC Liabilities account');


        ////////////////////////////// END COA Setup /////////////////////////
        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", 'CASH RECE');
        GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
        GenJournalLine."Posting Date" := Today;
        if GenJournalLine.FindSet() then
            GenJournalLine.DeleteAll();


        LineNo := GenJournalLine."Line No." + 10000;
        Clear(GenJournalLine);
        GenJournalLine.Init();
        GenJournalLine."Journal Template Name" := 'CASH RECE';
        GenJournalLine."Journal Batch Name" := 'DEFAULT';
        GenJournalLine."Document No." := PDCTransactionRec."PDC ID";
        GenJournalLine."Posting Date" := PDCTransactionRec."Transaction Date";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Document Type" := GenJournalLine."Document Type"::Payment;
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
        GenJournalLine."Account No." := PDCLiabilities; // Customer from Payment Series
        GenJournalLine."Contract ID" := PDCTransactionRec."Contract ID";
        GenJournalLine.Description := 'PDC Received - Cheque No. ' + PDCTransactionRec."Cheque Number";
        GenJournalLine.Validate(Amount, Round(-PDCTransactionRec.Amount));
        // GenJournalLine."Amount (LCY)" := GenJournalLine.Amount;
        GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine."Bal. Account No." := PDCReceived;


        GenJournalLine.Insert();

        GenJnlPostLine.RunWithCheck(GenJournalLine);


        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", 'CASH RECE');
        GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
        if GenJournalLine.FindSet() then
            GenJournalLine.DeleteAll();

        Message('Cash Receipt journal created successfully.');
    end;




    procedure ReversePDCReceivedTransaction(PDCTransactionRec: Record "PDC Transaction"; SplitCombineMethod: Text[50]; TransactionDate: Date)
    var

        GenJournalLine: Record "Gen. Journal Line";

        COASetup: Record "COA Setup";

        CustRec: Record Customer;
        ContractRec: Record "Tenancy Contract";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";

        PropertyClassification: Text[100];
        LineNo: Integer;
        PDCReceived: Code[20];
        PDCLiabilities: Code[20];

    begin
        LineNo := 0;
        if PDCTransactionRec."Contract ID" <> 0 then begin
            ContractRec.Reset();
            ContractRec.SetRange("Contract ID", PDCTransactionRec."Contract ID"); // Use correct field name
            if ContractRec.FindFirst() then begin
                PropertyClassification := ContractRec."Property Classification";
                // update Customer as before
                if CustRec.Get(PDCTransactionRec."Tenant Id") then
                    if ContractRec."Property Classification" <> '' then begin
                        CustRec.Validate("Customer Posting Group", ContractRec."Property Classification");
                        CustRec.Validate("Gen. Bus. Posting Group", ContractRec."Property Classification");
                        CustRec.Modify();

                    end;


            end else
                Error('No contract found with ID %1', PDCTransactionRec."Contract ID");
        end else
            Error('Contract ID is missing in PDC record.');

        ///////////////////////// COA Setup /////////////////////////////

        COASetup.Get();
        if COASetup."PDC Received" <> '' then
            PDCReceived := COASetup."PDC Received"
        else
            Error('COA Setup doest not exist for PDC Received account');
        COASetup.Get();
        if COASetup."PDC Liabilities" <> '' then
            PDCLiabilities := COASetup."PDC Liabilities"

        else
            Error('COA Setup doest not exist for PDC Liabilities account');


        ////////////////////////////// END COA Setup /////////////////////////
        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", 'CASH RECE');
        GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
        GenJournalLine."Posting Date" := Today;
        if GenJournalLine.FindSet() then
            GenJournalLine.DeleteAll();

        LineNo := GenJournalLine."Line No." + 10000;
        Clear(GenJournalLine);
        GenJournalLine.Init();
        GenJournalLine."Journal Template Name" := 'CASH RECE';
        GenJournalLine."Journal Batch Name" := 'DEFAULT';
        GenJournalLine."Document No." := PDCTransactionRec."PDC ID";
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Document Type" := GenJournalLine."Document Type"::Payment;
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
        GenJournalLine."Account No." := PDCReceived; // Customer from Payment Series
        GenJournalLine."Contract ID" := PDCTransactionRec."Contract ID";
        GenJournalLine.Description := 'Cheque #' + PDCTransactionRec."Cheque Number" + ' voided- ' + SplitCombineMethod;
        GenJournalLine.Validate(Amount, Round(-PDCTransactionRec.Amount));
        // GenJournalLine."Amount (LCY)" := GenJournalLine.Amount;
        GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine."Bal. Account No." := PDCLiabilities;


        GenJournalLine.Insert();

        GenJnlPostLine.RunWithCheck(GenJournalLine);


        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", 'CASH RECE');
        GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
        if GenJournalLine.FindSet() then
            GenJournalLine.DeleteAll();
        Message('Cash Receipt journal created successfully.');
    end;



    procedure PDCDepositedTransaction(PDCTransactionRec: Record "PDC Transaction")
    var

        GenJournalLine: Record "Gen. Journal Line";
        COASetup: Record "COA Setup";

        CustRec: Record Customer;
        ContractRec: Record "Tenancy Contract";

        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        LineNo: Integer;
        PropertyClassification: Text[100];
        PDCollection: Code[20];
        PDCReceived: Code[20];
    begin
        LineNo := 0;
        if PDCTransactionRec."Contract ID" <> 0 then begin
            ContractRec.Reset();
            ContractRec.SetRange("Contract ID", PDCTransactionRec."Contract ID"); // Use correct field name
            if ContractRec.FindFirst() then begin
                PropertyClassification := ContractRec."Property Classification";
                // update Customer as before
                if CustRec.Get(PDCTransactionRec."Tenant Id") then
                    if ContractRec."Property Classification" <> '' then begin
                        CustRec.Validate("Customer Posting Group", ContractRec."Property Classification");
                        CustRec.Validate("Gen. Bus. Posting Group", ContractRec."Property Classification");
                        CustRec.Modify();

                    end;


            end else
                Error('No contract found with ID %1', PDCTransactionRec."Contract ID");
        end else
            Error('Contract ID is missing in PDC record.');

        COASetup.Get();
        if COASetup."PDC Collection/Return" <> '' then
            PDCollection := COASetup."PDC Collection/Return"

        else
            Error('COA Setup doest not exist for PDC Collection/Return account');

        if COASetup."PDC Received" <> '' then
            PDCReceived := COASetup."PDC Received"

        else
            Error('COA Setup doest not exist for PDC Received account');


        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", 'CASH RECE');
        GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
        GenJournalLine."Posting Date" := Today;
        if GenJournalLine.FindSet() then
            GenJournalLine.DeleteAll();


        LineNo := GenJournalLine."Line No." + 10000;
        Clear(GenJournalLine);
        GenJournalLine.Init();
        GenJournalLine."Journal Template Name" := 'CASH RECE';
        GenJournalLine."Journal Batch Name" := 'DEFAULT';
        GenJournalLine."Document No." := PDCTransactionRec."PDC ID";
        GenJournalLine."Posting Date" := PDCTransactionRec."Transaction Date";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Document Type" := GenJournalLine."Document Type"::" ";
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
        GenJournalLine."Account No." := PDCReceived; // Customer from Payment Series
        GenJournalLine."Contract ID" := PDCTransactionRec."Contract ID";
        GenJournalLine.Description := ' Cheque Deposit - Cheque No. ' + PDCTransactionRec."Cheque Number";
        GenJournalLine.Validate(Amount, Round(-PDCTransactionRec.Amount));
        // GenJournalLine."Amount (LCY)" := GenJournalLine.Amount;
        GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine."Bal. Account No." := PDCollection;


        GenJournalLine.Insert();

        GenJnlPostLine.RunWithCheck(GenJournalLine);


        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", 'CASH RECE');
        GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
        if GenJournalLine.FindSet() then
            GenJournalLine.DeleteAll();

        Message('Cash Receipt journal created successfully.');

    end;


    procedure PDCReturnedTransaction(PDCTransactionRec: Record "PDC Transaction")
    var

        GenJournalLine: Record "Gen. Journal Line";
        CustRec: Record Customer;
        COASetup: Record "COA Setup";
        ContractRec: Record "Tenancy Contract";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        LineNo: Integer;


        PropertyClassification: Text[100];
        PDCollection: Code[20];
        PDCLiabilities: Code[20];
    begin
        LineNo := 0;
        if PDCTransactionRec."Contract ID" <> 0 then begin
            ContractRec.Reset();
            ContractRec.SetRange("Contract ID", PDCTransactionRec."Contract ID"); // Use correct field name
            if ContractRec.FindFirst() then begin
                PropertyClassification := ContractRec."Property Classification";
                // update Customer as before
                if CustRec.Get(PDCTransactionRec."Tenant Id") then
                    if ContractRec."Property Classification" <> '' then begin
                        CustRec.Validate("Customer Posting Group", ContractRec."Property Classification");
                        CustRec.Validate("Gen. Bus. Posting Group", ContractRec."Property Classification");
                        CustRec.Modify();

                    end;

            end else
                Error('No contract found with ID %1', PDCTransactionRec."Contract ID");
        end else
            Error('Contract ID is missing in PDC record.');

        COASetup.Get();
        if COASetup."PDC Collection/Return" <> '' then
            PDCollection := COASetup."PDC Collection/Return"

        else
            Error('COA Setup doest not exist for PDC Collection/Return account');

        if COASetup."PDC Liabilities" <> '' then
            PDCLiabilities := COASetup."PDC Liabilities"

        else
            Error('COA Setup doest not exist for PDC Liabilities account');


        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", 'CASH RECE');
        GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
        GenJournalLine."Posting Date" := Today;
        if GenJournalLine.FindSet() then
            GenJournalLine.DeleteAll();


        LineNo := GenJournalLine."Line No." + 10000;
        Clear(GenJournalLine);
        GenJournalLine.Init();
        GenJournalLine."Journal Template Name" := 'CASH RECE';
        GenJournalLine."Journal Batch Name" := 'DEFAULT';
        GenJournalLine."Document No." := PDCTransactionRec."PDC ID";
        GenJournalLine."Posting Date" := PDCTransactionRec."Transaction Date";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Document Type" := GenJournalLine."Document Type"::" ";
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
        GenJournalLine."Account No." := PDCollection; // Customer from Payment Series
        GenJournalLine."Contract ID" := PDCTransactionRec."Contract ID";
        GenJournalLine.Description := ' Cheque Return - Cheque No. ' + PDCTransactionRec."Cheque Number";
        GenJournalLine.Validate(Amount, Round(-PDCTransactionRec.Amount));
        // GenJournalLine."Amount (LCY)" := GenJournalLine.Amount;
        GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine."Bal. Account No." := PDCLiabilities;


        GenJournalLine.Insert();

        GenJnlPostLine.RunWithCheck(GenJournalLine);


        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", 'CASH RECE');
        GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
        if GenJournalLine.FindSet() then
            GenJournalLine.DeleteAll();

        Message('Cash Receipt journal created successfully.');

    end;

    procedure PDCRetrivedTransaction(PDCTransactionRec: Record "PDC Transaction")
    var

        GenJournalLine: Record "Gen. Journal Line";
        COASetup: Record "COA Setup";

        CustRec: Record Customer;
        ContractRec: Record "Tenancy Contract";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";

        LineNo: Integer;
        PropertyClassification: Text[100];
        PDCReceived: Code[20];
        PDCLiabilities: Code[20];
    begin
        LineNo := 0;
        if PDCTransactionRec."Contract ID" <> 0 then begin
            ContractRec.Reset();
            ContractRec.SetRange("Contract ID", PDCTransactionRec."Contract ID"); // Use correct field name
            if ContractRec.FindFirst() then begin
                PropertyClassification := ContractRec."Property Classification";
                // update Customer as before
                if CustRec.Get(PDCTransactionRec."Tenant Id") then
                    if ContractRec."Property Classification" <> '' then begin
                        CustRec.Validate("Customer Posting Group", ContractRec."Property Classification");
                        CustRec.Validate("Gen. Bus. Posting Group", ContractRec."Property Classification");
                        CustRec.Modify();

                    end;


            end else
                Error('No contract found with ID %1', PDCTransactionRec."Contract ID");
        end else
            Error('Contract ID is missing in PDC record.');

        COASetup.Get();
        if COASetup."PDC Received" <> '' then
            PDCReceived := COASetup."PDC Received"

        else
            Error('COA Setup doest not exist for PDC Received account');

        if COASetup."PDC Liabilities" <> '' then
            PDCLiabilities := COASetup."PDC Liabilities"
        else
            Error('COA Setup doest not exist for PDC Liabilities account');


        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", 'CASH RECE');
        GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
        GenJournalLine."Posting Date" := Today;
        if GenJournalLine.FindSet() then
            GenJournalLine.DeleteAll();

        LineNo := GenJournalLine."Line No." + 10000;
        Clear(GenJournalLine);
        GenJournalLine.Init();
        GenJournalLine."Journal Template Name" := 'CASH RECE';
        GenJournalLine."Journal Batch Name" := 'DEFAULT';
        GenJournalLine."Document No." := PDCTransactionRec."PDC ID";
        GenJournalLine."Posting Date" := PDCTransactionRec."Transaction Date";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Document Type" := GenJournalLine."Document Type"::" ";
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
        GenJournalLine."Account No." := PDCReceived; // Customer from Payment Series
        GenJournalLine."Contract ID" := PDCTransactionRec."Contract ID";
        GenJournalLine.Description := ' PDC Retrieval - Cheque No. ' + PDCTransactionRec."Cheque Number";
        GenJournalLine.Validate(Amount, Round(-PDCTransactionRec.Amount));
        // GenJournalLine."Amount (LCY)" := GenJournalLine.Amount;
        GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine."Bal. Account No." := PDCLiabilities;


        GenJournalLine.Insert();

        GenJnlPostLine.RunWithCheck(GenJournalLine);


        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", 'CASH RECE');
        GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
        if GenJournalLine.FindSet() then
            GenJournalLine.DeleteAll();

        Message('Cash Receipt journal created successfully.');

    end;
}