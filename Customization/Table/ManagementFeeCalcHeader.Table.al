table 73209629 "Management Fee Calc. Header"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209576; "Report Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209577; "Owner ID"; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = "Owner Profile"."Owner ID";

            trigger OnValidate()
            begin
                CalcFields("Owner Name");
            end;
        }
        field(73209578; "Owner Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Owner Profile"."Full Name" where("Owner ID" = field("Owner ID")));
        }
        field(73209579; "Property"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209580; "Financial Year"; Integer)
        {
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                YearRec: Record Integer;
                integerList: Page "Integer List";
                CurrYear: Integer;
            begin
                CurrYear := Date2DMY(Today(), 3);

                YearRec.SetRange(Number, CurrYear - 5, CurrYear + 5);

                integerList.Caption := 'Select Financial Year';
                integerList.LookupMode(true);
                integerList.SetTableView(YearRec);
                if integerList.RunModal() = Action::LookupOK then begin
                    integerList.SetSelectionFilter(YearRec);
                    if YearRec.FindFirst() then
                        Rec."Financial Year" := YearRec.Number;
                    Rec."Period From" := 0D;
                    Rec."Period To" := 0D;
                end;
            end;
        }
        field(73209581; "Period From"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                StartDate: Date;
                EndDate: Date;
            begin

                StartDate := DMY2Date(1, 1, Rec."Financial Year");
                EndDate := DMY2Date(31, 12, Rec."Financial Year");

                if (Rec."Period From" < StartDate) or (Rec."Period From" > EndDate) then
                    Error(
                      'Period From must be within Financial Year %1 (01/01/%1 - 31/12/%1).',
                      Rec."Financial Year");
            end;
        }
        field(73209582; "Period To"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                StartDate: Date;
                EndDate: Date;
            begin
                StartDate := DMY2Date(1, 1, Rec."Financial Year");
                EndDate := DMY2Date(31, 12, Rec."Financial Year");

                if (Rec."Period To" < StartDate) or (Rec."Period To" > EndDate) then
                    Error(
                      'Period To must be within Financial Year %1 (01/01/%1 - 31/12/%1).',
                      Rec."Financial Year");

                if Rec."Period To" < Rec."Period From" then
                    Error('Period To cannot be earlier than Period From.');
            end;
        }
        field(73209583; "All Owners"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Rec."All Owners" = true then begin

                    Rec."Owner ID" := 0;
                    Rec."Owner Name" := '';
                end;
            end;
        }
        field(73209584; "All Properties"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Rec."All Properties" = true then
                    Rec.Property := '';
            end;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    var
        managementFeeCalcLine: Record "Management Fee Calc. Line";
        baseAmountHeader: Record "Base Amount Data Header";
        baseAmountData: Record "Base Amount Data";
        baseAmountDataUnitWise: Record "Base Amount Data Unit Wise";
    begin
        managementFeeCalcLine.SetRange("Header No.", Rec."Entry No.");
        if managementFeeCalcLine.FindSet() then begin
            repeat
                baseAmountHeader.SetRange("Header No.", managementFeeCalcLine."Header No.");
                baseAmountHeader.SetRange("Line No.", managementFeeCalcLine."Entry No.");
                if baseAmountHeader.FindSet() then begin
                    repeat
                        baseAmountData.SetRange("Header No.", baseAmountHeader."Header No.");
                        baseAmountData.SetRange("Line No.", baseAmountHeader."Line No.");
                        if baseAmountData.FindSet() then
                            baseAmountData.DeleteAll();
                        baseAmountDataUnitWise.SetRange("Header No.", baseAmountHeader."Header No.");
                        baseAmountDataUnitWise.SetRange("Line No.", baseAmountHeader."Line No.");
                        if baseAmountDataUnitWise.FindSet() then
                            baseAmountDataUnitWise.DeleteAll();
                    until baseAmountHeader.Next() = 0;
                    baseAmountHeader.DeleteAll();
                end;
            until managementFeeCalcLine.Next() = 0;
            managementFeeCalcLine.DeleteAll();
        end;
    end;
}
