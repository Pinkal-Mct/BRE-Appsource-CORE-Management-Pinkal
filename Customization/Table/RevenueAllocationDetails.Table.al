table 73209671 "BLRRevenueAllocationDetails"
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
        field(73209576; "BLRFinancial Year"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Financial Year';
        }
        field(73209577; "BLRMonth"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Month';
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
        }
        field(73209578; "BLRStatus"; Option)
        {
            OptionMembers = "Pending","Approve","Reject";
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK;"BLRNo.") { Clustered = true; }
    }
    trigger OnDelete()
    var
    begin
        Deletesubrevenueallocation();
        Deletesubrevenueallocationotherrevenue();
        Deletesubrevenueallocationitem();
    end;

    procedure Deletesubrevenueallocation()
    var
        revenueallocationsubgrid: Record "BLRRevenueAllocationSubGrid";
    begin
        revenueallocationsubgrid.SetRange("BLRHeader No.", Rec."BLRNo.");
        if revenueallocationsubgrid.FindSet() then
            revenueallocationsubgrid.DeleteAll();
    end;

    procedure Deletesubrevenueallocationitem()
    var
        revenueallocationitem: Record "BLRRevenueRecognitionItem";
    begin
        revenueallocationitem.SetRange("BLRRR_No.", Rec."BLRNo.");
        if revenueallocationitem.FindSet() then
            revenueallocationitem.DeleteAll();
    end;

    procedure Deletesubrevenueallocationotherrevenue()
    var
        revenueallocationothercharges: Record "BLRRevenueRecognitionDetails";
    begin
        revenueallocationothercharges.SetRange("BLRRR_No.", Rec."BLRNo.");
        if revenueallocationothercharges.FindSet() then
            revenueallocationothercharges.DeleteAll();
    end;
}
