table 73209704 "BLRTenantDocumentDetails"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "BLRNo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'TenantID';
        }
        field(73209576; "BLRDocument Type"; Enum "Tenant Document Type Enum")
        {
            DataClassification = CustomerContent;
            Caption = 'Document Type';
        }
        field(73209577; "BLRDocument Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Document Name';
        }

        field(73209578; "BLRUpload Document"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Upload Document';
        }
        field(73209579; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No';
            AutoIncrement = true;
        }

        field(73209580; "BLRView & Download"; Text[20])
        {
            DataClassification = CustomerContent;

            InitValue = 'View';
        }

        field(73209581; "BLRDownload"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Download';
            InitValue = 'Download';
        }
        field(73209582; "BLRTenant Screening"; Boolean)
        {
            DataClassification = EndUserIdentifiableInformation;
        }

        field(73209583; "BLRView Document URL"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'View Document URL';
        }
    }

    keys
    {
        key(Key1;"BLRNo", "BLREntry No.")
        {
            Clustered = true;
        }
    }
}
