table 73209634 "BLRMergedUnits"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLRMerged Unit ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Merged Unit ID';
            AutoIncrement = true;
        }
        field(73209576; "BLRProperty ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Property ID';
            TableRelation = "BLRPropertyRegistration"."BLRProperty ID";
            trigger OnValidate()
            var
                PropertyRec: Record "BLRPropertyRegistration";
            begin
                PropertyRec.SetRange("BLRProperty ID", Rec."BLRProperty ID");
                if PropertyRec.FindFirst() then begin
                    "BLRProperty Name" := PropertyRec."BLRProperty Name";
                    "BLRProperty Type" := Format(PropertyRec."BLRProperty Classification");
                    "BLRBase Unit of Measure" := PropertyRec."BLRBase Unit of Measure";
                end else begin
                    "BLRProperty Name" := '';
                    "BLRProperty Type" := '';
                    "BLRBase Unit of Measure" := '';
                end;
            end;
        }
        field(73209577; "BLRProperty Name"; Text[100])
        {
            Caption = 'Property Name';
            DataClassification = CustomerContent;
        }
        field(73209578; "BLRUnit ID"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit ID';
            TableRelation = "Item"."No."
        where("BLRProperty ID" = field("BLRProperty ID"));
        }
        field(73209579; "BLRUnit Name"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Name';
        }
        field(73209580; "BLRMerged Unit Name"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Merged Unit Name';
        }
        field(73209581; "BLRUnit Size"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Unit Size';
        }
        field(73209582; "BLRMarket Rate per Square"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Market Rate per Square';
        }
        field(73209583; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Amount';
        }
        field(73209584; "BLRProperty Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Type';
        }
        field(73209585; "BLRStatus"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Merge Unit Status';
            OptionMembers = "Free","Occupied","Selected","N/A";

            trigger OnValidate()
            begin
                UpdateSingleUnitStatus();
            end;

        }
        field(73209586; "BLRFixedNumber"; Code[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209587; "BLRSpliting Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Splitting  Status';
            OptionMembers = " ","Merge","Unmerge";
        }
        field(73209588; "BLRBase Unit of Measure"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Base Unit of Measure';
        }
        field(73209589; "BLRSingle Unit Name"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Single Unit Names';
        }
        field(73209590; "BLRUnit Number"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Number';
        }
        field(73209591; "BLRMakani Number"; Text[100])
        {
            Caption = 'Makani Number';
            DataClassification = CustomerContent;

        }
        field(73209592; "BLRMunicipality Number"; Text[100])
        {
            Caption = 'Municipality Number';
            DataClassification = CustomerContent;

        }
        field(73209593; "BLRDEWA Number"; Text[100])
        {
            Caption = 'DEWA Number';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "BLRMerged Unit ID")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "BLRMerged Unit ID", "BLRUnit ID", "BLRUnit Name", "BLRProperty Name")
        {
        }
    }
    procedure AutoGenerateUnitName()
    var
        PropertyCode: Text;
    begin
        PropertyCode := FormatName(Rec."BLRProperty Name");
        Rec."BLRMerged Unit Name" := PropertyCode + '-MU-' + Format(Rec."BLRFixedNumber");
    end;

    procedure FormatName(Name: Text): Text
    var
        Words: List of [Text];
        Word: Text;
        Code: Text;
        i: Integer;
    begin
        Words := Name.Split(' ');
        if Words.Count() = 1 then
            Code := CopyStr(Words.Get(1), 1, 3)
        else
            Code := '';
        for i := 1 to Words.Count() do begin
            Word := Words.Get(i);
            Code += CopyStr(Word, 1, 1);
        end;
        exit(Code);
    end;

    trigger OnInsert()
    var
        NoSeriesManagement: Codeunit "No. Series";
        NewUnitNo: Code[20];
    begin
        if ("BLRFixedNumber" = '') then begin
            NewUnitNo := NoSeriesManagement.GetNextNo('MGUNITNO', 0D, true);
            "BLRFixedNumber" := NewUnitNo;
        end;
        AutoGenerateUnitName();
    end;

    procedure UpdateSingleUnitStatus()
    var
        UnitRec: Record Item;
        UnitList: List of [Text];
        UnitIdTxt: Text;
        CleanText: Text;
        UnitId: Text;
    begin
        UnitIdTxt := Rec."BLRUnit ID";

        if UnitIdTxt = '' then
            exit;

        // Replace '.' Ã¢â€ â€™ '|'
        CleanText := ConvertStr(UnitIdTxt, '.', '|');

        UnitList := CleanText.Split('|');

        foreach UnitId in UnitList do begin
            UnitId := DelChr(UnitId, '=', ' ');

            if UnitId = '' then
                continue;

            UnitRec.Reset();
            UnitRec.SetRange("No.", UnitId);

            if UnitRec.FindFirst() then begin

                // Ã¢Å“â€¦ SAFE mapping
                case Rec."BLRStatus" of
                    Rec."BLRStatus"::Free:
                        UnitRec."BLRUnit Status" := UnitRec."BLRUnit Status"::Free;

                    Rec."BLRStatus"::Selected:
                        UnitRec."BLRUnit Status" := UnitRec."BLRUnit Status"::Selected;

                    Rec."BLRStatus"::Occupied:
                        UnitRec."BLRUnit Status" := UnitRec."BLRUnit Status"::Occupied;

                    Rec."BLRStatus"::"N/A":
                        UnitRec."BLRUnit Status" := UnitRec."BLRUnit Status"::" ";
                end;

                UnitRec.Modify();
            end;
        end;
    end;
}
