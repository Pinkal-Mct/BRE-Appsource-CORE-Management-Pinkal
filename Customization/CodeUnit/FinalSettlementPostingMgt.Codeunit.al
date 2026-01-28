
codeunit 50108 "Final Settlement Posting Mgt."
{
    procedure PostFinalSettlementAmount(FinalSettlement: Record "FinalSettlement")
    var
        GenJnlLine: Record "Gen. Journal Line";
        PendingReceivableRID: Record "Pending Receviable Grid";
        CustomerCard: Record Customer;
        BankAccount: Record "Bank Account";
        GLSetup: Record "General Ledger Setup";
        InvoiceCreditNoteSummary: Record InvoiceCreditNoteSummary;
        FinalcalculationRec: Record "Final Calculation";
        COASetup: Record "COA Setup";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        LineNo: Integer;
        DocNo: Code[20];
        Amount: Decimal;
        PendingAmount: Decimal;
        TenantName: Text[100];
        InvoicsummaryID: Code[20];
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

        // Get pending receivable information
        PendingReceivableRID.Reset();
        PendingReceivableRID.SetRange("Contract ID", FinalSettlement."Contract ID");
        if PendingReceivableRID.FindFirst() then
            PendingAmount := PendingReceivableRID."Total Receivable"
        else
            PendingAmount := 0;

        InvoiceCreditNoteSummary.Reset();
        InvoiceCreditNoteSummary.SetRange("Contract No.", FinalSettlement."Contract ID");
        if InvoiceCreditNoteSummary.FindFirst() then
            InvoicsummaryID := CopyStr(InvoiceCreditNoteSummary."Invoice ID", 1, 20);

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

        Clear(GenJnlLine);
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

        if ValidateInvoice(InvoicsummaryID) then begin

            GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
            GenJnlLine."Applies-to Doc. No." := InvoicsummaryID;
        end;

        GenJnlLine."Bal. Account Type" := balAccountType;
        GenJnlLine."Bal. Account No." := respectiveAccountNo;
        GenJnlLine.Validate(Amount, -FinalSettlement."Receivable Total Amount");

        GenJnlPost.Run(GenJnlLine);

        // Clean up journal lines
        ClearJournalLines(JournalTemplateName, JournalBatchName);

        Message('Final Settlement amount posted successfully. Total Receive: %1, Pending: %2', FinalcalculationRec."Total Receive", PendingAmount);
    end;

    procedure ValidateInvoice(invoiceId: Code[20]): Boolean
    var
        postedSalesInvoice: Record "Sales Invoice Header";
    begin
        if postedSalesInvoice.Get(invoiceId) then begin
            postedSalesInvoice.CalcFields("Remaining Amount");
            if postedSalesInvoice."Remaining Amount" > 0 then
                exit(true)
            else
                exit(false);
        end
        else
            exit(false);
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
}