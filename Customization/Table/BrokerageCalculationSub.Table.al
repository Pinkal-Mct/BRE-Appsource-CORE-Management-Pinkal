table 73209588 "BLRBrokerageCalculationSub"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLROwner ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Owner ID';
            Editable = false;
        }
        field(73209576; "BLROwner Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Owner Name';
            Editable = false;
        }
        field(73209577; "BLRProperty ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Property ID';
            Editable = false;
        }
        field(73209578; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
            Editable = false;
        }
        field(73209579; "BLRStart Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
            Editable = false;
        }
        field(73209580; "BLREnd Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
            Editable = false;
        }
        field(73209581; "BLRTenant Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Name';
            Editable = false;
        }
        field(73209582; "BLRProperty Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Name';
            Editable = false;
        }
        field(73209583; "BLRUnit Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Name';
            Editable = false;
        }
        field(73209584; "BLRUnit Number"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Number';
            Editable = false;
        }
        field(73209585; "BLRVendor ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor ID';
            Editable = false;
        }
        field(73209586; "BLRVendor Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Vendor Name';
            Editable = false;
        }
        field(73209587; "BLRBrokerage Percentage"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Brokerage Percentage';
            Editable = false;
        }
        field(73209588; "BLRBrokerage Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Brokerage Amount';
            Editable = false;
        }
        field(73209589; "BLRPaid By"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Paid By';
            OptionMembers = " ","Owner","Tenant";
        }
        field(73209590; "BLRRemark"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Remark';
        }
        field(73209591; "BLRAction Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Action Date';
        }
        field(73209592; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
            Editable = false;
            AutoIncrement = true;
        }
        field(73209593; "BLRID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            Editable = false;
        }
        field(73209594; "BLRTotal brokerage Amount"; Decimal)
        {
            // DataClassification = ToBeClassified;
            Caption = 'Total brokerage Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("BLRBrokerageCalculationSub"."BLRBrokerage Amount" where("BLRID" = field("BLRID"), "BLROwner ID" = field("BLROwner ID")));
        }
        field(73209595; "BLRPercentage"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Brokerage Percentage';
            Editable = false;
        }
        field(73209596; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Brokerage Amount';
            Editable = false;
        }
        field(73209597; "BLRCalculation Method"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Calculation Method';
            TableRelation = "BLRCalculationType"."BLRCalculation Type";
            Editable = false;
        }
        field(73209598; "BLRBase Amount Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Base Amount Type';
            OptionMembers = " ","Revenue","Collection","Annual Rent","Monthly Rent";
            Editable = false;
        }
        field(73209599; "BLRBase Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Base Amount';
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
    fieldgroups
    {
        fieldgroup(DropDown;"BLRProperty ID", "BLROwner ID")
        {
        }
    }
}
