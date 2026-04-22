table 73209604 "Credit Note Approval"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(73209575; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
            Editable = false;
        }
        field(73209576; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(73209577; "Tenant ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
        }
        field(73209578; "Contract Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Start Date';
        }
        field(73209579; "Contract End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract End Date';
        }
        field(73209580; "Credit Note Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Note Amount';
        }
        field(73209581; "Tenant Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Name';
        }
        field(73209582; "Credit Note Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Note Type';
            OptionMembers = " ","Standard Credit Note","Termination Credit Note";
        }
        field(73209583; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
            OptionMembers = "Pending","Approved","Reject";
        }
        field(73209584; "FC ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'FC ID';
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
