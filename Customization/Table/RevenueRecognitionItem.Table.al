table 73209677 "Revenue Recognition Item"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "RR_No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            Editable = false;
        }
        field(73209576; "Item Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Type';
            TableRelation = Item WHERE("Item type template" = const("Item Type Template Enum"::"Secondary Item"), "Charges Status" = CONST("Regular Charges"));
            trigger OnValidate()
            var
                SecondaryItemRec: Record Item;
            begin
                SecondaryItemRec.SetRange("No.", Rec."Item Type");
                if SecondaryItemRec.FindFirst() then
                    "Item Type" := SecondaryItemRec.Description;
            end;
        }
        field(73209577; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
}
