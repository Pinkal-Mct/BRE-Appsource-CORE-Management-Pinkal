table 73209588 "Brokerage Calculation Sub"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "Owner ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Owner ID';
            Editable = false;
        }
        field(73209576; "Owner Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Owner Name';
            Editable = false;
        }
        field(73209577; "Property ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Property ID';
            Editable = false;
        }
        field(73209578; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
            Editable = false;
        }
        field(73209579; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
            Editable = false;
        }
        field(73209580; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
            Editable = false;
        }
        field(73209581; "Tenant Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Name';
            Editable = false;
        }
        field(73209582; "Property Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Name';
            Editable = false;
        }
        field(73209583; "Unit Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Name';
            Editable = false;
        }
        field(73209584; "Unit Number"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Number';
            Editable = false;
        }
        field(73209585; "Vendor ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor ID';
            Editable = false;
        }
        field(73209586; "Vendor Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Vendor Name';
            Editable = false;
        }
        field(73209587; "Brokerage Percentage"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Brokerage Percentage';
            Editable = false;
        }
        field(73209588; "Brokerage Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Brokerage Amount';
            Editable = false;
        }
        field(73209589; "Paid By"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Paid By';
            OptionMembers = " ","Owner","Tenant";
        }
        field(73209590; "Remark"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Remark';
        }
        field(73209591; "Action Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Action Date';
        }
        field(73209592; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
            Editable = false;
            AutoIncrement = true;
        }
        field(73209593; "ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            Editable = false;
        }
        field(73209594; "Total brokerage Amount"; Decimal)
        {
            // DataClassification = ToBeClassified;
            Caption = 'Total brokerage Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Brokerage Calculation Sub"."Brokerage Amount" where("ID" = field("ID"), "Owner ID" = field("Owner ID")));
        }
        field(73209595; "Percentage"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Brokerage Percentage';
            Editable = false;
        }
        field(73209596; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Brokerage Amount';
            Editable = false;
        }
        field(73209597; "Calculation Method"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Calculation Method';
            TableRelation = "Calculation Type"."Calculation Type";
            Editable = false;
        }
        field(73209598; "Base Amount Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Base Amount Type';
            OptionMembers = " ","Revenue","Collection","Annual Rent","Monthly Rent";
            Editable = false;
        }
        field(73209599; "Base Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Base Amount';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Entry No.", "ID")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Property ID", "Owner ID")
        {
        }
    }
}
