table 73209625 "BLRInvoiceCreditNote"
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

        field(73209578; "BLRInvoice ID"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice ID';
        }
        field(73209579; "BLRItem Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Name';
        }
        field(73209580; "BLRItem Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Item Amount';
        }
        field(73209581; "BLRStatus"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionMembers = " ","Complete","Partial";
        }
        field(73209582; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
        field(73209583; "BLRRemark"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Remark';
        }
        field(73209584; "BLRReference"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Reference';
        }
        field(73209585; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }


    }


    keys
    {
        key(PK;"BLREntry No.", "BLRID")
        {
            Clustered = true;
        }
    }
}
