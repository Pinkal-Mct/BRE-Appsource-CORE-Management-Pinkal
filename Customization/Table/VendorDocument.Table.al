table 73209711 "Vendor Document"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(73209575; "Vendor ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor ID';
            Editable = false;
        }
        field(73209576; "Document Type"; Option)
        {
            OptionMembers = " ","ID Proof","Adress Proof","VAT Registration","Real-Estate Agency Registration","Other Registration";
            Caption = 'Document Type';
        }
        field(73209577; "Document No."; Code[100])
        {
            Caption = 'Document No.';
        }
        field(73209578; "Document Name"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document Name';
        }
        field(73209579; "Document Upload"; Text[2000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document Upload';
            InitValue = 'Upload';
        }
        field(73209580; "Document View"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document View';
            InitValue = 'View';
        }
        field(73209581; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entry No.';
            Editable = false;
            AutoIncrement = true;
        }
        field(73209582; "Document URL"; Text[2000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document URL';
        }
    }
    keys
    {
        key(PK; "Entry No.", "Vendor ID")
        {
            Clustered = true;
        }
    }
}
