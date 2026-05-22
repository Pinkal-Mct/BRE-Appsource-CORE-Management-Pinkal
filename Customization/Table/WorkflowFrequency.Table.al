table 73209714 "BLRWorkflowFrequency"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(73209575; "BLRCompany ID"; Integer)
        {
            DataClassification = SystemMetadata;
            Caption = 'Company ID';
            TableRelation = "BLRCompanyData"."BLRCompany ID";

        }

        field(73209576; "BLREntry No."; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
            Editable = false;
        }

        field(73209577; "BLRWorkflow"; Option)
        {
            OptionMembers = " ","Payment Reminder","Invoice","Renewal Notification to Tenant","Tenant Loyalty Check Reminder";
            Caption = 'Workflow';
            DataClassification = SystemMetadata;
        }

        field(73209578; "BLRfrequncy Status"; Option)
        {
            OptionMembers = " ","Company","Property";
            Caption = 'frequncy Status';
            DataClassification = SystemMetadata;
        }

        field(73209579; "BLRNo. of Days"; Integer)
        {
            DataClassification = SystemMetadata;
        }

    }



    keys
    {
        key(Key1;"BLREntry No.", "BLRCompany ID")
        {
            Clustered = true;
        }
    }
}





