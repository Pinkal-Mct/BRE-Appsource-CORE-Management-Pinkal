table 73209710 "BLRVendorContractDocument"
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
        field(73209576; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
        field(73209577; "BLRPayment Status"; Enum "BLRPayment Status")
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Status';
        }
        field(73209578; "BLRInvoice ID"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice ID';
        }
        field(73209579; "BLRInvoice Document Upload"; Text[2000])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Document Upload';
            InitValue = 'Invoice Upload';
        }
        field(73209580; "BLRReceipt Document Upload"; Text[2000])
        {
            DataClassification = CustomerContent;
            Caption = 'Receipt Document Upload';
            InitValue = 'Receipt Upload';
        }
        field(73209581; "BLRReceipt ID"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Receipt ID';
        }
        field(73209582; "BLRInvoice Document View"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Document View';
            InitValue = 'Invoice View';
        }
        field(73209583; "BLRReceipt Document View"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Receipt Document View';
            InitValue = 'Receipt View';
        }
        field(73209584; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
            Editable = false;
            AutoIncrement = true;
        }
        field(73209585; "BLRInvoice Document URL"; Text[2000])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Document URL';
        }
        field(73209586; "BLRReceipt Document URL"; Text[2000])
        {
            DataClassification = CustomerContent;
            Caption = 'Receipt Document URL';
        }
    }
    keys
    {
        key(PK; "BLREntry No.", "BLRVendor ID")
        {
            Clustered = true;
        }
    }
}
