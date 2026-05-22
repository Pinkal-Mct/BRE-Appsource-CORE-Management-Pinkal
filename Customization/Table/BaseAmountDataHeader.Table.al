table 73209584 "BLRBaseAmountDataHeader"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "BLRHeader No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209576; "BLRLine No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209577; "BLRBase Amount Type"; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209578; "BLRNo."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
    }
    keys
    {
        key("PK";"BLRNo.", "BLRHeader No.", "BLRLine No.")
        {
            Clustered = true;
        }
    }
    trigger OnDelete()
    var
        baseAmountData: Record "BLRBaseAmountData";
        baseAmountDataUnitWise: Record "BLRBaseAmountDataUnitWise";
    begin
        baseAmountData.SetRange("BLRHeader No.", Rec."BLRHeader No.");
        baseAmountData.SetRange("BLRLine No.", Rec."BLRLine No.");
        if baseAmountData.FindSet() then
            baseAmountData.DeleteAll(true);

        baseAmountDataUnitWise.SetRange("BLRHeader No.", Rec."BLRHeader No.");
        baseAmountDataUnitWise.SetRange("BLRLine No.", Rec."BLRLine No.");
        if baseAmountDataUnitWise.FindSet() then
            baseAmountDataUnitWise.DeleteAll(true);
    end;
}

