table 73209615 "BLRFilteredInvoiceDetail"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLRID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            Editable = false;
        }
        field(73209576; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209577; "BLRTenant ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
        }
        field(73209578; "BLRInvoice ID"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice ID';
        }
        field(73209579; "BLRItem Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Name';
        }
        field(73209580; "BLRItem Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Item Amount';
        }
        field(73209581; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }
    }
    keys
    {
        key(PK;"BLREntry No.", "BLRID")
        {
            Clustered = true;
        }
    }
}
