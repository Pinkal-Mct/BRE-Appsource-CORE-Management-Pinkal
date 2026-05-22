table 73209711 "BLRVendorDocument"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLRVendor ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor ID';
            Editable = false;
        }
        field(73209576; "BLRDocument Type"; Option)
        {
            OptionMembers = " ","ID Proof","Adress Proof","VAT Registration","Real-Estate Agency Registration","Other Registration";
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(73209577; "BLRDocument No."; Code[100])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(73209578; "BLRDocument Name"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Document Name';
        }
        field(73209579; "BLRDocument Upload"; Text[2000])
        {
            DataClassification = CustomerContent;
            Caption = 'Document Upload';
            InitValue = 'Upload';
        }
        field(73209580; "BLRDocument View"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Document View';
            InitValue = 'View';
        }
        field(73209581; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
            Editable = false;
            AutoIncrement = true;
        }
        field(73209582; "BLRDocument URL"; Text[2000])
        {
            DataClassification = CustomerContent;
            Caption = 'Document URL';
        }
    }
    keys
    {
        key(PK;"BLREntry No.", "BLRVendor ID")
        {
            Clustered = true;
        }
    }
}
