table 73209706 "BLRUnearnedRevenueReport"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "BLRNo.";
    fields
    {
        field(73209575; "BLRNo."; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
            AutoIncrement = true;
            Caption = 'ID';
        }
        field(73209576; "BLRStarting Date Year"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Starting Date Year';

            trigger OnValidate()
            begin
                if (Date2DMY("BLRStarting Date Year", 1) <> 1) or (Date2DMY("BLRStarting Date Year", 2) <> 1) then
                    Error('Starting Date must be 1st January of the year.');

                if ("BLRStarting Date Year" <> 0D) and ("BLREnding Date Year" <> 0D) then
                    if "BLRStarting Date Year" > "BLREnding Date Year" then
                        Error('Starting Date Year cannot be greater than "BLREnding Date Year".');
            end;
        }
        field(73209577; "BLREnding Date Year"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Ending Date Year';

            trigger OnValidate()
            begin
                if "BLREnding Date Year" < "BLRStarting Date Year" then
                    Error('Ending Date Year cannot be less than "BLRStarting Date Year".');
            end;
        }

        field(73209578; "BLRR_Total Contract Value"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Contract Value';
            Editable = false;
        }

        field(73209579; "BLRR_Total Opening Balance"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Opening Balance';
            Editable = false;
        }

        field(73209580; "BLRRTInvRaisedDurYear"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Invoice Raised During Year';
            Editable = false;
        }

        field(73209581; "BLRRTRevAllocDurY"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Revenue Allocated During Year';
            Editable = false;
        }

        field(73209582; "BLRRTUnearnedRevBalance"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Unearned Revenue Balance';
            Editable = false;
        }

        field(73209583; "BLRTotal G/L Balance"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(73209584; "BLRR_Total Shortfall Excess"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Shortfall/Excess';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "BLRNo.") { Clustered = true; }
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
        unearnedrevenuerentsubgrid: Record "BLRSubUnearnedRevenueReport";
    begin
        unearnedrevenuerentsubgrid.SetRange("BLRHeader No.", Rec."BLRNo.");
        if unearnedrevenuerentsubgrid.FindSet() then
            unearnedrevenuerentsubgrid.DeleteAll();
    end;

    procedure Deletesubunearnedrevenuereportitem()
    var
        unearnedrevenuereportitem: Record "BLROtherChargesUnearnedRevenue";
    begin
        unearnedrevenuereportitem.SetRange("BLRNo.", Rec."BLRNo.");
        if unearnedrevenuereportitem.FindSet() then
            unearnedrevenuereportitem.DeleteAll();
    end;

    procedure Deleteunearnedrevenueotherrevenue()
    var
        unearnedrevenueothercharges: Record "BLRSubUnearnedCharges";
    begin
        unearnedrevenueothercharges.SetRange("BLRHeader No.", Rec."BLRNo.");
        if unearnedrevenueothercharges.FindSet() then
            unearnedrevenueothercharges.DeleteAll();
    end;
}
