table 73209615 "Filtered Invoice Detail"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(73209575; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
            Editable = false;
        }
        field(73209576; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(73209577; "Tenant ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
        }
        field(73209578; "Invoice ID"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Invoice ID';
        }
        field(73209579; "Item Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Item Name';
        }
        field(73209580; "Item Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Item Amount';
        }
        field(73209581; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Entry No.", "ID")
        {
            Clustered = true;
        }
    }
}
