table 73209584 "Base Amount Data Header"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "Header No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209576; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209577; "Base Amount Type"; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209578; "No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
    }
    keys
    {
        key("PK"; "No.", "Header No.", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnDelete()
    var
        baseAmountData: Record "Base Amount Data";
        baseAmountDataUnitWise: Record "Base Amount Data Unit Wise";
    begin
        baseAmountData.SetRange("Header No.", Rec."Header No.");
        baseAmountData.SetRange("Line No.", Rec."Line No.");
        if baseAmountData.FindSet() then
            baseAmountData.DeleteAll(true);

        baseAmountDataUnitWise.SetRange("Header No.", Rec."Header No.");
        baseAmountDataUnitWise.SetRange("Line No.", Rec."Line No.");
        if baseAmountDataUnitWise.FindSet() then
            baseAmountDataUnitWise.DeleteAll(true);
    end;
}

