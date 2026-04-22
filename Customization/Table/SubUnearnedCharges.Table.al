table 73209693 "Sub Unearned Charges"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(73209575; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Line No.';
            Editable = false;
        }
        field(73209576; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }

        field(73209577; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Name';
        }

        field(73209578; "Unit Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Name';
        }

        field(73209579; "Property"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property';
        }

        field(73209580; "Owner Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Owner Name';
        }

        field(73209581; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';
        }

        field(73209582; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';
        }

        field(73209583; "Termination Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Termination Date';
        }

        field(73209584; "Suspension Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Suspension Date';
        }

        field(73209585; "Other Charges Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Other Charges Value';
        }

        field(73209586; "Contract Status"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Status';
        }

        field(73209587; "Opening Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Opening Balance';
        }
        field(73209588; "Invoice Raised During the Year"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Invoice Raised During the Year';
        }
        field(73209589; "RevenueAllocated DuringtheYear"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Revenue Allocated During the Year';
        }
        field(73209590; "Unearned Revenue Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Unearned Revenue Balance';
        }
        field(73209591; "CalculatedUnearnedRevBalance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Calculated Unearned Revenue Balance';
        }
        field(73209592; "Shortfall/Excess"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Shortfall/Excess';
        }
        field(73209593; "Header No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Header No.';
            Editable = false;
        }
        field(73209594; "Report Period"; Text[40])
        {
            DataClassification = ToBeClassified;
            Caption = 'Report Period';
        }
    }
    keys
    {
        key(Key1; "Header No.", "Line No.")
        {
            Clustered = true;
        }

    }
}