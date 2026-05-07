table 73209634 "Merged Units"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "Merged Unit ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Merged Unit ID';
            AutoIncrement = true;
        }
        field(73209576; "Property ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Property ID';
            TableRelation = "Property Registration"."Property ID";
            trigger OnValidate()
            var
                PropertyRec: Record "Property Registration";
            begin
                PropertyRec.SetRange("Property ID", Rec."Property ID");
                if PropertyRec.FindFirst() then begin
                    "Property Name" := PropertyRec."Property Name";
                    "Property Type" := Format(PropertyRec."Property Classification");
                    "Base Unit of Measure" := PropertyRec."Base Unit of Measure";
                end else begin
                    "Property Name" := '';
                    "Property Type" := '';
                    "Base Unit of Measure" := '';
                end;
            end;
        }
        field(73209577; "Property Name"; Text[100])
        {
            Caption = 'Property Name';
            DataClassification = CustomerContent;
        }
        field(73209578; "Unit ID"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit ID';
            TableRelation = "Item"."No."
        where("Property ID" = field("Property ID"));
        }
        field(73209579; "Unit Name"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Name';
        }
        field(73209580; "Merged Unit Name"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Merged Unit Name';
        }
        field(73209581; "Unit Size"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Unit Size';
        }
        field(73209582; "Market Rate per Square"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Market Rate per Square';
        }
        field(73209583; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Amount';
        }
        field(73209584; "Property Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Type';
        }
        field(73209585; "Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Merge Unit Status';
            OptionMembers = "Free","Occupied","Selected","N/A";

            trigger OnValidate()
            begin
                UpdateSingleUnitStatus();
            end;

        }
        field(73209586; "FixedNumber"; Code[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209587; "Spliting Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Splitting  Status';
            OptionMembers = " ","Merge","Unmerge";
        }
        field(73209588; "Base Unit of Measure"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Base Unit of Measure';
        }
        field(73209589; "Single Unit Name"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Single Unit Names';
        }
        field(73209590; "Unit Number"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Number';
        }
    }
    keys
    {
        key(PK; "Merged Unit ID")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Merged Unit ID", "Unit ID", "Unit Name", "Property Name")
        {
        }
    }
    procedure AutoGenerateUnitName()
    var
        PropertyCode: Text;
    begin
        PropertyCode := FormatName(Rec."Property Name");
        Rec."Merged Unit Name" := PropertyCode + '-MU-' + Format(Rec.FixedNumber);
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
        if ("FixedNumber" = '') then begin
            NewUnitNo := NoSeriesManagement.GetNextNo('MGUNITNO', 0D, true);
            FixedNumber := NewUnitNo;
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
        UnitIdTxt := Rec."Unit ID";

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
                case Rec.Status of
                    Rec.Status::Free:
                        UnitRec."Unit Status" := UnitRec."Unit Status"::Free;

                    Rec.Status::Selected:
                        UnitRec."Unit Status" := UnitRec."Unit Status"::Selected;

                    Rec.Status::Occupied:
                        UnitRec."Unit Status" := UnitRec."Unit Status"::Occupied;

                    Rec.Status::"N/A":
                        UnitRec."Unit Status" := UnitRec."Unit Status"::" ";
                end;

                UnitRec.Modify();
            end;
        end;
    end;
}
