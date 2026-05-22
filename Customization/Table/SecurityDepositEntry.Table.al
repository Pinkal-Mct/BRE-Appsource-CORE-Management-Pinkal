table 73209686 "BLRSecurityDepositEntry"
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
        field(73209576; "BLRSecurity Deposit ID"; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = "BLRAdjustmentSecurityDeposit"."BLRID";
        }
        field(73209577; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209578; "BLRSecurity Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209579; "BLRStart Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209580; "BLREnd Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209581; "BLRStatus"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Pending,Approved'; // Include an empty option for flexibility
            OptionMembers = Pending,Approved;
        }
        field(73209582; "BLRTotal Amount"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209583; "BLRMain Security Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK;"BLREntry No.")
        {
            Clustered = true;
        }
    }
}
