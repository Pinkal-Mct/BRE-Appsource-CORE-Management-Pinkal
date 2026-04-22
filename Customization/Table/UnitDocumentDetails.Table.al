table 73209707 "Unit Document Details"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(73209575; "UnitID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'UnitID';
        }
        field(73209576; "Document Type"; Enum "Unit Document Type Enum")
        {
            DataClassification = ToBeClassified;
            Caption = 'Document Type';
        }
        field(73209577; "Document Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document Name';
        }
        field(73209578; "Upload Document"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Upload Document';
        }
        field(73209579; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(73209580; "View & Download"; Text[20])
        {
            DataClassification = ToBeClassified;

            InitValue = 'View';
        }
        field(73209581; "Download"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Download';
            InitValue = 'Download';
        }

        field(73209582; "View Document URL"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'View Document URL';
        }

    }

    keys
    {
        key(Key1; UnitID, "Entry No.")
        {
            Clustered = true;
        }
    }

}