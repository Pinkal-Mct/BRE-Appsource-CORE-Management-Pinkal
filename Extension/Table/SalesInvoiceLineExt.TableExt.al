tableextension 73209588 "Sales Invoice Line Ext" extends "Sales Invoice Line"
{
    fields
    {
        field(73209575; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209576; "FC ID"; Integer)
        {
            Caption = 'FC ID';
            DataClassification = CustomerContent;
        }
    }
}
