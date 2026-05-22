tableextension 73209584 "Item Templ. Ext" extends "Item Templ."
{
    fields
    {
        field(73209600; "BLRModule Type"; Enum "Module Enum")
        {
            Caption = 'Module Type';
            DataClassification = CustomerContent;
        }
        field(73209601; "BLRTypes"; Enum "Item Template Enum")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(73209602; "BLRItem type template"; Enum "Item Type Template Enum")
        {
            Caption = 'Item type template';
            DataClassification = CustomerContent;
        }
    }
}
