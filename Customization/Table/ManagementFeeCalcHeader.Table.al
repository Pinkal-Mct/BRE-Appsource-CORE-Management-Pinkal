table 73209629 "BLRManagementFeeCalcHeader"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209576; "BLRReport Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209577; "BLROwner ID"; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = "BLROwnerProfile"."BLROwner ID";

            trigger OnValidate()
            begin
                CalcFields("BLROwner Name");
            end;
        }
        field(73209578; "BLROwner Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("BLROwnerProfile"."BLRFull Name" where("BLROwner ID" = field("BLROwner ID")));
        }
        field(73209579; "BLRProperty"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209580; "BLRFinancial Year"; Integer)
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
                        Rec."BLRFinancial Year" := YearRec.Number;
                    Rec."BLRPeriod From" := 0D;
                    Rec."BLRPeriod To" := 0D;
                end;
            end;
        }
        field(73209581; "BLRPeriod From"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                StartDate: Date;
                EndDate: Date;
            begin

                StartDate := DMY2Date(1, 1, Rec."BLRFinancial Year");
                EndDate := DMY2Date(31, 12, Rec."BLRFinancial Year");

                if (Rec."BLRPeriod From" < StartDate) or (Rec."BLRPeriod From" > EndDate) then
                    Error(
                      'Period From must be within "BLRFinancial Year" %1 (01/01/%1 - 31/12/%1).',
                      Rec."BLRFinancial Year");
            end;
        }
        field(73209582; "BLRPeriod To"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                StartDate: Date;
                EndDate: Date;
            begin
                StartDate := DMY2Date(1, 1, Rec."BLRFinancial Year");
                EndDate := DMY2Date(31, 12, Rec."BLRFinancial Year");

                if (Rec."BLRPeriod To" < StartDate) or (Rec."BLRPeriod To" > EndDate) then
                    Error(
                      'Period To must be within "BLRFinancial Year" %1 (01/01/%1 - 31/12/%1).',
                      Rec."BLRFinancial Year");

                if Rec."BLRPeriod To" < Rec."BLRPeriod From" then
                    Error('Period To cannot be earlier than "BLRPeriod From".');
            end;
        }
        field(73209583; "BLRAll Owners"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Rec."BLRAll Owners" = true then begin

                    Rec."BLROwner ID" := 0;
                    Rec."BLROwner Name" := '';
                end;
            end;
        }
        field(73209584; "BLRAll Properties"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Rec."BLRAll Properties" = true then
                    Rec."BLRProperty" := '';
            end;
        }
    }

    keys
    {
        key(PK;"BLREntry No.")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    var
        managementFeeCalcLine: Record "BLRManagementFeeCalcLine";
        baseAmountHeader: Record "BLRBaseAmountDataHeader";
        baseAmountData: Record "BLRBaseAmountData";
        baseAmountDataUnitWise: Record "BLRBaseAmountDataUnitWise";
    begin
        managementFeeCalcLine.SetRange("BLRHeader No.", Rec."BLREntry No.");
        if managementFeeCalcLine.FindSet() then begin
            repeat
                baseAmountHeader.SetRange("BLRHeader No.", managementFeeCalcLine."BLRHeader No.");
                baseAmountHeader.SetRange("BLRLine No.", managementFeeCalcLine."BLREntry No.");
                if baseAmountHeader.FindSet() then begin
                    repeat
                        baseAmountData.SetRange("BLRHeader No.", baseAmountHeader."BLRHeader No.");
                        baseAmountData.SetRange("BLRLine No.", baseAmountHeader."BLRLine No.");
                        if baseAmountData.FindSet() then
                            baseAmountData.DeleteAll();
                        baseAmountDataUnitWise.SetRange("BLRHeader No.", baseAmountHeader."BLRHeader No.");
                        baseAmountDataUnitWise.SetRange("BLRLine No.", baseAmountHeader."BLRLine No.");
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
