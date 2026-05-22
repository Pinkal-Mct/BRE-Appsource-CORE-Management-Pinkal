codeunit 73209580 "Cash Receipt Journal Entry"
{
    Subtype = Normal;
    trigger OnRun()
    begin
    end;

    procedure CreateCashReceiptJournal(PDCTransRec: Record "BLRPDCTransaction"; postingDate: Date)
    var
        PaymentSeriesRec: Record "BLRPaymentMode2"; // Your Payment Series Table
        PaymentScheduleRec: Record "BLRPaymentSchedule2"; // Your Payment Schedule Table
        COASetup: Record "BLRCOASetup";
        BankAccountRec: Record "Bank Account";
        GenJournalLineRec: Record "Gen. Journal Line";
        CustRec: Record Customer;
        ContractRec: Record "BLRTenancyContract";
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
        PaymentSeriesRec.SetFilter("BLRPayment Series", '%1', PDCTransRec."BLRpayment Series");
        PaymentSeriesRec.SetFilter("BLRContract ID", Format(PDCTransRec."BLRContract ID"));
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
            ContractRec.SetRange("BLRContract ID", PaymentSeriesRec."BLRContract ID");
            if ContractRec.FindFirst() then
                // update Customer as before
                PropertyClassification := ContractRec."BLRProperty Classification";
            if CustRec.Get(PaymentSeriesRec."BLRTenant Id") then
                if ContractRec."BLRProperty Classification" <> '' then begin
                    CustRec.Validate("Customer Posting Group", ContractRec."BLRProperty Classification");
                    CustRec.Validate("Gen. Bus. Posting Group", ContractRec."BLRProperty Classification");
                    CustRec.Modify();

                end;



            ///////////////////////// COA Setup /////////////////////////////

            COASetup.Get();
            if PaymentSeriesRec."BLRPayment Mode" = 'Cheque' then begin
                if COASetup."BLRPDC Collection/Return" <> '' then
                    PDCCollection := COASetup."BLRPDC Collection/Return"

                else
                    Error('COA Setup doest not exist for PDC Collection/Return account');

                if COASetup."BLRPDC Liabilities" <> '' then
                    PDCLiabilities := COASetup."BLRPDC Liabilities"

                else
                    Error('COA Setup doest not exist for PDC Liabilities account');

                BankAccountRec.Reset();
                BankAccountRec.SetRange("Search Name", PaymentSeriesRec."BLRDeposit Bank");
                if BankAccountRec.FindSet() then
                    if BankAccountRec."Bank Acc. Posting Group" <> ''
                    then
                        BankaccountNo := BankAccountRec."No."
                    else
                        Error('Bank Account Posting Group is blank in Bank Account %1', BankAccountRec."No.");

            end else begin

                BankAccountRec.Reset();
                BankAccountRec.SetRange("Search Name", PaymentSeriesRec."BLRDeposit Bank");
                if BankAccountRec.FindFirst() then
                    if BankAccountRec."Bank Acc. Posting Group" <> ''
                    then
                        BankaccountNo := BankAccountRec."No."
                    else
                        Error('Bank Account Posting Group is blank in Bank Account %1', BankAccountRec."No.")

                else

                    if COASetup."BLRCash" <> '' then
                        CashAccount := COASetup."BLRCash"
                    else
                        Error('COA Setup doest not exist for Cash account');

            end;



            ////////////////////////////// END COA Setup /////////////////////////

            // Loop through Payment Schedule and create individual lines
            PaymentScheduleRec.SetRange("BLRPayment Series", PaymentSeriesRec."BLRPayment Series");
            PaymentScheduleRec.SetRange("BLRContract ID", PaymentSeriesRec."BLRContract ID");
            if not PaymentScheduleRec.IsEmpty() then begin
                LineNumber := 0;

                LineNumber := GenJournalLineRec."Line No." + 10000;


                Clear(GenJournalLineRec);
                GenJournalLineRec.Init();
                GenJournalLineRec."Journal Template Name" := 'CASH RECE';
                GenJournalLineRec."Journal Batch Name" := 'DEFAULT';
                GenJournalLineRec."Document No." := Format(PaymentSeriesRec."BLREntry No.");
                GenJournalLineRec."Posting Date" := postingDate;
                GenJournalLineRec."Line No." := LineNumber;
                GenJournalLineRec."BLRContract ID" := PaymentSeriesRec."BLRContract ID";
                GenJournalLineRec."Document Type" := GenJournalLineRec."Document Type"::Payment;


                GenJournalLineRec.Validate("Account Type", GenJournalLineRec."Account Type"::"G/L Account");
                GenJournalLineRec.Validate("Account No.", PDCCollection);
                GenJournalLineRec.Description := 'Cheque Clearnace - ' + PaymentSeriesRec."BLRCheque Number"; // Customer from Payment Series
                GenJournalLineRec.Validate(Amount, Round(-PaymentSeriesRec."BLRAmount Including VAT"));
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

    procedure PDCClearanceLiabilities(PDCTransRec: Record "BLRPDCTransaction"; postingDate: Date; PDCLiabilities: Code[20])
    var
        PaymentSeriesRec: Record "BLRPaymentMode2"; // Your Payment Series Table
        PaymentScheduleRec: Record "BLRPaymentSchedule2"; // Your Payment Schedule Table
        GenJournalLineRec: Record "Gen. Journal Line";
        PostedSalesInvoice: Record "Sales Invoice Header";
        ContractRec: Record "BLRTenancyContract";

        CustRec: Record Customer;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        LineNumber: Integer;

        PropertyClassification: Text[100];

    begin
        PaymentSeriesRec.Reset();
        PaymentSeriesRec.SetFilter("BLRPayment Series", '%1', PDCTransRec."BLRpayment Series");
        PaymentSeriesRec.SetFilter("BLRContract ID", Format(PDCTransRec."BLRContract ID"));
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
            ContractRec.SetRange("BLRContract ID", PaymentSeriesRec."BLRContract ID");
            if ContractRec.FindFirst() then
                // update Customer as before
                PropertyClassification := ContractRec."BLRProperty Classification";
            if CustRec.Get(PaymentSeriesRec."BLRTenant Id") then
                if ContractRec."BLRProperty Classification" <> '' then begin
                    CustRec.Validate("Customer Posting Group", ContractRec."BLRProperty Classification");
                    CustRec.Validate("Gen. Bus. Posting Group", ContractRec."BLRProperty Classification");
                    CustRec.Modify();
                end;

            PaymentScheduleRec.SetRange("BLRPayment Series", PaymentSeriesRec."BLRPayment Series");
            PaymentScheduleRec.SetRange("BLRContract ID", PaymentSeriesRec."BLRContract ID");
            if not PaymentScheduleRec.IsEmpty() then begin
                LineNumber := 0;

                LineNumber := GenJournalLineRec."Line No." + 10000;

                Clear(GenJournalLineRec);
                GenJournalLineRec.Init();
                GenJournalLineRec."Journal Template Name" := 'CASH RECE';
                GenJournalLineRec."Journal Batch Name" := 'DEFAULT';
                GenJournalLineRec."Document No." := Format(PaymentSeriesRec."BLREntry No.");
                GenJournalLineRec."Posting Date" := postingDate;
                GenJournalLineRec."Line No." := LineNumber;
                GenJournalLineRec."BLRContract ID" := PaymentSeriesRec."BLRContract ID";
                GenJournalLineRec."Document Type" := GenJournalLineRec."Document Type"::Payment;


                GenJournalLineRec."Account Type" := GenJournalLineRec."Account Type"::Customer;
                GenJournalLineRec.Validate("Account Type", GenJournalLineRec."Account Type"::Customer);
                GenJournalLineRec.Validate("Account No.", PaymentSeriesRec."BLRTenant Id"); // Customer from Payment Series
                GenJournalLineRec.Description := 'Cheque Clearnace - ' + PaymentSeriesRec."BLRCheque Number"; // Customer from Payment Series
                GenJournalLineRec.Validate(Amount, Round(-PaymentSeriesRec."BLRAmount Including VAT"));
                GenJournalLineRec."Bal. Account Type" := GenJournalLineRec."Bal. Account Type"::"G/L Account";
                GenJournalLineRec."Bal. Account No." := PDCLiabilities;

                PostedSalesInvoice.SetRange("No.", PaymentSeriesRec."BLRInvoice #");
                PostedSalesInvoice.SetFilter("Posting Date", '>%1', postingDate);
                if not PostedSalesInvoice.IsEmpty() then
                    Message('Please apply the entries (Receipt with Invoice) manually in the system as there are posted invoices with posting date later than Receipt date.')
                else begin
                    GenJournalLineRec.Validate("Applies-to Doc. Type", GenJournalLineRec."Applies-to Doc. Type"::Invoice);
                    GenJournalLineRec.Validate("Applies-to Doc. No.", PaymentSeriesRec."BLRInvoice #");
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

    procedure PaymentReceivedTransaction(PaymentSeriesRec: Record "BLRPaymentMode2"; postingDate: Date)
    var

        GenJournalLineRec: Record "Gen. Journal Line";
        PostedSalesInvoice: Record "Sales Invoice Header";
        COASetup: Record "BLRCOASetup";
        // GenJournalBatchRec: Record "Gen. Journal Batch";

        ContractRec: Record "BLRTenancyContract";
        BankAccountRec: Record "Bank Account";
        CustRec: Record Customer;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        LineNo: Integer;

        PropertyClassification: Text[100];

        CashAccount: Code[20];
        BankaccountNo: Code[20];

    begin
        LineNo := 0;
        if PaymentSeriesRec."BLRContract ID" <> 0 then begin
            ContractRec.Reset();
            ContractRec.SetRange("BLRContract ID", PaymentSeriesRec."BLRContract ID"); // Use correct field name
            if ContractRec.FindFirst() then begin
                PropertyClassification := ContractRec."BLRProperty Classification";
                // update Customer as before
                if CustRec.Get(PaymentSeriesRec."BLRTenant Id") then
                    if ContractRec."BLRProperty Classification" <> '' then begin
                        CustRec.Validate("Customer Posting Group", ContractRec."BLRProperty Classification");
                        CustRec.Validate("Gen. Bus. Posting Group", ContractRec."BLRProperty Classification");
                        CustRec.Modify();

                    end

            end else
                Error('No contract found with ID %1', PaymentSeriesRec."BLRContract ID");
        end else
            Error('Contract ID is missing in Payment Mode record.');

        ///////////////////////// COA Setup /////////////////////////////

        BankAccountRec.Reset();
        BankAccountRec.SetRange("Search Name", PaymentSeriesRec."BLRDeposit Bank");
        if BankAccountRec.FindSet() then begin
            if BankAccountRec."Bank Acc. Posting Group" <> ''
            then
                BankaccountNo := BankAccountRec."No."
            else
                Error('Bank Account Posting Group is blank in Bank Account %1', BankAccountRec."No.");
        end
        else begin
            COASetup.Get();
            if COASetup."BLRCash" <> '' then
                CashAccount := COASetup."BLRCash"
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
        GenJournalLineRec."Document No." := Format(PaymentSeriesRec."BLREntry No.");
        GenJournalLineRec."Posting Date" := postingDate;
        GenJournalLineRec."Line No." := LineNo;
        GenJournalLineRec."Document Type" := GenJournalLineRec."Document Type"::Payment;
        GenJournalLineRec.Validate("Account Type", GenJournalLineRec."Account Type"::Customer);
        GenJournalLineRec.Validate("Account No.", PaymentSeriesRec."BLRTenant Id"); // Customer from Payment Series
        GenJournalLineRec.Description := 'Payment Received - ' + PaymentSeriesRec."BLRInvoice #";

        GenJournalLineRec."BLRContract ID" := PaymentSeriesRec."BLRContract ID";

        GenJournalLineRec.Validate(Amount, Round(-PaymentSeriesRec."BLRAmount Including VAT"));
        // GenJournalLineRec."Amount (LCY)" := GenJournalLineRec.Amount;
        BankAccountRec.Reset();
        BankAccountRec.SetRange("Search Name", PaymentSeriesRec."BLRDeposit Bank");
        if not BankAccountRec.IsEmpty() then begin
            GenJournalLineRec."Bal. Account Type" := GenJournalLineRec."Bal. Account Type"::"Bank Account";
            GenJournalLineRec."Bal. Account No." := BankaccountNo;

            PostedSalesInvoice.SetRange("No.", PaymentSeriesRec."BLRInvoice #");
            PostedSalesInvoice.SetFilter("Posting Date", '>%1', postingDate);
            if not PostedSalesInvoice.IsEmpty() then
                Message('Please apply the entries (Receipt with Invoice) manually in the system as there are posted invoices with posting date later than Receipt date.')
            else begin

                GenJournalLineRec.Validate("Applies-to Doc. Type", GenJournalLineRec."Applies-to Doc. Type"::Invoice);
                GenJournalLineRec.Validate("Applies-to Doc. No.", PaymentSeriesRec."BLRInvoice #");
            end;
        end
        else begin
            GenJournalLineRec."Bal. Account Type" := GenJournalLineRec."Bal. Account Type"::"G/L Account";
            GenJournalLineRec."Bal. Account No." := CashAccount;

            PostedSalesInvoice.SetRange("No.", PaymentSeriesRec."BLRInvoice #");
            PostedSalesInvoice.SetFilter("Posting Date", '>%1', postingDate);
            if not PostedSalesInvoice.IsEmpty() then
                Message('Please apply the entries (Receipt with Invoice) manually in the system as there are posted invoices with posting date later than Receipt date.')
            else begin
                GenJournalLineRec.Validate("Applies-to Doc. Type", GenJournalLineRec."Applies-to Doc. Type"::Invoice);
                GenJournalLineRec.Validate("Applies-to Doc. No.", PaymentSeriesRec."BLRInvoice #");
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



    procedure PDCReceivedTransaction(PDCTransactionRec: Record "BLRPDCTransaction")
    var
        GenJournalLine: Record "Gen. Journal Line";
        CustRec: Record Customer;
        ContractRec: Record "BLRTenancyContract";
        COASetup: Record "BLRCOASetup";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        LineNo: Integer;
        PropertyClassification: Text[100];
        PDCReceived: Code[20];
        PDCLiabilities: Code[20];

    begin
        LineNo := 0;
        if PDCTransactionRec."BLRContract ID" <> 0 then begin
            ContractRec.Reset();
            ContractRec.SetRange("BLRContract ID", PDCTransactionRec."BLRContract ID"); // Use correct field name
            if ContractRec.FindFirst() then begin
                PropertyClassification := ContractRec."BLRProperty Classification";
                // update Customer as before
                if CustRec.Get(PDCTransactionRec."BLRTenant Id") then
                    if ContractRec."BLRProperty Classification" <> '' then begin
                        CustRec.Validate("Customer Posting Group", ContractRec."BLRProperty Classification");
                        CustRec.Validate("Gen. Bus. Posting Group", ContractRec."BLRProperty Classification");
                        CustRec.Modify();

                    end;

            end else
                Error('No contract found with ID %1', PDCTransactionRec."BLRContract ID");
        end else
            Error('Contract ID is missing in PDC record.');

        ///////////////////////// COA Setup /////////////////////////////

        COASetup.Get();
        if COASetup."BLRPDC Received" <> '' then
            PDCReceived := COASetup."BLRPDC Received"

        else
            Error('COA Setup doest not exist for PDC Received account');
        COASetup.Get();
        if COASetup."BLRPDC Liabilities" <> '' then
            PDCLiabilities := COASetup."BLRPDC Liabilities"

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
        GenJournalLine."Document No." := PDCTransactionRec."BLRPDC ID";
        GenJournalLine."Posting Date" := PDCTransactionRec."BLRTransaction Date";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Document Type" := GenJournalLine."Document Type"::Payment;
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
        GenJournalLine."Account No." := PDCLiabilities; // Customer from Payment Series
        GenJournalLine."BLRContract ID" := PDCTransactionRec."BLRContract ID";
        GenJournalLine.Description := 'PDC Received - Cheque No. ' + PDCTransactionRec."BLRCheque Number";
        GenJournalLine.Validate(Amount, Round(-PDCTransactionRec."BLRAmount"));
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




    procedure ReversePDCReceivedTransaction(PDCTransactionRec: Record "BLRPDCTransaction"; SplitCombineMethod: Text[50]; TransactionDate: Date)
    var

        GenJournalLine: Record "Gen. Journal Line";

        COASetup: Record "BLRCOASetup";

        CustRec: Record Customer;
        ContractRec: Record "BLRTenancyContract";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";

        PropertyClassification: Text[100];
        LineNo: Integer;
        PDCReceived: Code[20];
        PDCLiabilities: Code[20];

    begin
        LineNo := 0;
        if PDCTransactionRec."BLRContract ID" <> 0 then begin
            ContractRec.Reset();
            ContractRec.SetRange("BLRContract ID", PDCTransactionRec."BLRContract ID"); // Use correct field name
            if ContractRec.FindFirst() then begin
                PropertyClassification := ContractRec."BLRProperty Classification";
                // update Customer as before
                if CustRec.Get(PDCTransactionRec."BLRTenant Id") then
                    if ContractRec."BLRProperty Classification" <> '' then begin
                        CustRec.Validate("Customer Posting Group", ContractRec."BLRProperty Classification");
                        CustRec.Validate("Gen. Bus. Posting Group", ContractRec."BLRProperty Classification");
                        CustRec.Modify();

                    end;


            end else
                Error('No contract found with ID %1', PDCTransactionRec."BLRContract ID");
        end else
            Error('Contract ID is missing in PDC record.');

        ///////////////////////// COA Setup /////////////////////////////

        COASetup.Get();
        if COASetup."BLRPDC Received" <> '' then
            PDCReceived := COASetup."BLRPDC Received"
        else
            Error('COA Setup doest not exist for PDC Received account');
        COASetup.Get();
        if COASetup."BLRPDC Liabilities" <> '' then
            PDCLiabilities := COASetup."BLRPDC Liabilities"

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
        GenJournalLine."Document No." := PDCTransactionRec."BLRPDC ID";
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Document Type" := GenJournalLine."Document Type"::Payment;
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
        GenJournalLine."Account No." := PDCReceived; // Customer from Payment Series
        GenJournalLine."BLRContract ID" := PDCTransactionRec."BLRContract ID";
        GenJournalLine.Description := 'Cheque #' + PDCTransactionRec."BLRCheque Number" + ' voided- ' + SplitCombineMethod;
        GenJournalLine.Validate(Amount, Round(-PDCTransactionRec."BLRAmount"));
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



    procedure PDCDepositedTransaction(PDCTransactionRec: Record "BLRPDCTransaction")
    var

        GenJournalLine: Record "Gen. Journal Line";
        COASetup: Record "BLRCOASetup";

        CustRec: Record Customer;
        ContractRec: Record "BLRTenancyContract";

        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        LineNo: Integer;
        PropertyClassification: Text[100];
        PDCollection: Code[20];
        PDCReceived: Code[20];
    begin
        LineNo := 0;
        if PDCTransactionRec."BLRContract ID" <> 0 then begin
            ContractRec.Reset();
            ContractRec.SetRange("BLRContract ID", PDCTransactionRec."BLRContract ID"); // Use correct field name
            if ContractRec.FindFirst() then begin
                PropertyClassification := ContractRec."BLRProperty Classification";
                // update Customer as before
                if CustRec.Get(PDCTransactionRec."BLRTenant Id") then
                    if ContractRec."BLRProperty Classification" <> '' then begin
                        CustRec.Validate("Customer Posting Group", ContractRec."BLRProperty Classification");
                        CustRec.Validate("Gen. Bus. Posting Group", ContractRec."BLRProperty Classification");
                        CustRec.Modify();

                    end;


            end else
                Error('No contract found with ID %1', PDCTransactionRec."BLRContract ID");
        end else
            Error('Contract ID is missing in PDC record.');

        COASetup.Get();
        if COASetup."BLRPDC Collection/Return" <> '' then
            PDCollection := COASetup."BLRPDC Collection/Return"

        else
            Error('COA Setup doest not exist for PDC Collection/Return account');

        if COASetup."BLRPDC Received" <> '' then
            PDCReceived := COASetup."BLRPDC Received"

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
        GenJournalLine."Document No." := PDCTransactionRec."BLRPDC ID";
        GenJournalLine."Posting Date" := PDCTransactionRec."BLRTransaction Date";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Document Type" := GenJournalLine."Document Type"::" ";
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
        GenJournalLine."Account No." := PDCReceived; // Customer from Payment Series
        GenJournalLine."BLRContract ID" := PDCTransactionRec."BLRContract ID";
        GenJournalLine.Description := ' Cheque Deposit - Cheque No. ' + PDCTransactionRec."BLRCheque Number";
        GenJournalLine.Validate(Amount, Round(-PDCTransactionRec."BLRAmount"));
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


    procedure PDCReturnedTransaction(PDCTransactionRec: Record "BLRPDCTransaction")
    var

        GenJournalLine: Record "Gen. Journal Line";
        CustRec: Record Customer;
        COASetup: Record "BLRCOASetup";
        ContractRec: Record "BLRTenancyContract";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        LineNo: Integer;


        PropertyClassification: Text[100];
        PDCollection: Code[20];
        PDCLiabilities: Code[20];
    begin
        LineNo := 0;
        if PDCTransactionRec."BLRContract ID" <> 0 then begin
            ContractRec.Reset();
            ContractRec.SetRange("BLRContract ID", PDCTransactionRec."BLRContract ID"); // Use correct field name
            if ContractRec.FindFirst() then begin
                PropertyClassification := ContractRec."BLRProperty Classification";
                // update Customer as before
                if CustRec.Get(PDCTransactionRec."BLRTenant Id") then
                    if ContractRec."BLRProperty Classification" <> '' then begin
                        CustRec.Validate("Customer Posting Group", ContractRec."BLRProperty Classification");
                        CustRec.Validate("Gen. Bus. Posting Group", ContractRec."BLRProperty Classification");
                        CustRec.Modify();

                    end;

            end else
                Error('No contract found with ID %1', PDCTransactionRec."BLRContract ID");
        end else
            Error('Contract ID is missing in PDC record.');

        COASetup.Get();
        if COASetup."BLRPDC Collection/Return" <> '' then
            PDCollection := COASetup."BLRPDC Collection/Return"

        else
            Error('COA Setup doest not exist for PDC Collection/Return account');

        if COASetup."BLRPDC Liabilities" <> '' then
            PDCLiabilities := COASetup."BLRPDC Liabilities"

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
        GenJournalLine."Document No." := PDCTransactionRec."BLRPDC ID";
        GenJournalLine."Posting Date" := PDCTransactionRec."BLRTransaction Date";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Document Type" := GenJournalLine."Document Type"::" ";
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
        GenJournalLine."Account No." := PDCollection; // Customer from Payment Series
        GenJournalLine."BLRContract ID" := PDCTransactionRec."BLRContract ID";
        GenJournalLine.Description := ' Cheque Return - Cheque No. ' + PDCTransactionRec."BLRCheque Number";
        GenJournalLine.Validate(Amount, Round(-PDCTransactionRec."BLRAmount"));
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

    procedure PDCRetrivedTransaction(PDCTransactionRec: Record "BLRPDCTransaction")
    var

        GenJournalLine: Record "Gen. Journal Line";
        COASetup: Record "BLRCOASetup";

        CustRec: Record Customer;
        ContractRec: Record "BLRTenancyContract";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";

        LineNo: Integer;
        PropertyClassification: Text[100];
        PDCReceived: Code[20];
        PDCLiabilities: Code[20];
    begin
        LineNo := 0;
        if PDCTransactionRec."BLRContract ID" <> 0 then begin
            ContractRec.Reset();
            ContractRec.SetRange("BLRContract ID", PDCTransactionRec."BLRContract ID"); // Use correct field name
            if ContractRec.FindFirst() then begin
                PropertyClassification := ContractRec."BLRProperty Classification";
                // update Customer as before
                if CustRec.Get(PDCTransactionRec."BLRTenant Id") then
                    if ContractRec."BLRProperty Classification" <> '' then begin
                        CustRec.Validate("Customer Posting Group", ContractRec."BLRProperty Classification");
                        CustRec.Validate("Gen. Bus. Posting Group", ContractRec."BLRProperty Classification");
                        CustRec.Modify();

                    end;


            end else
                Error('No contract found with ID %1', PDCTransactionRec."BLRContract ID");
        end else
            Error('Contract ID is missing in PDC record.');

        COASetup.Get();
        if COASetup."BLRPDC Received" <> '' then
            PDCReceived := COASetup."BLRPDC Received"

        else
            Error('COA Setup doest not exist for PDC Received account');

        if COASetup."BLRPDC Liabilities" <> '' then
            PDCLiabilities := COASetup."BLRPDC Liabilities"
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
        GenJournalLine."Document No." := PDCTransactionRec."BLRPDC ID";
        GenJournalLine."Posting Date" := PDCTransactionRec."BLRTransaction Date";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Document Type" := GenJournalLine."Document Type"::" ";
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
        GenJournalLine."Account No." := PDCReceived; // Customer from Payment Series
        GenJournalLine."BLRContract ID" := PDCTransactionRec."BLRContract ID";
        GenJournalLine.Description := ' PDC Retrieval - Cheque No. ' + PDCTransactionRec."BLRCheque Number";
        GenJournalLine.Validate(Amount, Round(-PDCTransactionRec."BLRAmount"));
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