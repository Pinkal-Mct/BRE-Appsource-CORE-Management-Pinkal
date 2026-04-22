table 73209587 "Brokerage Calculation"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(73209575; "Owner ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Owner ID';
            TableRelation = "Owner Profile"."Owner ID";
        }
        field(73209576; "Property ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property ID';
            TableRelation = "Property Registration"."Property ID";
        }
        field(73209577; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';
        }
        field(73209578; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';
        }
        field(73209579; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
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
