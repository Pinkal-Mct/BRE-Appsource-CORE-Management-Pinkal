tableextension 73209589 "Sales Line Ext" extends "Sales Line"
{
    fields
    {
        field(73209575; "BLRContract ID"; Integer)
        {
            Caption = 'Contract ID';
            DataClassification = CustomerContent;
        }
        field(73209576; "BLRFC ID"; Integer)
        {
            Caption = 'FC ID';
            DataClassification = CustomerContent;
        }
    }
}
