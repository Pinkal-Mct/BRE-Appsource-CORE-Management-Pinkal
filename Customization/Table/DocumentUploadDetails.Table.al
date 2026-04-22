table 73209613 "DocumentUploadDetails"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(73209575; "OwnerId"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'OwnerId';
        }
        field(73209576; "Document Type"; Enum "Document Type Enum")
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
        }
        field(73209580; "View & Download"; Text[20])
        {
            DataClassification = ToBeClassified;
            InitValue = 'View';
        }
        field(73209581; "Download"; Text[20])
        {
            DataClassification = ToBeClassified;
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
        key(Key1; "Entry No.", OwnerId)
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