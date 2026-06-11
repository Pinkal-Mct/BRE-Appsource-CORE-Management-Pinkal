tableextension 73209588 "BLRSales Invoice Line Ext" extends "Sales Invoice Line"
{
    fields
    {
        field(73209575; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209576; "BLRFC ID"; Integer)
        {
            Caption = 'FC ID';
            DataClassification = CustomerContent;
        }
    }
}
