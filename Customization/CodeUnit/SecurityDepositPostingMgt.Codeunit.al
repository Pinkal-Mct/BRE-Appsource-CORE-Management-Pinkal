codeunit 73209604 "Security Deposit Posting Mgt."
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
        if COASetup."Carried Forward Out SD" <> '' then
            CarryForwardOutAccount := COASetup."Carried Forward Out SD"
        else
            Error('COA Setup doest not exist for Carried Forward Out SD Account');
        if COASetup."Carried Forward in SD" <> '' then
            CarryForwardInAccount := COASetup."Carried Forward in SD"
        else
            Error('COA Setup doest not exist for Carried Forward in SD Account');

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

        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", 'CASH RECE');
        GenJnlLine.SetRange("Journal Batch Name", 'DEFAULT');
        if GenJnlLine.FindSet() then
            GenJnlLine.DeleteAll();
    end;
}
