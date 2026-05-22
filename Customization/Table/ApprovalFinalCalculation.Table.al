table 73209579 "BLRApprovalFinalCalculation"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "BLRID";
    fields
    {
        field(73209575; "BLRID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            Editable = false;
            AutoIncrement = true;
        }
        field(73209576; "BLRFC ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'FC ID';
            Editable = false;
        }
        field(73209577; "BLRStatus"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Pending,Approved,Rejected;
            Caption = 'Status';
        }
        field(73209578; "BLRTenant ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
        }
        field(73209579; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209580; "BLRContract Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start Date';
        }
        field(73209581; "BLRContract End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract End Date';
        }
        field(73209582; "BLRTermination Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Termination Date';
        }
        field(73209583; "BLRContract Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Amount';
        }
        field(73209584; "BLRLink"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Final Calculation Link';
            Editable = false;
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
