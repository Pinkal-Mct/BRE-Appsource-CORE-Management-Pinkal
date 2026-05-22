table 73209613 "BLRDocumentUploadDetails"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLROwnerId"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'OwnerId';
        }
        field(73209576; "BLRDocument Type"; Enum "Document Type Enum")
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
        }
        field(73209580; "BLRView & Download"; Text[20])
        {
            DataClassification = CustomerContent;
            InitValue = 'View';
        }
        field(73209581; "BLRDownload"; Text[20])
        {
            DataClassification = CustomerContent;
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
        key(Key1;"BLREntry No.", "BLROwnerId")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        // Add changes to field groups here
    }
    var
        myInt: Integer;

    trigger OnInsert()
    begin
    end;

    trigger OnModify()
    begin
    end;

    trigger OnDelete()
    begin
    end;

    trigger OnRename()
    begin
    end;
}
