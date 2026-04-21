
codeunit 73209591 "Final Settlement Posting Mgt."
{
    procedure PostFinalSettlementAmount(FinalSettlement: Record "FinalSettlement")
    var
        GenJnlLine: Record "Gen. Journal Line";
        CustomerCard: Record Customer;
        BankAccount: Record "Bank Account";
        GLSetup: Record "General Ledger Setup";
        FinalcalculationRec: Record "Final Calculation";
        COASetup: Record "COA Setup";
        PostedSalesInvoice: Record "Sales Invoice Header";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        LineNo: Integer;
        DocNo: Code[20];
        Amount: Decimal;
        PendingAmount: Decimal;
        TenantName: Text[100];
        JournalTemplateName: Code[10];
        JournalBatchName: Code[10];
        respectiveAccountNo: Code[20];
        balAccountType: Enum "Gen. Journal Account Type";
    begin
        // Load G/L Setup for rounding
        GLSetup.Get();
        GenJnlLine.DeleteAll();
        // Check if there's any amount to post
        Amount := FinalSettlement."Receivable Total Amount";
        if Amount = 0 then
            Error('Final Settlement Amount is zero. Cannot post.');

        // Round the amount according to G/L setup
        Amount := Round(Amount, GLSetup."Amount Rounding Precision");

        // Set Journal Template and Batch
        JournalTemplateName := 'CASH RECE';
        JournalBatchName := 'DEFAULT';

        FinalcalculationRec.Reset();
        FinalcalculationRec.SetRange("Contract ID", FinalSettlement."Contract ID");
        if not FinalcalculationRec.FindFirst() then
            Error('Contract not found for Contract ID %1', FinalSettlement."Contract ID");

        TenantName := FinalcalculationRec."Tenant Name";

        if FinalcalculationRec."Unit Type" <> '' then begin
            CustomerCard.Reset();
            CustomerCard.SetRange("No.", FinalSettlement."Tenant ID");
            if CustomerCard.FindFirst() then begin
                CustomerCard.Validate("Gen. Bus. Posting Group", FinalcalculationRec."Unit Type");
                CustomerCard.Validate("Customer Posting Group", FinalcalculationRec."Unit Type");
                CustomerCard.Modify();
            end;
        end;

        PendingAmount := Round(FinalSettlement."Receivable from the Tenant", 0.01);

        // Find Bank Account
        if FinalSettlement."Receivable Payment mode" = 'Cash' then begin
            COASetup.Get();
            if COASetup.Cash <> '' then begin
                respectiveAccountNo := COASetup.Cash;
                balAccountType := balAccountType::"G/L Account";
            end
            else
                Error('COA Setup doest not exist for Cash Payment');
        end
        else begin
            respectiveAccountNo := '';
            BankAccount.Reset();
            BankAccount.SetRange("Search Name", FinalSettlement."Deposit Bank");
            if BankAccount.FindFirst() then
                if BankAccount."Bank Acc. Posting Group" <> '' then begin
                    respectiveAccountNo := BankAccount."No.";
                    balAccountType := balAccountType::"Bank Account";
                end
                else
                    Error('Bank Acc. Posting Group is blank in Bank Account %1', BankAccount."No.");
        end;

        // Generate Document No
        DocNo := 'FS-' + Format(FinalSettlement."Contract ID") + '-' + Format(FinalSettlement."FC ID");

        // Start with first line number
        LineNo := 10000;
        ClearJournalLines(JournalTemplateName, JournalBatchName);

        PostedSalesInvoice.SetRange("Contract ID", FinalSettlement."Contract ID");
        if PostedSalesInvoice.FindSet() then
            repeat
                PostedSalesInvoice.CalcFields("Remaining Amount");
                if PostedSalesInvoice."Remaining Amount" > 0 then begin
                    Clear(GenJnlLine);
                    CreateCashGeneralLines(GenJnlLine, JournalTemplateName, JournalBatchName, LineNo, DocNo, FinalSettlement, PostedSalesInvoice."No.", TenantName, respectiveAccountNo, balAccountType, PostedSalesInvoice."Remaining Amount");
                    LineNo += 10000;
                    PendingAmount -= PostedSalesInvoice."Remaining Amount";
                    PendingAmount := Round(PendingAmount, 0.01);
                end;
            until PostedSalesInvoice.Next() = 0;

        if PendingAmount > 0 then begin
            Clear(GenJnlLine);
            CreateCashGeneralLines(GenJnlLine, JournalTemplateName, JournalBatchName, LineNo, DocNo, FinalSettlement, '', TenantName, respectiveAccountNo, balAccountType, PendingAmount);
        end;

        GenJnlPost.Run(GenJnlLine);

        // Clean up journal lines
        ClearJournalLines(JournalTemplateName, JournalBatchName);

        Message('Final Settlement amount posted successfully. Total Receive: %1, Pending: %2', FinalcalculationRec."Total Receive", PendingAmount);
    end;

    procedure ClearJournalLines(JournalTemplateName: Code[10]; JournalBatchName: Code[10])
    var
        GenJnlLine: Record "Gen. Journal Line";
    begin

        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", JournalTemplateName);
        GenJnlLine.SetRange("Journal Batch Name", JournalBatchName);
        if GenJnlLine.FindSet() then
            GenJnlLine.DeleteAll(true);
    end;

    procedure CreateCashGeneralLines(var GenJnlLine: Record "Gen. Journal Line"; JournalTemplateName: Code[10]; JournalBatchName: Code[10]; LineNo: Integer; DocNo: Code[20]; FinalSettlement: Record FinalSettlement; postedSalesInvoice: Code[20]; TenantName: Text[100]; respectiveAccountNo: Code[20]; balAccountType: Enum "Gen. Journal Account Type"; remainingAmount: Decimal)
    begin
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := JournalTemplateName;
        GenJnlLine."Journal Batch Name" := JournalBatchName;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Posting Date" := Today;
        GenJnlLine."Document No." := DocNo;
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        GenJnlLine."Account No." := FinalSettlement."Tenant ID";
        GenJnlLine.Description := TenantName;
        GenJnlLine."Contract ID" := FinalSettlement."Contract ID";
        if postedSalesInvoice <> '' then begin
            GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
            GenJnlLine."Applies-to Doc. No." := PostedSalesInvoice;
        end;
        GenJnlLine."Bal. Account Type" := balAccountType;
        GenJnlLine."Bal. Account No." := respectiveAccountNo;
        GenJnlLine.Validate(Amount, -remainingAmount);
        GenJnlLine.Insert();
    end;
}