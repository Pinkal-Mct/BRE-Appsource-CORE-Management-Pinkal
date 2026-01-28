tableextension 50510 "G/L Entry Ext." extends "G/L Entry"

{
    fields
    {
        field(50000; "Contract ID"; Integer)
        {
            Caption = 'Contract ID';
            DataClassification = CustomerContent;
        }
    }
}
