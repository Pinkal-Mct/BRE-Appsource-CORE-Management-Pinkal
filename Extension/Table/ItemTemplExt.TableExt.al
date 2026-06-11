tableextension 73209584 "BLRItem Templ. Ext" extends "Item Templ."
{
    fields
    {
        field(73209600; "BLRModule Type"; Enum "BLRModule Enum")
        {
            Caption = 'Module Type';
            DataClassification = CustomerContent;
        }
        field(73209601; "BLRTypes"; Enum "BLRItem Template Enum")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(73209602; "BLRItem type template"; Enum "BLRItem Type Template Enum")
        {
            Caption = 'Item type template';
            DataClassification = CustomerContent;
        }
    }
}
