table 73209576 "Adjustment Deposits"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = CustomerContent;
        }

        field(73209576; "Item Description"; Enum "Deposit Type")
        {
            DataClassification = CustomerContent;
        }

        field(73209577; "Transaction Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Refund,Adjustment;
        }

        field(73209578; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(73209579; "Narration"; Text[250])
        {
            DataClassification = CustomerContent;
        }

        field(73209580; "Posted"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(73209581; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209582; "Contract Id"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209583; "Adjusted"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.", "Contract Id")
        {
            Clustered = true;
        }
    }
}
