table 73209673 "BLRRevenueCalculateSub"
{
    DataClassification = CustomerContent;

    fields
    {

        field(73209575; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }

        field(73209576; "BLRRS ID"; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
            Editable = false;
        }

        field(73209577; "BLRSecondary Item Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Secondary Item Type';
            Editable = false;
        }

        field(73209578; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
            Editable = false;
        }

        field(73209579; "BLRInstallment Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Installment Start Date';
            Editable = false;
        }

        field(73209580; "BLRInstallment End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Installment End Date';
            Editable = false;
        }

        field(73209581; "BLRVAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Amount';
            Editable = false;
        }

        field(73209582; "BLRAmount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount Including VAT';
            Editable = false;
        }

        field(73209583; "BLRTenant ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
            Editable = false;
        }


        field(73209584; "BLRTotal Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("BLRRevenueCalculateSub"."BLRAmount" where("BLRContract ID" = field("BLRContract ID"), "BLRTenant ID" = field("BLRTenant ID")));
        }

        field(73209585; "BLRTotal VAT Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("BLRRevenueCalculateSub"."BLRVAT Amount" where("BLRContract ID" = field("BLRContract ID"), "BLRTenant ID" = field("BLRTenant ID")));
        }

        field(73209586; "BLRTotal Amount Including VAT"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("BLRRevenueCalculateSub"."BLRAmount Including VAT" where("BLRContract ID" = field("BLRContract ID"), "BLRTenant ID" = field("BLRTenant ID")));
        }

    }
    keys
    {
        key(PK;"BLRRS ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"BLRContract ID")
        {

        }
    }

}





