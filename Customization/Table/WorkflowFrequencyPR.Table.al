table 73209715 "Workflow Frequency PR"
{
    DataClassification = SystemMetadata;
    fields
    {
        field(73209575; "Company ID"; Integer)
        {
            DataClassification = SystemMetadata;
            Caption = 'Company ID';
            TableRelation = "Company Data"."Company ID";
        }
        field(73209576; "Entry No."; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
            Editable = false;
        }
        field(73209577; "Workflow"; Option)
        {
            OptionMembers = " ","Payment Reminder","Invoice","Renewal Notification to Tenant","Tenant Loyalty Check Reminder";
            Caption = 'Workflow';
            DataClassification = SystemMetadata;
        }
        field(73209578; "frequncy Status"; Option)
        {
            OptionMembers = " ","Company","Property";
            Caption = 'frequncy Status';
            DataClassification = SystemMetadata;
        }
        field(73209579; "No. of Days"; Integer)
        {
            DataClassification = SystemMetadata;
        }
        field(73209580; "Property ID"; Code[20])
        {
            DataClassification = SystemMetadata;
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
