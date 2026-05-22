codeunit 73209599 "Refund Settlement Posting Mgt."
{
    procedure PostRefundJournalLines(FinalSettlementRefund: Record "BLRFinalSettlementRefund")
    var
        GenJnlLine: Record "Gen. Journal Line";
        BankAccount: Record "Bank Account";
        customer: Record Customer;
        FinalcalculationRec: Record "BLRFinalCalculation"; // Adjust to your actual Contract table name
        COASetup: Record "BLRCOASetup";

        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        GenJnlTemplate: Code[10];
        GenJnlBatch: Code[10];
        LineNo: Integer;
        DocNo: Code[20];
        PostingDate: Date;
        TenantReceivableAccount: Code[20];
        NetRefundToTenant: Decimal;
        adjustsecurityDeposit: Decimal;
        adjustChillerDeposit: Decimal;
        adjustotherDeposit: Decimal;
        appliedamount: Decimal;
        balAccountType: Enum "Gen. Journal Account Type";
        respectiveaccount: Code[20];
    begin

        NetRefundToTenant := Round(FinalSettlementRefund."BLRNet Refund to the Tenant");
        adjustsecurityDeposit := FinalSettlementRefund."BLRAdjust Security Deposit";
        adjustChillerDeposit := FinalSettlementRefund."BLRAdjust Chiller Deposit";
        adjustotherDeposit := FinalSettlementRefund."BLRAdjust other deposit";

        PostingDate := Today();
        GenJnlTemplate := 'CASH RECE';
        GenJnlBatch := 'DEFAULT';
        ClearJournalLines(GenJnlTemplate, GenJnlBatch);

        FinalcalculationRec.Reset();
        FinalcalculationRec.SetRange("BLRFC ID", FinalSettlementRefund."BLRFC ID");
        if not FinalcalculationRec.FindFirst() then
            Error('Final Calculation not found for FC ID %1', FinalSettlementRefund."BLRFC ID")
        else
            if customer.FindFirst() then begin
                customer.Validate("Gen. Bus. Posting Group", FinalcalculationRec."BLRUnit Type");
                customer.Validate("Customer Posting Group", FinalcalculationRec."BLRUnit Type");
                customer.Modify();
                TenantReceivableAccount := customer."No.";
            end;

        if FinalSettlementRefund."BLRRefund Payment mode" = 'Cash' then begin
            COASetup.Get();
            if COASetup."BLRCash" <> '' then begin
                respectiveaccount := COASetup."BLRCash";
                balAccountType := balAccountType::"G/L Account";
            end
            else
                Error('COA Setup doest not exist for Cash Payment');
        end
        else begin
            respectiveaccount := '';
            BankAccount.Reset();
            BankAccount.SetRange("Search Name", FinalSettlementRefund."BLRDeposit Bank");
            if BankAccount.FindFirst() then
                if BankAccount."Bank Acc. Posting Group" <> '' then begin
                    respectiveaccount := BankAccount."No.";
                    balAccountType := balAccountType::"Bank Account";
                end
                else
                    Error('Bank Acc. Posting Group is blank in Bank Account %1', BankAccount."No.");
        end;

        DocNo := 'RFND-' + Format(FinalSettlementRefund."BLRContract ID") + '-' + Format(FinalSettlementRefund."BLRFC ID");

        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", GenJnlTemplate);
        GenJnlLine.SetRange("Journal Batch Name", GenJnlBatch);
        if GenJnlLine.FindLast() then
            LineNo := GenJnlLine."Line No." + 10000
        else
            LineNo := 10000;

        if FinalSettlementRefund."BLRAdjust other deposit" > 0 then begin
            AppliedAmount := Round(Min(adjustotherDeposit, NetRefundToTenant));
            GenJnlLine.Init();
            GenJnlLine."Journal Template Name" := 'CASH RECE';
            GenJnlLine."Journal Batch Name" := 'DEFAULT';
            GenJnlLine."Line No." := LineNo;
            GenJnlLine."Posting Date" := PostingDate;
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
            GenJnlLine."Document No." := DocNo;
            GenJnlLine.Description := 'Refund Other Deposit';
            GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Customer);
            GenJnlLine.Validate("Account No.", FinalSettlementRefund."BLRTenant ID");
            GenJnlLine.Validate(Amount, Round(appliedamount));
            GenJnlLine."BLRContract ID" := FinalSettlementRefund."BLRContract ID";
            GenJnlLine.Validate("Bal. Account Type", balAccountType);
            GenJnlLine.Validate("Bal. Account No.", respectiveaccount);
            GenJnlLine.Insert(true);
            NetRefundToTenant -= AppliedAmount;
            adjustotherDeposit -= AppliedAmount;
            LineNo += 10000;
        end;

        if FinalSettlementRefund."BLRAdjust Chiller Deposit" > 0 then begin
            AppliedAmount := Round(Min(adjustChillerDeposit, NetRefundToTenant));
            GenJnlLine.Init();
            GenJnlLine."Journal Template Name" := 'CASH RECE';
            GenJnlLine."Journal Batch Name" := 'DEFAULT';
            GenJnlLine."Line No." := LineNo;
            GenJnlLine."Posting Date" := PostingDate;
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
            GenJnlLine."Document No." := DocNo;
            GenJnlLine.Description := 'Refund Chiller Deposit';
            GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Customer);
            GenJnlLine.Validate("Account No.", FinalSettlementRefund."BLRTenant ID");
            GenJnlLine.Validate(Amount, Round(appliedamount));
            GenJnlLine."BLRContract ID" := FinalSettlementRefund."BLRContract ID";
            GenJnlLine.Validate("Bal. Account Type", balAccountType);
            GenJnlLine.Validate("Bal. Account No.", respectiveaccount);
            GenJnlLine.Insert(true);
            NetRefundToTenant -= AppliedAmount;
            adjustChillerDeposit -= AppliedAmount;
            LineNo += 10000;
        end;

        if FinalSettlementRefund."BLRAdjust Security Deposit" > 0 then begin
            AppliedAmount := Round(Min(adjustsecurityDeposit, NetRefundToTenant));
            GenJnlLine.Init();
            GenJnlLine."Journal Template Name" := 'CASH RECE';
            GenJnlLine."Journal Batch Name" := 'DEFAULT';
            GenJnlLine."Line No." := LineNo;
            GenJnlLine."Posting Date" := PostingDate;
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
            GenJnlLine."Document No." := DocNo;
            GenJnlLine.Description := 'Refund Security Deposit';
            GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Customer);
            GenJnlLine.Validate("Account No.", FinalSettlementRefund."BLRTenant ID");
            GenJnlLine.Validate(Amount, Round(appliedamount));
            GenJnlLine."BLRContract ID" := FinalSettlementRefund."BLRContract ID";
            GenJnlLine.Validate("Bal. Account Type", balAccountType);
            GenJnlLine.Validate("Bal. Account No.", respectiveaccount);
            GenJnlLine.Insert(true);
            NetRefundToTenant -= AppliedAmount;
            adjustsecurityDeposit -= AppliedAmount;
            LineNo += 10000;
        end;

        if (adjustsecurityDeposit = 0) and (adjustChillerDeposit = 0) and (adjustotherDeposit = 0) then
            if NetRefundToTenant > 0 then begin
                AppliedAmount := Round(NetRefundToTenant);
                GenJnlLine.Init();
                GenJnlLine."Journal Template Name" := 'CASH RECE';
                GenJnlLine."Journal Batch Name" := 'DEFAULT';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := PostingDate;
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Refund;
                GenJnlLine."Document No." := DocNo;
                GenJnlLine.Description := 'Refund to Tenant';
                GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Customer);
                GenJnlLine.Validate("Account No.", FinalSettlementRefund."BLRTenant ID");
                GenJnlLine.Validate(Amount, Round(appliedamount));
                GenJnlLine."BLRContract ID" := FinalSettlementRefund."BLRContract ID";
                GenJnlLine.Validate("Bal. Account Type", balAccountType);
                GenJnlLine.Validate("Bal. Account No.", respectiveaccount);
                GenJnlLine.Insert(true);
                NetRefundToTenant -= AppliedAmount;
                LineNo += 10000;
            end;
        GenJnlPost.Run(GenJnlLine);
    end;

    local procedure ClearJournalLines(TemplateName: Code[10]; BatchName: Code[10])
    var
        GenJnlLine: Record "Gen. Journal Line";
    begin
        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", TemplateName);
        GenJnlLine.SetRange("Journal Batch Name", BatchName);
        if GenJnlLine.FindSet() then
            GenJnlLine.DeleteAll(true);
    end;

    local procedure Min(a: Decimal; b: Decimal): Decimal
    begin
        if a < b then
            exit(a)
        else
            exit(b);
    end;
}