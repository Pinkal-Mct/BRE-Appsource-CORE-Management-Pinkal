table 73209676 "Revenue Recognition Details"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "RR_No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209576; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }
        field(73209577; "Property Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Name';
            Editable = false;
        }
        field(73209578; "Contract Id"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Id';
            Editable = false;
        }
        field(73209579; "Contract Tenure"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Tenure';
            Editable = false;
        }
        field(73209580; "Customer Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Customer Name';
            Editable = false;
        }
        field(73209581; "Contract Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start Date';
            Editable = false;
        }
        field(73209582; "Contract End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract End Date';
            Editable = false;
        }

        field(73209583; "Grace Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Grace Days';
            Editable = false;
        }
        field(73209584; "Termination Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Termination Date';
            Editable = false;
        }
        field(73209585; "Suspension Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Suspension Start Date';
            Editable = false;
        }
        field(73209586; "Suspension End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Suspension End Date';
            Editable = false;
        }
        field(73209587; "Multi Year Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Multi Year Start Date';
            Editable = false;
        }
        field(73209588; "Multi Year End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Multi Year End Date';
            Editable = false;
        }
        field(73209589; "Contract Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Amount';
            Editable = false;
        }
        field(73209590; "Annual Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Annual Amount';
            Editable = false;
        }
        field(73209591; "Posting Month"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Month';
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
            Editable = false;
        }
        field(73209592; "Posting Year"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Year';
            Editable = false;
        }
        field(73209593; "Posting Period"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Period';
            Editable = false;
        }
        field(73209594; "No Of Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No Of Days';
            Editable = false;
        }
        field(73209595; "Per Day Rent"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Per Day Rent';
            Editable = false;
        }
        field(73209596; "Total Value"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Value';
            Editable = false;
        }
        field(73209597; "Owner Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Owner Name';
            Editable = false;
        }
        field(73209598; "Owner Share"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Owner Share';
            Editable = false;
        }
        field(73209599; "Final Annual Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Final Annual Amount';
            Editable = false;
        }
        field(73209600; "Grace Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Grace Start Date';
            Editable = false;
        }
        field(73209601; "Grace End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Grace End Date';
            Editable = false;
        }
        field(73209602; "Per Month Rent"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Per Month Rent';
            Editable = false;
        }
        field(73209603; "Single Unit Names"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Single Unit Name';
            Editable = false;
        }
        field(73209604; "Item Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Type';
            Editable = false;
        }

        field(73209605; "Description"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
            Editable = false;
        }
        field(73209606; "Unit Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Type';
            Editable = false;
        }
        field(50133; "Revenue Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Revenue Start Date';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(SumKey; "RR_No.", "Contract Id", "Revenue Start Date")
        {
            SumIndexFields = "Total Value";
        }
    }
}
