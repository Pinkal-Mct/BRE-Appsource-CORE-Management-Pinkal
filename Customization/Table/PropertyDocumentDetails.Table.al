table 73209660 "BLRPropertyDocumentDetails"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "BLRPropertyID"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'PropertyID';
        }
        field(73209576; "BLRDocument Type"; Enum "Property Document Type Enum")
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
            AutoIncrement = true;
            Caption = 'Entry No';
        }

        field(73209580; "BLRView & Download"; Text[220])
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

        field(73209582; "BLRView Document URL"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'View Document URL';
        }

    }

    keys
    {
        key(Key1;"BLREntry No.", "BLRPropertyID")
        {
            Clustered = true;
        }
    }

}
