table 53767 "Base Amount Data"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(53700; "Report Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(53701; "Financial Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(53702; "Period From"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(53703; "Period To"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(53704; "Property Management Company"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(53705; "Company Owner Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(53706; "Property Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(53707; "Property Type"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(53708; "Unit Number"; Code[30])
        {
            DataClassification = ToBeClassified;
        }

        field(53709; "Unit Status"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(53710; "Contract Id"; Code[30])
        {
            DataClassification = ToBeClassified;
        }

        field(53711; "Multi Year Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(53712; "Multi Year End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(53713; "Annual Rent Amount"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            DataClassification = ToBeClassified;
        }

        field(53714; "Contract Status"; Text[10])
        {
            DataClassification = ToBeClassified;
        }

        field(53715; "Month"; Text[20])
        {

            DataClassification = ToBeClassified;
        }

        field(53716; "Base Amount Source"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(53717; Quantity; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(53718; "Base Amount Type"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53719; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(53720; "Header No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(53721; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(53722; "Total Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
        }
    }
    keys
    {
        key("PK"; "Entry No.", "Header No.", "Line No.")
        {
            Clustered = true;
        }
    }
}