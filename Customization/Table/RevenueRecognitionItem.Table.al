table 73209677 "BLRRevenueRecognitionItem"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLRRR_No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            Editable = false;
        }
        field(73209576; "BLRItem Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Type';
            TableRelation = Item WHERE("BLRItem type template" = const("BLRItem Type Template Enum"::"Secondary Item"), "BLRCharges Status" = CONST("Regular Charges"));
            trigger OnValidate()
            var
                SecondaryItemRec: Record Item;
            begin
                SecondaryItemRec.SetRange("No.", Rec."BLRItem Type");
                if SecondaryItemRec.FindFirst() then
                    "BLRItem Type" := SecondaryItemRec.Description;
            end;
        }
        field(73209577; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
    }
    keys
    {
        key(Key1; "BLREntry No.")
        {
            Clustered = true;
        }
    }
}
