table 73209644 "Payment Details"
{
    DataClassification = ToBeClassified;
    Caption = 'Payment Detais';
    fields
    {
        field(73209575; "Item Description"; Text[100])
        {
            Caption = 'Payment Description';
            DataClassification = ToBeClassified;
        }
        field(73209576; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
        }
        field(73209577; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Amount';
        }
        field(73209578; "Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount Including VAT';
        }
        field(73209579; "Payment Status"; Text[100])
        {
            Caption = 'Payment Status';
            DataClassification = ToBeClassified;
        }
        field(73209580; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
            DataClassification = ToBeClassified;
        }
        field(73209581; "Contract ID"; Integer)
        {
            Caption = 'Contract ID';
            DataClassification = ToBeClassified;
        }
        field(73209582; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(73209583; "Termination Date"; Date)
        {
            Caption = 'Termination Date';
            Editable = false;
            DataClassification = ToBeClassified;
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