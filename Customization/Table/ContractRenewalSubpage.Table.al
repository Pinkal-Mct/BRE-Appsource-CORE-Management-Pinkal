table 73209601 "Contract Renewal Subpage"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(73209575; "Id"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Id';
        }
        field(73209576; "Secondary Item Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Secondary Item';
            TableRelation = Item where("Item Type Template" = const("Item Type Template Enum"::"Secondary Item"));
            trigger OnValidate()
            var
                SecondaryItemRec: Record Item;
            begin
                SecondaryItemRec.SetRange("No.", Rec."Secondary Item Type");
                if SecondaryItemRec.FindFirst() then begin
                    "Secondary Item Type" := SecondaryItemRec.Description;
                    "VAT %" := SecondaryItemRec."VAT %";
                end else
                    "VAT %" := 0;
            end;
        }
        field(73209577; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
            trigger OnValidate()
            begin
                CalcVATAndTotal();
            end;
        }
        field(73209578; "VAT %"; Option)
        {
            OptionMembers = "0%","5%";
            Caption = 'VAT %';
            Editable = false;
            trigger OnValidate()
            begin
                CalcVATAndTotal();
            end;
        }
        field(73209579; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Amount';
            Editable = false;
            trigger OnValidate()
            var
                vatPer: Integer;
            begin
                if "VAT %" = "VAT %"::"5%" then
                    vatPer := 5
                else
                    vatPer := 0;
                "VAT Amount" := Amount * (vatPer / 100);
            end;
        }
        field(73209580; "Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount Including VAT';
            Editable = false;
            trigger OnValidate()
            begin
                "Amount Including VAT" := Amount + "VAT Amount";
            end;
        }
        field(73209581; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';
            Editable = True;
        }
        field(73209582; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';
            Editable = True;
        }
        field(73209583; "Generate Payment Schedule"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Generate Payment Schedule';
            InitValue = 'Generate Payment Schedule';
        }
        field(73209584; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(73209585; "Payment Type"; Option)
        {
            OptionMembers = "","One Time Payment","Installment";
            Caption = 'Payment Type';
        }
        field(73209586; "Link"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Link';
            Editable = false;
        }
        field(73209587; "TenantID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
        }
    }
    keys
    {
        key(Key1; "Entry No.", Id)
        {
            Clustered = true;
        }
    }
    local procedure CalcVATAndTotal()
    var
        vatPer: Integer;
    begin
        if "VAT %" = "VAT %"::"5%" then
            vatPer := 5
        else
            vatPer := 0;
        "VAT Amount" := Amount * (vatPer / 100);
        "Amount Including VAT" := Amount + "VAT Amount";
    end;
}
