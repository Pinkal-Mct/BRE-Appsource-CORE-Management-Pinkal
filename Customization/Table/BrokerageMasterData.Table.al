table 73209589 "Brokerage Master Data"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "Vendor ID";
    fields
    {

        field(73209575; "Vendor ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor ID';
            Editable = false;
        }

        field(73209576; "Property ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Property ID';
            Editable = false;
        }

        field(73209577; "Vendor Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Vendor Name';
        }

        field(73209578; "Property Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Name';
        }

        field(73209579; "Property Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Type';
        }
        field(73209580; "Calculation Method"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Calculation Method';
            TableRelation = "Calculation Type"."Calculation Type";
        }

        field(73209581; "Percentage Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Percentage Type';
            OptionMembers = " ","Fixed","Variable";
        }
        field(73209582; "Base Amount Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Base Amount Type';
            OptionMembers = " ","Revenue","Collection","Annual Rent","Monthly Rent";
        }
        field(73209583; "Frequency Of Payment"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Frequency Of Payment';
            OptionMembers = " ","Monthly","Quaterly","Half Yearly","Yearly";
        }

        field(73209584; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
        }

        field(73209585; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
        }

        field(73209586; "Contract Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Status';
            OptionMembers = " ","Active","Terminate";
        }

        field(73209587; "Percentage"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Percentage';
        }

        field(73209588; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
        field(73209589; "Owner ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Owner ID';
            Editable = false;
        }
        field(73209590; "Owner Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Owner Name';
            Editable = false;
        }
        field(73209591; "Unit Number"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Number';
            Editable = false;
        }
        field(73209592; "Unit Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Name';
            Editable = false;
        }
        field(73209593; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
            Editable = false;
        }
        field(73209594; "Tenant Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Name';
        }

        field(73209595; "Base Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Base Amount';
        }
        field(73209596; "Proposal ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Proposal ID';
            Editable = false;
        }
    }


    keys
    {
        key(PK; "Vendor ID", "Vendor Name", "Property ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Vendor ID", "Vendor Name", "Property ID")
        {

        }
    }

}
