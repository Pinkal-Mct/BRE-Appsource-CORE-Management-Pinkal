table 73209630 "Management Fee Calc. Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(73209575; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(73209576; "Header No."; Integer)
        {
            DataClassification = SystemMetadata;
            Caption = 'Header No.';
        }
        field(73209577; "Vendor ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(73209578; "Company/Owner Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(73209579; "Property Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        // 3. Property Type
        field(73209580; "Property Type"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        // 4. Calculation Method
        field(73209581; "Calculation Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers =
                " ","Percentage of Monthly Revenue","Percentage of Annual Rent","Percentage of Collections","Per Unit Fee",Hybrid;
        }

        // 5. Calculation Sub-Type
        field(73209582; "Calculation Sub-Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Percentage Based","Fixed Amount";
        }

        field(73209583; "Percentage Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "",Fixed,Variable;
        }

        field(73209584; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(73209585; "Base Amount Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Revenue,Collections,"Annual Rent","Number of Units";
        }
        field(73209586; "Base Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(73209587; "Valid From"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(73209588; "Valid To"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(73209589; "Contract Status"; Option)
        {
            OptionMembers = Active,Expired;
            DataClassification = ToBeClassified;

        }

        field(73209590; "Management Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73209591; "Validity Period"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(73209592; "Property Management Company"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(73209593; Percentage; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73209594; "Owner ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(73209595; "Total Mgt. Fee"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Management Fee Calc. Line"."Management Fee" where("Header No." = field("Header No.")));
        }
        field(73209596; "Base Amount Details"; Text[12])
        {
            DataClassification = ToBeClassified;
            InitValue = 'View Details';
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Header No.")
        {
            Clustered = true;
        }
    }
    trigger OnDelete()
    var
        baseAmountHeader: Record "Base Amount Data Header";
    begin
        baseAmountHeader.SetRange("Header No.", Rec."Header No.");
        baseAmountHeader.SetRange("Line No.", Rec."Entry No.");
        if baseAmountHeader.FindSet() then
            baseAmountHeader.DeleteAll(true);
    end;

}