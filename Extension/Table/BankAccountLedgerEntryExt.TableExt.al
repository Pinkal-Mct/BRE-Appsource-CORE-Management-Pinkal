tableextension 50513 "Bank Account Ledger Entry Ext." extends "Bank Account Ledger Entry"
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