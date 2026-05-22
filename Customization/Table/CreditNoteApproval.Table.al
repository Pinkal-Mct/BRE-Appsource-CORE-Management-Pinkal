table 73209604 "BLRCreditNoteApproval"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLRID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            Editable = false;
        }
        field(73209576; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209577; "BLRTenant ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
        }
        field(73209578; "BLRContract Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start Date';
        }
        field(73209579; "BLRContract End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract End Date';
        }
        field(73209580; "BLRCredit Note Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note Amount';
        }
        field(73209581; "BLRTenant Name"; Text[250])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Name';
        }
        field(73209582; "BLRCredit Note Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note Type';
            OptionMembers = " ","Standard Credit Note","Termination Credit Note";
        }
        field(73209583; "BLRStatus"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionMembers = "Pending","Approved","Reject";
        }
        field(73209584; "BLRFC ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'FC ID';
        }
    }
    keys
    {
        key(PK;"BLRID")
        {
            Clustered = false;
        }
    }
}
