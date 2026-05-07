table 73209704 "Tenant Document Details"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'TenantID';
        }
        field(73209576; "Document Type"; Enum "Tenant Document Type Enum")
        {
            DataClassification = CustomerContent;
            Caption = 'Document Type';
        }
        field(73209577; "Document Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Document Name';
        }

        field(73209578; "Upload Document"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Upload Document';
        }
        field(73209579; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No';
            AutoIncrement = true;
        }

        field(73209580; "View & Download"; Text[20])
        {
            DataClassification = CustomerContent;

            InitValue = 'View';
        }

        field(73209581; "Download"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Download';
            InitValue = 'Download';
        }
        field(73209582; "Tenant Screening"; Boolean)
        {
            DataClassification = EndUserIdentifiableInformation;
        }

        field(73209583; "View Document URL"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'View Document URL';
        }
    }

    keys
    {
        key(Key1; No, "Entry No.")
        {
            Clustered = true;
        }
    }
}
