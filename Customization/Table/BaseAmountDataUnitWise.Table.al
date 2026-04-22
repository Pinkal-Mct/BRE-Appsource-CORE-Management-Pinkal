table 73209585 "Base Amount Data Unit Wise"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(73209575; "Report Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(73209576; "Financial Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(73209577; "Period From"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(73209578; "Period To"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(73209579; "Property Management Company"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(73209580; "Company Owner Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(73209581; "Property Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(73209582; "Property Type"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(73209583; "Unit Number"; Code[30])
        {
            DataClassification = ToBeClassified;
        }

        field(73209584; "Unit Status"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(73209585; "Contract Id"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(73209586; "Multi Year Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(73209587; "Multi Year End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(73209588; "Contract Status"; Text[10])
        {
            DataClassification = ToBeClassified;
        }

        field(73209589; "Month"; Text[20])
        {

            DataClassification = ToBeClassified;
        }

        field(73209590; "Base Amount Source"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(73209591; Quantity; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(73209592; "Base Amount Type"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(73209593; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(73209594; "Header No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(73209595; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(73209596; "Total Quantity"; Integer)
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