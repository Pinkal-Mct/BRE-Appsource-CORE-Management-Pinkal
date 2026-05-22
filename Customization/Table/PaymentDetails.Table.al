table 73209644 "BLRPaymentDetails"
{
    DataClassification = CustomerContent;
    Caption = 'Payment Detais';
    fields
    {
        field(73209575; "BLRItem Description"; Text[100])
        {
            Caption = 'Payment Description';
            DataClassification = CustomerContent;
        }
        field(73209576; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
        field(73209577; "BLRVAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Amount';
        }
        field(73209578; "BLRAmount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount Including VAT';
        }
        field(73209579; "BLRPayment Status"; Text[100])
        {
            Caption = 'Payment Status';
            DataClassification = CustomerContent;
        }
        field(73209580; "BLRPayment Date"; Date)
        {
            Caption = 'Payment Date';
            DataClassification = CustomerContent;
        }
        field(73209581; "BLRContract ID"; Integer)
        {
            Caption = 'Contract ID';
            DataClassification = CustomerContent;
        }
        field(73209582; "BLREntry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            DataClassification = CustomerContent;
        }
        field(73209583; "BLRTermination Date"; Date)
        {
            Caption = 'Termination Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK;"BLRContract ID", "BLREntry No.")
        {
            Clustered = true;
        }
    }
}
