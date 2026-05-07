table 73209601 "Contract Renewal Subpage"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "Id"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Id';
        }
        field(73209576; "Secondary Item Type"; Text[100])
        {
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
            Caption = 'Amount';
            trigger OnValidate()
            begin
                CalcVATAndTotal();
            end;
        }
        field(73209578; "VAT %"; Option)
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
        field(73209579; "VAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
            Caption = 'Amount Including VAT';
            Editable = false;
            trigger OnValidate()
            begin
                "Amount Including VAT" := Amount + "VAT Amount";
            end;
        }
        field(73209581; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
            Editable = True;
        }
        field(73209582; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
            Editable = True;
        }
        field(73209583; "Generate Payment Schedule"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Generate Payment Schedule';
            InitValue = 'Generate Payment Schedule';
        }
        field(73209584; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209585; "Payment Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "","One Time Payment","Installment";
            Caption = 'Payment Type';
        }
        field(73209586; "Link"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Link';
            Editable = false;
        }
        field(73209587; "TenantID"; Code[20])
        {
            DataClassification = CustomerContent;
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
