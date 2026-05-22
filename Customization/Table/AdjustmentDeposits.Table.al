table 73209576 "BLRAdjustmentDeposits"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "BLREntry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = CustomerContent;
        }

        field(73209576; "BLRItem Description"; Enum "Deposit Type")
        {
            DataClassification = CustomerContent;
        }

        field(73209577; "BLRTransaction Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Refund,Adjustment;
        }

        field(73209578; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(73209579; "BLRNarration"; Text[250])
        {
            DataClassification = CustomerContent;
        }

        field(73209580; "BLRPosted"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(73209581; "BLRPosting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209582; "BLRContract Id"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209583; "BLRAdjusted"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK;"BLREntry No.", "BLRContract Id")
        {
            Clustered = true;
        }
    }
}
