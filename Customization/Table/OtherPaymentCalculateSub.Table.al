table 73209641 "BLROtherPaymentCalculateSub"
{
    DataClassification = CustomerContent;
    fields
    {

        field(73209575; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }

        field(73209576; "BLRSecondary Item Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Secondary Item Type';
            Editable = false;
        }

        field(73209577; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
            Editable = false;
        }

        field(73209578; "BLRStart Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
            Editable = false;
        }

        field(73209579; "BLREnd Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
            Editable = false;
        }

        field(73209580; "BLRVAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Amount';
            Editable = false;
        }

        field(73209581; "BLRAmount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount Including VAT';
            Editable = false;
        }

        field(73209582; "BLRTenant ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
            Editable = false;
        }

        field(73209583; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
            Editable = false;
            AutoIncrement = true;
        }

        field(73209584; "BLRTotal Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("BLROtherPaymentCalculateSub"."BLRAmount" where("BLRContract ID" = field("BLRContract ID"), "BLRTenant ID" = field("BLRTenant ID")));
        }

        field(73209585; "BLRTotal VAT Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("BLROtherPaymentCalculateSub"."BLRVAT Amount" where("BLRContract ID" = field("BLRContract ID"), "BLRTenant ID" = field("BLRTenant ID")));
        }

        field(73209586; "BLRTotal Amount Including VAT"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("BLROtherPaymentCalculateSub"."BLRAmount Including VAT" where("BLRContract ID" = field("BLRContract ID"), "BLRTenant ID" = field("BLRTenant ID")));
        }
    }

    keys
    {
        key(PK;"BLRContract ID", "BLREntry No.")
        {
            Clustered = true;
        }
    }


}





