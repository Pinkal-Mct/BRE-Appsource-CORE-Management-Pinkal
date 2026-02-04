codeunit 50107 "Security Deposit Posting Mgt."
{
    procedure PostSecurityDepositAmount(SecurityDeposit: Record "Security Deposit")
    var
        GenJnlLine: Record "Gen. Journal Line";
        COASetup: Record "COA Setup";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        GenJnlTemplate: Code[10];
        GenJnlBatch: Code[10];
        Amount: Decimal;
        PropertyType: Text[30];
        TenantReceivableAccount: Code[20];
        CarryForwardOutAccount: Code[20];
        CarryForwardInAccount: Code[20];
        LineNo: Integer;
        DocNo: Code[20];
    begin
        GenJnlTemplate := 'CASH RECE';
        GenJnlBatch := 'DEFAULT';

        Amount := SecurityDeposit."Carry Forward Amount";
        PropertyType := SecurityDeposit."Property Classification";

        if Amount = 0 then
            Error('Security Deposit Amount Received is zero. Cannot post.');

        COASetup.Get();
        if PropertyType = 'Residential' then begin
            if COASetup."Tenant Receivables-Residential" <> '' then
                TenantReceivableAccount := COASetup."Tenant Receivables-Residential"
            else
                Error('COA Setup doest not exist for Tenant Receivables-Residential Account');

        end else
            if COASetup."Tenant Receivables-Commercial" <> '' then
                TenantReceivableAccount := COASetup."Tenant Receivables-Commercial"
            else
                Error('COA Setup doest not exist for Tenant Receivables-Commercial Account');

        CarryForwardOutAccount := COASetup."Carried Forward Out SD";
        CarryForwardInAccount := COASetup."Carried Forward in SD";

        DocNo := 'SD-' + Format(SecurityDeposit."Contract ID");

        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", GenJnlTemplate);
        GenJnlLine.SetRange("Journal Batch Name", GenJnlBatch);
        if GenJnlLine.FindLast() then
            LineNo := GenJnlLine."Line No." + 1
        else
            LineNo := 1;

        Clear(GenJnlLine);
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := GenJnlTemplate;
        GenJnlLine."Journal Batch Name" := GenJnlBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Posting Date" := SecurityDeposit."Posting Date";
        GenJnlLine."Document No." := DocNo;
        GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Customer);
        GenJnlLine.Validate("Account No.", SecurityDeposit."Tenant ID");
        GenJnlLine.Description := CopyStr(SecurityDeposit.Narration, 1, 100);
        GenJnlLine.Validate(Amount, -Amount);
        GenJnlLine."Contract ID" := SecurityDeposit."Contract ID";
        GenJnlLine.Insert();

        LineNo += 10000;

        Clear(GenJnlLine);
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := GenJnlTemplate;
        GenJnlLine."Journal Batch Name" := GenJnlBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Posting Date" := SecurityDeposit."Posting Date";
        GenJnlLine."Document No." := DocNo;
        GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::"G/L Account");
        GenJnlLine.Validate("Account No.", CarryForwardOutAccount);
        GenJnlLine.Description := CopyStr(SecurityDeposit.Narration, 1, 100);
        GenJnlLine.Validate(Amount, Amount);
        GenJnlLine."Contract ID" := SecurityDeposit."Contract ID";
        GenJnlLine.Insert();

        LineNo += 10000;

        Clear(GenJnlLine);
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := GenJnlTemplate;
        GenJnlLine."Journal Batch Name" := GenJnlBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Posting Date" := SecurityDeposit."Posting Date";
        GenJnlLine."Document No." := DocNo;
        GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::"G/L Account");
        GenJnlLine.Validate("Account No.", CarryForwardInAccount);
        GenJnlLine.Description := CopyStr(SecurityDeposit.Narration, 1, 100);
        GenJnlLine.Validate(Amount, -Amount);
        GenJnlLine."Contract ID" := SecurityDeposit."New_Contract ID";
        GenJnlLine.Insert();

        LineNo += 10000;

        Clear(GenJnlLine);
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := GenJnlTemplate;
        GenJnlLine."Journal Batch Name" := GenJnlBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Posting Date" := SecurityDeposit."Posting Date";
        GenJnlLine."Document No." := DocNo;
        GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Customer);
        GenJnlLine.Validate("Account No.", SecurityDeposit."Tenant ID");
        GenJnlLine.Description := CopyStr(SecurityDeposit.Narration, 1, 100);
        GenJnlLine.Validate(Amount, Amount);
        GenJnlLine."Contract ID" := SecurityDeposit."New_Contract ID";
        GenJnlLine.Insert();

        GenJnlPost.Run(GenJnlLine);
        Message('Security Deposit posted successfully.');
    end;
}
