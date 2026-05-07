table 73209587 "Brokerage Calculation"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "Owner ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Owner ID';
            TableRelation = "Owner Profile"."Owner ID";
        }
        field(73209576; "Property ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Property ID';
            TableRelation = "Property Registration"."Property ID";
        }
        field(73209577; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
        }
        field(73209578; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
        }
        field(73209579; "ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            AutoIncrement = true;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "ID")
        {
            Clustered = true;
        }
        key(Secondary; "Owner ID", "Property ID")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Property ID", "Owner ID")
        {
        }
    }
}
