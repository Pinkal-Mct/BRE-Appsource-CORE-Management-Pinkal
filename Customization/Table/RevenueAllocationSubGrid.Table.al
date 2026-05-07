table 73209672 "Revenue Allocation SubGrid"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
            Editable = false;
        }
        field(73209576; "Property Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Name';
            Editable = false;
        }
        field(73209577; "Contract Id"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Id';
            Editable = false;
        }
        field(73209578; "Contract Tenure"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Tenure';
            Editable = false;
        }
        field(73209579; "Customer Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Customer Name';
            Editable = false;
        }
        field(73209580; "Contract Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start Date';
            Editable = false;
        }
        field(73209581; "Contract End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract End Date';
            Editable = false;
        }

        field(73209582; "Grace Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Grace Days';
            Editable = false;
        }
        field(73209583; "Termination Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Termination Date';
            Editable = false;
        }
        field(73209584; "Suspension Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Suspension Start Date';
            Editable = false;
        }
        field(73209585; "Suspension End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Suspension End Date';
            Editable = false;
        }
        field(73209586; "Multi Year Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Multi Year Start Date';
            Editable = false;
        }
        field(73209587; "Multi Year End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Multi Year End Date';
            Editable = false;
        }
        field(73209588; "Contract Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Amount';
            Editable = false;
        }
        field(73209589; "Annual Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Annual Amount';
            Editable = false;
        }
        field(73209590; "Posting Month"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Month';
            // OptionCaption = 'January,February,March,April,May,June,July,August,September,October,November,December';
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
            Editable = false;
        }
        field(73209591; "Posting Year"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Year';
            Editable = false;
        }
        field(73209592; "Posting Period"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Period';
            Editable = false;
        }
        field(73209593; "No Of Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No Of Days';
            Editable = false;
        }
        field(73209594; "Per Day Rent"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Per Day Rent';
            Editable = false;
        }
        field(73209595; "Total Value"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Value';
            Editable = false;
        }
        field(73209596; "Owner Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Owner Name';
            Editable = false;
        }
        field(73209597; "Owner Share"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Owner Share';
            Editable = false;
        }
        field(73209598; "Header No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Header No.';
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
        field(73209604; "Description"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
            Editable = false;
        }

        field(73209605; "Unit Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Type';
            Editable = false;
        }
        field(50131; "Revenue Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Revenue Start Date';
        }

    }

    keys
    {
        key(Key1; "Header No.", "Line No.")
        {
            Clustered = true;
        }
        key(SumKey; "Header No.", "Contract Id", "Revenue Start Date")
        {
            SumIndexFields = "Total Value";
        }

    }

}
