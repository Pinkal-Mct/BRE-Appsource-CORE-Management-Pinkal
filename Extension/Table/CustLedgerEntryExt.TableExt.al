tableextension 50511 "Cust. Ledger Entry Ext." extends "Cust. Ledger Entry"

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
