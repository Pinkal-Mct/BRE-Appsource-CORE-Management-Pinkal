table 73209618 "BLRFinalCalculationApproval"
{
    DataClassification = CustomerContent;
    DataCaptionFields = SystemId, "BLRID";
    fields
    {
        field(73209575; "BLRID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            Editable = false;
            AutoIncrement = true;
        }
        field(73209576; "BLRStatus"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209577; "BLRTenant ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
        }
        field(73209578; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209579; "BLRContract Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start Date';
        }
        field(73209580; "BLRContract End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract End Date';
        }
        field(73209581; "BLRTermination Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Termination Date';
        }
        field(73209582; "BLRContract Amount"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Amount';
        }
    }
    keys
    {
        key(PrimaryKey;"BLRID")
        {
            Clustered = false;
        }
        key(PK;SystemId)
        {
            Clustered = true;
        }
    }
}
