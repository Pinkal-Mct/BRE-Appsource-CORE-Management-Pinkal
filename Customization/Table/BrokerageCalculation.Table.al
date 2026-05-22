table 73209587 "BLRBrokerageCalculation"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLROwner ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Owner ID';
            TableRelation = "BLROwnerProfile"."BLROwner ID";
        }
        field(73209576; "BLRProperty ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Property ID';
            TableRelation = "BLRPropertyRegistration"."BLRProperty ID";
        }
        field(73209577; "BLRStart Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
        }
        field(73209578; "BLREnd Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
        }
        field(73209579; "BLRID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            AutoIncrement = true;
            Editable = false;
        }
    }
    keys
    {
        key(PK;"BLRID")
        {
            Clustered = true;
        }
        key(Secondary;"BLROwner ID", "BLRProperty ID")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown;"BLRProperty ID", "BLROwner ID")
        {
        }
    }
}
