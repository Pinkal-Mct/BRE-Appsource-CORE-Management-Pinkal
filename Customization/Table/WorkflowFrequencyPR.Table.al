table 73209715 "Workflow Frequency PR"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(73209575; "Company ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Company ID';
            TableRelation = "Company Data"."Company ID";
        }
        field(73209576; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
        }
        field(73209577; "Workflow"; Option)
        {
            OptionMembers = " ","Payment Reminder","Invoice","Renewal Notification to Tenant","Tenant Loyalty Check Reminder";
            Caption = 'Workflow';
        }
        field(73209578; "frequncy Status"; Option)
        {
            OptionMembers = " ","Company","Property";
            Caption = 'frequncy Status';
        }
        field(73209579; "No. of Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(73209580; "Property ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Property Registration"."Property ID";
        }
    }
    keys
    {
        key(Key1; "Entry No.", "Company ID")
        {
            Clustered = true;
        }
    }
}
