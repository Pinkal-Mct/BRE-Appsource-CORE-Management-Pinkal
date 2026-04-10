table 53768 "Base Amount Data Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(53700; "Header No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(53701; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(53702; "Base Amount Type"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53703; "No."; Integer)
        {
            DataClassification = ToBeClassified;
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

