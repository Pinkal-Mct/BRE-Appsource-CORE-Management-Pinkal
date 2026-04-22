table 73209660 "Property Document Details"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(73209575; "PropertyID"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'PropertyID';
        }
        field(73209576; "Document Type"; Enum "Property Document Type Enum")
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
            AutoIncrement = true;
            Caption = 'Entry No';
        }

        field(73209580; "View & Download"; Text[220])
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
        key(Key1; "Entry No.", "PropertyID")
        {
            Clustered = true;
        }
    }

}