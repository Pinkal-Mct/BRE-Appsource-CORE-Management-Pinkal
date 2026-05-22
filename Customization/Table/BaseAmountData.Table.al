table 73209583 "BLRBaseAmountData"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "BLRReport Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(73209576; "BLRFinancial Year"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(73209577; "BLRPeriod From"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(73209578; "BLRPeriod To"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(73209579; "BLRProperty Management Company"; Text[100])
        {
            DataClassification = OrganizationIdentifiableInformation;
        }

        field(73209580; "BLRCompany Owner Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
        }

        field(73209581; "BLRProperty Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }

        field(73209582; "BLRProperty Type"; Text[100])
        {
            DataClassification = CustomerContent;
        }

        field(73209583; "BLRUnit Number"; Code[30])
        {
            DataClassification = CustomerContent;
        }

        field(73209584; "BLRUnit Status"; Text[20])
        {
            DataClassification = CustomerContent;
        }

        field(73209585; "BLRContract Id"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(73209586; "BLRMulti Year Start Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(73209587; "BLRMulti Year End Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(73209588; "BLRAnnual Rent Amount"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
        }

        field(73209589; "BLRContract Status"; Text[10])
        {
            DataClassification = CustomerContent;
        }

        field(73209590; "BLRMonth"; Text[20])
        {

            DataClassification = CustomerContent;
        }

        field(73209591; "BLRBase Amount Source"; Code[50])
        {
            DataClassification = CustomerContent;
        }

        field(73209592; "BLRQuantity"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209593; "BLRBase Amount Type"; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209594; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209595; "BLRHeader No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209596; "BLRLine No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209597; "BLRTotal Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("BLRBaseAmountData"."BLRBase Amount" where("BLRHeader No." = field("BLRHeader No."), "BLRLine No." = field("BLRLine No.")));
            DecimalPlaces = 0 : 2;
        }
        field(73209598; "BLRBase Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
        }
        field(73209599; "BLRReceipt Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209600; "BLRReceipt No."; Text[100])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key("PK";"BLREntry No.", "BLRHeader No.", "BLRLine No.")
        {
            Clustered = true;
        }
    }
}
