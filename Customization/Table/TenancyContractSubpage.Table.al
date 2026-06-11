table 73209703 "BLRTenancyContractSubpage"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLRContractID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209576; "BLRSecondary Item Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Secondary Item';
            TableRelation = Item where("BLRItem Type Template" = const("BLRItem Type Template Enum"::"Secondary Item"));
            Editable = false;
            trigger OnValidate()
            var
                SecondaryItemRec: Record Item;
            begin
                SecondaryItemRec.SetRange("No.", Rec."BLRSecondary Item Type");
                if SecondaryItemRec.FindFirst() then begin
                    "BLRSecondary Item Type" := SecondaryItemRec.Description;
                    "BLRVAT %" := SecondaryItemRec."BLRVAT %";
                end else
                    "BLRVAT %" := 0;
            end;
        }
        field(73209577; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
            trigger OnValidate()
            begin
                CalcVATAndTotal();
            end;
        }
        field(73209578; "BLRVAT %"; Option)
        {
            OptionMembers = "0%","5%";
            Caption = 'VAT %';
            Editable = false;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                CalcVATAndTotal();
            end;
        }
        field(73209579; "BLRVAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Amount';
            Editable = false;
            trigger OnValidate()
            var
                vatPer: Integer;
            begin
                if "BLRVAT %" = "BLRVAT %"::"5%" then
                    vatPer := 5
                else
                    vatPer := 0;
                "BLRVAT Amount" := "BLRAmount" * (vatPer / 100);
            end;
        }
        field(73209580; "BLRAmount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount Including VAT';
            Editable = false;
            trigger OnValidate()
            begin
                "BLRAmount Including VAT" := "BLRAmount" + "BLRVAT Amount";
                UpdatedPaymentRecords();
            end;
        }
        field(73209581; "BLRStart Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
            Editable = false;
        }
        field(73209582; "BLREnd Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
            Editable = false;
        }
        field(73209583; "BLRGenerate Payment Schedule"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Generate Payment Schedule';
            InitValue = 'Generate Payment Schedule';
            Editable = false;
        }
        field(73209584; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209585; "BLRPayment Type"; Option)
        {
            OptionMembers = "","One Time Payment","Installment";
            Caption = 'Payment Type';
            DataClassification = CustomerContent;
        }
        field(73209586; "BLRInvoiced"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoiced';
        }
        field(73209587; "BLRLink"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Revenue Structure Link';
            Editable = false;
        }
        field(73209588; "BLRTenantID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
        }
        field(73209589; "BLRProposalID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Proposal ID';
        }
        field(73209590; "BLRContract Renewal ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Renewal ID';
        }
        field(73209591; "BLRInvoiced and Paid"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoiced and Paid';

            trigger OnValidate()
            var
                tenancyContractRec: Record "BLRTenancyContract";
            begin
                if Rec."BLRSecondary Item Type" = 'Security Deposit' then
                    if tenancyContractRec.Get("BLRContractID") then begin
                        tenancyContractRec.Validate("BLRSecDepAmtReceived", tenancyContractRec."BLRCarry Forward In" + "BLRInvoiced and Paid");
                        tenancyContractRec.Modify();
                    end;
            end;
        }
    }
    keys
    {
        key(Key1; "BLREntry No.", "BLRContractID")
        {
            Clustered = true;
        }
    }

    local procedure CalcVATAndTotal()
    var
        vatPer: Integer;
    begin
        if "BLRVAT %" = "BLRVAT %"::"5%" then
            vatPer := 5
        else
            vatPer := 0;
        "BLRVAT Amount" := "BLRAmount" * (vatPer / 100);
        "BLRAmount Including VAT" := "BLRAmount" + "BLRVAT Amount";
    end;

    procedure UpdatedPaymentRecords()
    var
        paymentScheduleSub: Record "BLRPaymentSchedule2";
        paymentMode2: Record "BLRPaymentMode2";
        differenceAmount: Decimal;
    begin
        paymentScheduleSub.SetRange("BLRContract ID", Rec."BLRContractID");
        paymentScheduleSub.SetRange("BLRSecondary Item Type", Rec."BLRSecondary Item Type");
        if paymentScheduleSub.FindFirst() then
            if Rec."BLRAmount" = 0 then begin
                differenceAmount := paymentScheduleSub."BLRAmount";
                paymentScheduleSub.Delete()
            end
            else begin
                differenceAmount := paymentScheduleSub."BLRAmount" - Rec."BLRAmount";
                paymentScheduleSub."BLRAmount" := Rec."BLRAmount";
                paymentScheduleSub."BLRVAT Amount" := Rec."BLRVAT Amount";
                paymentScheduleSub."BLRAmount Including VAT" := Rec."BLRAmount Including VAT";
                paymentScheduleSub.Modify(true);
            end;

        paymentMode2.SetRange("BLRContract ID", Rec."BLRContractID");
        paymentMode2.SetRange("BLRPayment Series", 'PAY01');
        if paymentMode2.FindFirst() then begin
            paymentMode2."BLRAmount" -= differenceAmount;
            paymentMode2."BLRAmount Including VAT" := paymentMode2."BLRAmount" + paymentMode2."BLRVAT Amount";
            paymentMode2.Modify(true);
        end;
    end;
}
