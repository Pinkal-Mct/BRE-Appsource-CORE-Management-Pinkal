tableextension 73209578 "Document Attachment Ext" extends "Document Attachment"
{
    fields
    {
        field(73209575; "BLRField No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209576; "BLRRecord Id"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209577; "BLRTable Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(73209578; "BLRUpload Document Type"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209579; "BLRDocument Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209580; "BLRDocument File"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209581; "BLRUpload Document"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209582; "BLRDocument BLOB"; Blob)
        {
            DataClassification = CustomerContent;
        }
        field(73209583; "BLRDocumentMedia"; MediaSet)
        {
            DataClassification = CustomerContent;
        }
        field(73209584; "BLRMIME Type"; Text[250])
        {
            DataClassification = CustomerContent;
        }
    }
}
