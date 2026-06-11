table 73209601 "BLRContractRenewalSubpage"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLRId"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Id';
        }
        field(73209576; "BLRSecondary Item Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Secondary Item';
            TableRelation = Item where("BLRItem Type Template" = const("BLRItem Type Template Enum"::"Secondary Item"));
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
            DataClassification = CustomerContent;
            OptionMembers = "0%","5%";
            Caption = 'VAT %';
            Editable = false;
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
            end;
        }
        field(73209581; "BLRStart Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
            Editable = True;
        }
        field(73209582; "BLREnd Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
            Editable = True;
        }
        field(73209583; "BLRGenerate Payment Schedule"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Generate Payment Schedule';
            InitValue = 'Generate Payment Schedule';
        }
        field(73209584; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209585; "BLRPayment Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "","One Time Payment","Installment";
            Caption = 'Payment Type';
        }
        field(73209586; "BLRLink"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Link';
            Editable = false;
        }
        field(73209587; "BLRTenantID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
        }
    }
    keys
    {
        key(Key1; "BLREntry No.", "BLRId")
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
}
