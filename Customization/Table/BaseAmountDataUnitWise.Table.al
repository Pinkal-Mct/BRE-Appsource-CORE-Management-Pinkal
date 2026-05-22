table 73209585 "BLRBaseAmountDataUnitWise"
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

        field(73209588; "BLRContract Status"; Text[10])
        {
            DataClassification = CustomerContent;
        }

        field(73209589; "BLRMonth"; Text[20])
        {

            DataClassification = CustomerContent;
        }

        field(73209590; "BLRBase Amount Source"; Code[50])
        {
            DataClassification = CustomerContent;
        }

        field(73209591; "BLRQuantity"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209592; "BLRBase Amount Type"; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209593; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209594; "BLRHeader No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209595; "BLRLine No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209596; "BLRTotal Quantity"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = sum("BLRBaseAmountDataUnitWise"."BLRQuantity" where("BLRHeader No." = FIELD("BLRHeader No."), "BLRLine No." = field("BLRLine No.")));
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
