table 73209612 "Customer Payment Receipt"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(73209575; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
        }
        field(73209576; "Posing Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(73209577; "Account Type"; Enum "Gen. Journal Account Type")
        {
            DataClassification = CustomerContent;
        }
        field(73209578; "Account No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209579; "Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209580; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209581; "Invoice No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209582; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Entry No.", "Document No.")
        {
            Clustered = true;
        }
    }
}