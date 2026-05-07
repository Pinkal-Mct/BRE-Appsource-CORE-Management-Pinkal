table 73209714 "Workflow Frequency"
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

    }



    keys
    {
        key(Key1; "Entry No.", "Company ID")
        {
            Clustered = true;
        }
    }
}





