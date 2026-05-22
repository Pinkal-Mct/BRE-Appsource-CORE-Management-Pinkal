table 73209663 "BLRRentCalculateSub"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "BLRYear"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Year';
            Editable = false;
        }

        field(73209576; "BLRPeriod Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
            Editable = false;
        }
        field(73209577; "BLRPeriod End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
            Editable = false;
        }

        field(73209578; "BLRNumber of Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Number of Days';
            Editable = false;
        }
        field(73209579; "BLRFinal Annual Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Final Annual Amount';
            Editable = true;
        }

        field(73209580; "BLRPer Day Rent"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Per Day Rent';
            Editable = false;
        }

        field(73209581; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }

        field(73209582; "BLRRC ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'RC ID';

        }

        field(73209583; "BLRTenant Id"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';

        }

        field(73209584; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';

        }

        field(73209585; "BLRTotal Number of Days"; Integer)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("BLRRentCalculateSub"."BLRNumber of Days" where("BLRContract ID" = field("BLRContract ID"), "BLRTenant Id" = field("BLRTenant Id")));
        }


        field(73209586; "BLRTotal Final Annual Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("BLRRentCalculateSub"."BLRFinal Annual Amount" where("BLRContract ID" = field("BLRContract ID"), "BLRTenant Id" = field("BLRTenant Id")));
        }
    }

    keys
    {
        key(Key1;"BLREntry No.", "BLRRC ID")
        {
            Clustered = true;
        }
    }

}





