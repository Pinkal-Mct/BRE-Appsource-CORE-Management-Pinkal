table 73209694 "Sub Unearned Revenue Report"
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
        field(73209576; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }

        field(73209577; "Customer Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Customer Name';
        }

        field(73209578; "Unit Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Name';
        }

        field(73209579; "Property"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property';
        }

        field(73209580; "Owner Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Owner Name';
        }

        field(73209581; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
        }

        field(73209582; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
        }

        field(73209583; "Termination Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Termination Date';
        }

        field(73209584; "Suspension Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Suspension Date';
        }

        field(73209585; "Contract Value"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Value';
        }

        field(73209586; "Contract Status"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Status';
        }

        field(73209587; "Opening Balance"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Opening Balance';
        }
        field(73209588; "Invoice Raised During the Year"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Raised During the Year';
        }
        field(73209589; "RevenueAllocated DuringtheYear"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Revenue Allocated During the Year';
        }
        field(73209590; "Unearned Revenue Balance"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unearned Revenue Balance';
        }
        field(73209591; "CalculatedUnearnedRevBalance"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Calculated Unearned Revenue Balance';
        }
        field(73209592; "Shortfall/Excess"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Shortfall/Excess';
        }
        field(73209593; "Header No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Header No.';
            Editable = false;
        }
        field(73209594; "Report Period"; Text[40])
        {
            DataClassification = CustomerContent;
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
