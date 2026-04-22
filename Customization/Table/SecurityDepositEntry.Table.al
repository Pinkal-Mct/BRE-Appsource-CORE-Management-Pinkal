table 73209686 "Security Deposit Entry"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(73209575; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
        }
        field(73209576; "Security Deposit ID"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Adjustment Security Deposit".ID;
        }
        field(73209577; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209578; "Security Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209579; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209580; "End Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209581; "Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Pending,Approved'; // Include an empty option for flexibility
            OptionMembers = Pending,Approved;
        }
        field(73209582; "Total Amount"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209583; "Main Security Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}