table 73209589 "BLRBrokerageMasterData"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "BLRVendor ID";
    fields
    {

        field(73209575; "BLRVendor ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor ID';
            Editable = false;
        }

        field(73209576; "BLRProperty ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Property ID';
            Editable = false;
        }

        field(73209577; "BLRVendor Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Vendor Name';
        }

        field(73209578; "BLRProperty Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Name';
        }

        field(73209579; "BLRProperty Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Type';
        }
        field(73209580; "BLRCalculation Method"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Calculation Method';
            TableRelation = "BLRCalculationType"."BLRCalculation Type";
        }

        field(73209581; "BLRPercentage Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Percentage Type';
            OptionMembers = " ","Fixed","Variable";
        }
        field(73209582; "BLRBase Amount Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Base Amount Type';
            OptionMembers = " ","Revenue","Collection","Annual Rent","Monthly Rent";
        }
        field(73209583; "BLRFrequency Of Payment"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Frequency Of Payment';
            OptionMembers = " ","Monthly","Quaterly","Half Yearly","Yearly";
        }

        field(73209584; "BLRStart Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
        }

        field(73209585; "BLREnd Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
        }

        field(73209586; "BLRContract Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Status';
            OptionMembers = " ","Active","Terminate";
        }

        field(73209587; "BLRPercentage"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Percentage';
        }

        field(73209588; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
        field(73209589; "BLROwner ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Owner ID';
            Editable = false;
        }
        field(73209590; "BLROwner Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Owner Name';
            Editable = false;
        }
        field(73209591; "BLRUnit Number"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Number';
            Editable = false;
        }
        field(73209592; "BLRUnit Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Name';
            Editable = false;
        }
        field(73209593; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
            Editable = false;
        }
        field(73209594; "BLRTenant Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Name';
        }

        field(73209595; "BLRBase Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Base Amount';
        }
        field(73209596; "BLRProposal ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Proposal ID';
            Editable = false;
        }
    }


    keys
    {
        key(PK;"BLRVendor ID", "BLRVendor Name", "BLRProperty ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"BLRVendor ID", "BLRVendor Name", "BLRProperty ID")
        {

        }
    }

}
