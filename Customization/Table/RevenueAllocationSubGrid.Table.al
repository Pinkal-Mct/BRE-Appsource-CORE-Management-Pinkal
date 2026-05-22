table 73209672 "BLRRevenueAllocationSubGrid"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "BLRLine No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
            Editable = false;
        }
        field(73209576; "BLRProperty Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Name';
            Editable = false;
        }
        field(73209577; "BLRContract Id"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Id';
            Editable = false;
        }
        field(73209578; "BLRContract Tenure"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Tenure';
            Editable = false;
        }
        field(73209579; "BLRCustomer Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Customer Name';
            Editable = false;
        }
        field(73209580; "BLRContract Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start Date';
            Editable = false;
        }
        field(73209581; "BLRContract End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract End Date';
            Editable = false;
        }

        field(73209582; "BLRGrace Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Grace Days';
            Editable = false;
        }
        field(73209583; "BLRTermination Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Termination Date';
            Editable = false;
        }
        field(73209584; "BLRSuspension Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Suspension Start Date';
            Editable = false;
        }
        field(73209585; "BLRSuspension End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Suspension End Date';
            Editable = false;
        }
        field(73209586; "BLRMulti Year Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Multi Year Start Date';
            Editable = false;
        }
        field(73209587; "BLRMulti Year End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Multi Year End Date';
            Editable = false;
        }
        field(73209588; "BLRContract Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Amount';
            Editable = false;
        }
        field(73209589; "BLRAnnual Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Annual Amount';
            Editable = false;
        }
        field(73209590; "BLRPosting Month"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Month';
            // OptionCaption = 'January,February,March,April,May,June,July,August,September,October,November,December';
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
            Editable = false;
        }
        field(73209591; "BLRPosting Year"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Year';
            Editable = false;
        }
        field(73209592; "BLRPosting Period"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Period';
            Editable = false;
        }
        field(73209593; "BLRNo Of Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No Of Days';
            Editable = false;
        }
        field(73209594; "BLRPer Day Rent"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Per Day Rent';
            Editable = false;
        }
        field(73209595; "BLRTotal Value"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Value';
            Editable = false;
        }
        field(73209596; "BLROwner Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Owner Name';
            Editable = false;
        }
        field(73209597; "BLROwner Share"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Owner Share';
            Editable = false;
        }
        field(73209598; "BLRHeader No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Header No.';
            Editable = false;
        }
        field(73209599; "BLRFinal Annual Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Final Annual Amount';
            Editable = false;
        }
        field(73209600; "BLRGrace Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Grace Start Date';
            Editable = false;
        }
        field(73209601; "BLRGrace End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Grace End Date';
            Editable = false;
        }
        field(73209602; "BLRPer Month Rent"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Per Month Rent';
            Editable = false;
        }
        field(73209603; "BLRSingle Unit Names"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Single Unit Name';
            Editable = false;
        }
        field(73209604; "BLRDescription"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
            Editable = false;
        }

        field(73209605; "BLRUnit Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Type';
            Editable = false;
        }
        field(50131; "BLRRevenue Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Revenue Start Date';
        }

    }

    keys
    {
        key(Key1;"BLRHeader No.", "BLRLine No.")
        {
            Clustered = true;
        }
        key(SumKey;"BLRHeader No.", "BLRContract Id", "BLRRevenue Start Date")
        {
            SumIndexFields = "BLRTotal Value";
        }

    }

}
