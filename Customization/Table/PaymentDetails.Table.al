table 73209644 "Payment Details"
{
    DataClassification = CustomerContent;
    Caption = 'Payment Detais';
    fields
    {
        field(73209575; "Item Description"; Text[100])
        {
            Caption = 'Payment Description';
            DataClassification = CustomerContent;
        }
        field(73209576; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
        field(73209577; "VAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Amount';
        }
        field(73209578; "Amount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount Including VAT';
        }
        field(73209579; "Payment Status"; Text[100])
        {
            Caption = 'Payment Status';
            DataClassification = CustomerContent;
        }
        field(73209580; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
            DataClassification = CustomerContent;
        }
        field(73209581; "Contract ID"; Integer)
        {
            Caption = 'Contract ID';
            DataClassification = CustomerContent;
        }
        field(73209582; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            DataClassification = CustomerContent;
        }
        field(73209583; "Termination Date"; Date)
        {
            Caption = 'Termination Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Contract ID", "Entry No.")
        {
            Clustered = true;
        }
    }
}
