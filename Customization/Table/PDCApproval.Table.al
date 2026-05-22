table 73209653 "BLRPDCApproval"
{
    DataClassification = CustomerContent;
    DataCaptionFields = SystemId;
    fields
    {
        field(73209575; "BLRId"; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209576; "BLRStatus"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(73209577; "BLRPDC Id"; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209578; "BLRTenant_Id"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209579; "BLRContract_Id"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209580; "BLRCheck_No"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209581; "BLRDeposite_Bank"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209582; "BLRTotal_Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209583; "BLRDue_Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209584; "BLRView"; Text[2048])
        {
            DataClassification = CustomerContent;
        }


    }

    keys
    {
        key(Key1;"BLRId")
        {
            Clustered = true;
        }
    }

}
