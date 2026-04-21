codeunit 73209599 "Refund Settlement Posting Mgt."
{
    procedure PostRefundJournalLines(FinalSettlementRefund: Record "FinalSettlementRefund")
    var
        GenJnlLine: Record "Gen. Journal Line";
        TenantContract: Record "Final Calculation";
        BankAccount: Record "Bank Account";
        customer: Record Customer;
        FinalcalculationRec: Record "Final Calculation"; // Adjust to your actual Contract table name
        COASetup: Record "COA Setup";
        customerpostinggroup: Record "Customer Posting Group";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        GenJnlTemplate: Code[10];
        GenJnlBatch: Code[10];
        LineNo: Integer;
        DocNo: Code[20];
        PostingDate: Date;
        TenantReceivableAccount: Code[20];
        RefundOtherDepositGL: Code[20];
        RefundChillerDepositGL: Code[20];
        RefundSecurityDepositGL: Code[20];
        NetRefundToTenant: Decimal;
        adjustsecurityDeposit: Decimal;
        adjustChillerDeposit: Decimal;
        adjustotherDeposit: Decimal;
        appliedamount: Decimal;
        balAccountType: Enum "Gen. Journal Account Type";
        respectiveaccount: Code[20];
    begin
        RefundOtherDepositGL := '4508';
        RefundChillerDepositGL := '4508';
        RefundSecurityDepositGL := '4502';

        NetRefundToTenant := Round(FinalSettlementRefund."Net Refund to the Tenant");
        adjustsecurityDeposit := FinalSettlementRefund."Adjust Security Deposit";
        adjustChillerDeposit := FinalSettlementRefund."Adjust Chiller Deposit";
        adjustotherDeposit := FinalSettlementRefund."Adjust other deposit";

        PostingDate := Today();
        GenJnlTemplate := 'CASH RECE';
        GenJnlBatch := 'DEFAULT';
        ClearJournalLines(GenJnlTemplate, GenJnlBatch);

        FinalcalculationRec.Reset();
        FinalcalculationRec.SetRange("FC ID", FinalSettlementRefund."FC ID");
        if not FinalcalculationRec.FindFirst() then
            Error('Final Calculation not found for FC ID %1', FinalSettlementRefund."FC ID")
        else
            if customer.FindFirst() then begin
                customer.Validate("Gen. Bus. Posting Group", FinalcalculationRec."Unit Type");
                customer.Validate("Customer Posting Group", FinalcalculationRec."Unit Type");
                customer.Modify();
                TenantReceivableAccount := customer."No.";
            end;

        if FinalSettlementRefund."Refund Payment mode" = 'Cash' then begin
            COASetup.Get();
            if COASetup.Cash <> '' then begin
                respectiveaccount := COASetup.Cash;
                balAccountType := balAccountType::"G/L Account";
            end
            else
                Error('COA Setup doest not exist for Cash Payment');
        end
        else begin
            respectiveaccount := '';
            BankAccount.Reset();
            BankAccount.SetRange("Search Name", FinalSettlementRefund."Deposit Bank");
            if BankAccount.FindFirst() then
                if BankAccount."Bank Acc. Posting Group" <> '' then begin
                    respectiveaccount := BankAccount."No.";
                    balAccountType := balAccountType::"Bank Account";
                end
                else
                    Error('Bank Acc. Posting Group is blank in Bank Account %1', BankAccount."No.");
        end;

        DocNo := 'RFND-' + Format(FinalSettlementRefund."Contract ID") + '-' + Format(FinalSettlementRefund."FC ID");

        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", GenJnlTemplate);
        GenJnlLine.SetRange("Journal Batch Name", GenJnlBatch);
        if GenJnlLine.FindLast() then
            LineNo := GenJnlLine."Line No." + 10000
        else
            LineNo := 10000;

        if FinalSettlementRefund."Adjust other deposit" > 0 then begin
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
            GenJnlLine.Validate("Account No.", FinalSettlementRefund."Tenant ID");
            GenJnlLine.Validate(Amount, Round(appliedamount));
            GenJnlLine."Contract ID" := FinalSettlementRefund."Contract ID";
            GenJnlLine.Validate("Bal. Account Type", balAccountType);
            GenJnlLine.Validate("Bal. Account No.", respectiveaccount);
            GenJnlLine.Insert(true);
            NetRefundToTenant -= AppliedAmount;
            adjustotherDeposit -= AppliedAmount;
            LineNo += 10000;
        end;

        if FinalSettlementRefund."Adjust Chiller Deposit" > 0 then begin
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
            GenJnlLine.Validate("Account No.", FinalSettlementRefund."Tenant ID");
            GenJnlLine.Validate(Amount, Round(appliedamount));
            GenJnlLine."Contract ID" := FinalSettlementRefund."Contract ID";
            GenJnlLine.Validate("Bal. Account Type", balAccountType);
            GenJnlLine.Validate("Bal. Account No.", respectiveaccount);
            GenJnlLine.Insert(true);
            NetRefundToTenant -= AppliedAmount;
            adjustChillerDeposit -= AppliedAmount;
            LineNo += 10000;
        end;

        if FinalSettlementRefund."Adjust Security Deposit" > 0 then begin
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
            GenJnlLine.Validate("Account No.", FinalSettlementRefund."Tenant ID");
            GenJnlLine.Validate(Amount, Round(appliedamount));
            GenJnlLine."Contract ID" := FinalSettlementRefund."Contract ID";
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
                GenJnlLine.Validate("Account No.", FinalSettlementRefund."Tenant ID");
                GenJnlLine.Validate(Amount, Round(appliedamount));
                GenJnlLine."Contract ID" := FinalSettlementRefund."Contract ID";
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
        if not GenJnlLine.IsEmpty() then
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