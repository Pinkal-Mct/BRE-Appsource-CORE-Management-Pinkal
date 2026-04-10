table 53769 "Base Amount Data Unit Wise"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(53700; "Report Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(53701; "Financial Year"; Integer)
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

        field(53704; "Property Management Company"; Text[100])
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

        field(53707; "Property Type"; Text[100])
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

        field(53710; "Contract Id"; Integer)
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
        field(53724; "Total Quantity"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Base Amount Data Unit Wise".Quantity where("Header No." = FIELD("Header No."), "Line No." = field("Line No.")));
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