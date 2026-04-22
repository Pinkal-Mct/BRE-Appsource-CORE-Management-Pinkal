table 73209579 "Approval Final Calculation"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "ID";
    fields
    {
        field(73209575; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
            Editable = false;
            AutoIncrement = true;
        }
        field(73209576; "FC ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'FC ID';
            Editable = false;
        }
        field(73209577; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Pending,Approved,Rejected;
            Caption = 'Status';
        }
        field(73209578; "Tenant ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
        }
        field(73209579; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(73209580; "Contract Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Start Date';
        }
        field(73209581; "Contract End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract End Date';
        }
        field(73209582; "Termination Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Termination Date';
        }
        field(73209583; "Contract Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Amount';
        }
        field(73209584; "Link"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Final Calculation Link';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "ID")
        {
            Clustered = false;
        }
    }
}
