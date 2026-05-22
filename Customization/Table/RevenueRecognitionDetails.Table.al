table 73209676 "BLRRevenueRecognitionDetails"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "BLRRR_No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209576; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }
        field(73209577; "BLRProperty Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Name';
            Editable = false;
        }
        field(73209578; "BLRContract Id"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Id';
            Editable = false;
        }
        field(73209579; "BLRContract Tenure"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Tenure';
            Editable = false;
        }
        field(73209580; "BLRCustomer Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Customer Name';
            Editable = false;
        }
        field(73209581; "BLRContract Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start Date';
            Editable = false;
        }
        field(73209582; "BLRContract End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract End Date';
            Editable = false;
        }

        field(73209583; "BLRGrace Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Grace Days';
            Editable = false;
        }
        field(73209584; "BLRTermination Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Termination Date';
            Editable = false;
        }
        field(73209585; "BLRSuspension Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Suspension Start Date';
            Editable = false;
        }
        field(73209586; "BLRSuspension End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Suspension End Date';
            Editable = false;
        }
        field(73209587; "BLRMulti Year Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Multi Year Start Date';
            Editable = false;
        }
        field(73209588; "BLRMulti Year End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Multi Year End Date';
            Editable = false;
        }
        field(73209589; "BLRContract Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Amount';
            Editable = false;
        }
        field(73209590; "BLRAnnual Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Annual Amount';
            Editable = false;
        }
        field(73209591; "BLRPosting Month"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Month';
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
            Editable = false;
        }
        field(73209592; "BLRPosting Year"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Year';
            Editable = false;
        }
        field(73209593; "BLRPosting Period"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Period';
            Editable = false;
        }
        field(73209594; "BLRNo Of Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No Of Days';
            Editable = false;
        }
        field(73209595; "BLRPer Day Rent"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Per Day Rent';
            Editable = false;
        }
        field(73209596; "BLRTotal Value"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Value';
            Editable = false;
        }
        field(73209597; "BLROwner Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Owner Name';
            Editable = false;
        }
        field(73209598; "BLROwner Share"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Owner Share';
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
        field(73209604; "BLRItem Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Type';
            Editable = false;
        }

        field(73209605; "BLRDescription"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
            Editable = false;
        }
        field(73209606; "BLRUnit Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Type';
            Editable = false;
        }
        field(50133; "BLRRevenue Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Revenue Start Date';
            Editable = false;
        }
    }

    keys
    {
        key(PK;"BLREntry No.")
        {
            Clustered = true;
        }
        key(SumKey;"BLRRR_No.", "BLRContract Id", "BLRRevenue Start Date")
        {
            SumIndexFields = "BLRTotal Value";
        }
    }
}
