table 73209604 "Credit Note Approval"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            Editable = false;
        }
        field(73209576; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209577; "Tenant ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
        }
        field(73209578; "Contract Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start Date';
        }
        field(73209579; "Contract End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract End Date';
        }
        field(73209580; "Credit Note Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note Amount';
        }
        field(73209581; "Tenant Name"; Text[250])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Name';
        }
        field(73209582; "Credit Note Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note Type';
            OptionMembers = " ","Standard Credit Note","Termination Credit Note";
        }
        field(73209583; "Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionMembers = "Pending","Approved","Reject";
        }
        field(73209584; "FC ID"; Integer)
        {
            DataClassification = CustomerContent;
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
