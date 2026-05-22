tableextension 73209579 "Gen. Journal Line Ext." extends "Gen. Journal Line"

{
    fields
    {
        field(73209575; "BLRContract ID"; Integer)
        {
            Caption = 'Contract ID';
            DataClassification = CustomerContent;
        }
        field(73209576; "BLRItem Description"; Enum "Deposit Type")
        {
            Caption = 'Item Description';
            DataClassification = CustomerContent;
        }
        field(73209577; "BLRTransaction Type"; Option)
        {
            Caption = 'Transaction Type';
            DataClassification = CustomerContent;
            OptionMembers = " ",Refund,Adjustment;
        }
    }
}
