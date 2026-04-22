table 73209576 "Adjustment Deposits"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(73209575; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }

        field(73209576; "Item Description"; Enum "Deposit Type")
        {
        }

        field(73209577; "Transaction Type"; Option)
        {
            OptionMembers = " ",Refund,Adjustment;
        }

        field(73209578; "Amount"; Decimal)
        {
        }

        field(73209579; "Narration"; Text[250])
        {
        }

        field(73209580; "Posted"; Boolean)
        {
        }

        field(73209581; "Posting Date"; Date)
        {
        }
        field(73209582; "Contract Id"; Integer)
        {
        }
        field(73209583; "Adjusted"; Boolean)
        {
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
