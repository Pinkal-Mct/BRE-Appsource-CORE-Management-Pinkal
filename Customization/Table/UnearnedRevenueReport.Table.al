table 73209706 "Unearned Revenue Report"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "No.";
    fields
    {
        field(73209575; "No."; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
            AutoIncrement = true;
            Caption = 'ID';
        }
        field(73209576; "Starting Date Year"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Starting Date Year';

            trigger OnValidate()
            begin
                if (Date2DMY("Starting Date Year", 1) <> 1) or (Date2DMY("Starting Date Year", 2) <> 1) then
                    Error('Starting Date must be 1st January of the year.');

                if ("Starting Date Year" <> 0D) and ("Ending Date Year" <> 0D) then
                    if "Starting Date Year" > "Ending Date Year" then
                        Error('Starting Date Year cannot be greater than Ending Date Year.');
            end;
        }
        field(73209577; "Ending Date Year"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Ending Date Year';

            trigger OnValidate()
            begin
                if "Ending Date Year" < "Starting Date Year" then
                    Error('Ending Date Year cannot be less than Starting Date Year.');
            end;
        }

        field(73209578; "R_Total Contract Value"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Contract Value';
            Editable = false;
        }

        field(73209579; "R_Total Opening Balance"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Opening Balance';
            Editable = false;
        }

        field(73209580; "R_T_Invoice Raised During Year"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Invoice Raised During Year';
            Editable = false;
        }

        field(73209581; "R_T_Revenue Allocated During Y"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Revenue Allocated During Year';
            Editable = false;
        }

        field(73209582; "R_T_Unearned Revenue Balance"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Unearned Revenue Balance';
            Editable = false;
        }

        field(73209583; "R_T_Cal Unearned RevBalance"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Calculated Unearned Rev Balance';
            Editable = false;
        }

        field(73209584; "R_Total Shortfall Excess"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Shortfall/Excess';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "No.") { Clustered = true; }
    }


    trigger OnDelete()
    var
    begin
        Deleteunearnedrentrevenue();
        Deleteunearnedrevenueotherrevenue();
        Deletesubunearnedrevenuereportitem();

    end;

    procedure Deleteunearnedrentrevenue()
    var
        unearnedrevenuerentsubgrid: Record "Sub Unearned Revenue Report";
    begin
        unearnedrevenuerentsubgrid.SetRange("Header No.", Rec."No.");
        if unearnedrevenuerentsubgrid.FindSet() then
            unearnedrevenuerentsubgrid.DeleteAll();
    end;

    procedure Deletesubunearnedrevenuereportitem()
    var
        unearnedrevenuereportitem: Record "Other Charges UnearnedRevenue";
    begin
        unearnedrevenuereportitem.SetRange("No.", Rec."No.");
        if unearnedrevenuereportitem.FindSet() then
            unearnedrevenuereportitem.DeleteAll();
    end;

    procedure Deleteunearnedrevenueotherrevenue()
    var
        unearnedrevenueothercharges: Record "Sub Unearned Charges";
    begin
        unearnedrevenueothercharges.SetRange("Header No.", Rec."No.");
        if unearnedrevenueothercharges.FindSet() then
            unearnedrevenueothercharges.DeleteAll();
    end;
}
