tableextension 73209578 "Document Attachment Ext" extends "Document Attachment"
{
    fields
    {
        field(73209575; "Field No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209576; "Record Id"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209577; "Table Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(73209578; "Upload Document Type"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209579; "Document Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209580; "Document File"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209581; "Upload Document"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209582; "Document BLOB"; Blob)
        {
            DataClassification = CustomerContent;
        }
        field(73209583; "DocumentMedia"; MediaSet)
        {
            DataClassification = CustomerContent;
        }
        field(73209584; "MIME Type"; Text[250])
        {
            DataClassification = CustomerContent;
        }
    }
}
