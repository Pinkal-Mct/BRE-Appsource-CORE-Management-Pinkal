codeunit 73209604 "BLRSecurityDepositPostingMgt."
{
    procedure PostSecurityDepositAmount(SecurityDeposit: Record "BLRSecurityDeposit")
    var
        GenJnlLine: Record "Gen. Journal Line";
        COASetup: Record "BLRCOASetup";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        GenJnlTemplate: Code[10];
        GenJnlBatch: Code[10];
        Amount: Decimal;
        PropertyType: Text[30];
        CarryForwardOutAccount: Code[20];
        CarryForwardInAccount: Code[20];
        LineNo: Integer;
        DocNo: Code[20];
    begin
        GenJnlTemplate := 'CASH RECE';
        GenJnlBatch := 'DEFAULT';

        Amount := SecurityDeposit."BLRCarry Forward Amount";
        PropertyType := SecurityDeposit."BLRProperty Classification";

        if Amount = 0 then
            Error('Security Deposit Amount Received is zero. Cannot post.');

        COASetup.Get();
        if COASetup."BLRCarried Forward Out SD" <> '' then
            CarryForwardOutAccount := COASetup."BLRCarried Forward Out SD"
        else
            Error('COA Setup doest not exist for Carried Forward Out SD Account');
        if COASetup."BLRCarried Forward in SD" <> '' then
            CarryForwardInAccount := COASetup."BLRCarried Forward in SD"
        else
            Error('COA Setup doest not exist for Carried Forward in SD Account');

        DocNo := 'SD-' + Format(SecurityDeposit."BLRContract ID");

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
        GenJnlLine."Posting Date" := SecurityDeposit."BLRPosting Date";
        GenJnlLine."Document No." := DocNo;
        GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Customer);
        GenJnlLine.Validate("Account No.", SecurityDeposit."BLRTenant ID");
        GenJnlLine.Description := CopyStr(SecurityDeposit."BLRNarration", 1, 100);
        GenJnlLine.Validate(Amount, -Amount);
        GenJnlLine."BLRContract ID" := SecurityDeposit."BLRContract ID";
        GenJnlLine.Insert();

        LineNo += 10000;

        Clear(GenJnlLine);
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := GenJnlTemplate;
        GenJnlLine."Journal Batch Name" := GenJnlBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Posting Date" := SecurityDeposit."BLRPosting Date";
        GenJnlLine."Document No." := DocNo;
        GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::"G/L Account");
        GenJnlLine.Validate("Account No.", CarryForwardOutAccount);
        GenJnlLine.Description := CopyStr(SecurityDeposit."BLRNarration", 1, 100);
        GenJnlLine.Validate(Amount, Amount);
        GenJnlLine."BLRContract ID" := SecurityDeposit."BLRContract ID";
        GenJnlLine.Insert();

        LineNo += 10000;

        Clear(GenJnlLine);
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := GenJnlTemplate;
        GenJnlLine."Journal Batch Name" := GenJnlBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Posting Date" := SecurityDeposit."BLRPosting Date";
        GenJnlLine."Document No." := DocNo;
        GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::"G/L Account");
        GenJnlLine.Validate("Account No.", CarryForwardInAccount);
        GenJnlLine.Description := CopyStr(SecurityDeposit."BLRNarration", 1, 100);
        GenJnlLine.Validate(Amount, -Amount);
        GenJnlLine."BLRContract ID" := SecurityDeposit."BLRNew_Contract ID";
        GenJnlLine.Insert();

        LineNo += 10000;

        Clear(GenJnlLine);
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := GenJnlTemplate;
        GenJnlLine."Journal Batch Name" := GenJnlBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Posting Date" := SecurityDeposit."BLRPosting Date";
        GenJnlLine."Document No." := DocNo;
        GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Customer);
        GenJnlLine.Validate("Account No.", SecurityDeposit."BLRTenant ID");
        GenJnlLine.Description := CopyStr(SecurityDeposit."BLRNarration", 1, 100);
        GenJnlLine.Validate(Amount, Amount);
        GenJnlLine."BLRContract ID" := SecurityDeposit."BLRNew_Contract ID";
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
