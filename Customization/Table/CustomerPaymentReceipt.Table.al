table 73209612 "BLRCustomerPaymentReceipt"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
            Editable = false;
        }
        field(73209576; "BLRPosing Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(73209577; "BLRAccount Type"; Enum "Gen. Journal Account Type")
        {
            DataClassification = CustomerContent;
        }
        field(73209578; "BLRAccount No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209579; "BLRDescription"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209580; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209581; "BLRInvoice No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209582; "BLRDocument No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK;"BLREntry No.", "BLRDocument No.")
        {
            Clustered = true;
        }
    }
}
