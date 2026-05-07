table 73209671 "Revenue Allocation Details"
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
        field(73209576; "Financial Year"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Financial Year';
        }
        field(73209577; "Month"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Month';
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
        }
        field(73209578; "Status"; Option)
        {
            OptionMembers = "Pending","Approve","Reject";
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "No.") { Clustered = true; }
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
        revenueallocationsubgrid: Record "Revenue Allocation SubGrid";
    begin
        revenueallocationsubgrid.SetRange("Header No.", Rec."No.");
        if revenueallocationsubgrid.FindSet() then
            revenueallocationsubgrid.DeleteAll();
    end;

    procedure Deletesubrevenueallocationitem()
    var
        revenueallocationitem: Record "Revenue Recognition Item";
    begin
        revenueallocationitem.SetRange("RR_No.", Rec."No.");
        if revenueallocationitem.FindSet() then
            revenueallocationitem.DeleteAll();
    end;

    procedure Deletesubrevenueallocationotherrevenue()
    var
        revenueallocationothercharges: Record "Revenue Recognition Details";
    begin
        revenueallocationothercharges.SetRange("RR_No.", Rec."No.");
        if revenueallocationothercharges.FindSet() then
            revenueallocationothercharges.DeleteAll();
    end;
}
