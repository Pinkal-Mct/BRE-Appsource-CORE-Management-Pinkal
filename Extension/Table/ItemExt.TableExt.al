tableextension 73209581 "Item Ext" extends Item
{
    Caption = 'Unit';
    DataCaptionFields = "No.";

    fields
    {
        field(73209575; "UnitID"; code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'UnitID';
        }
        field(73209576; "Property ID"; Code[20])
        {
            Caption = 'Property ID';
            DataClassification = ToBeClassified;
            TableRelation = "Property Registration"."Property ID";
            trigger OnValidate()
            var
                PropertyRec: Record "Property Registration";
            begin
                PropertyRec.SetRange("Property ID", Rec."Property ID");
                if PropertyRec.FindFirst() then begin
                    "Property Name" := PropertyRec."Property Name";
                    "Usage Type" := PropertyRec."Property Classification";
                    Country := PropertyRec.Country;
                    "Emirate Name" := PropertyRec."Emirate Name";
                    Community := PropertyRec.Community;
                end else begin
                    "Property Name" := '';
                    "Usage Type" := '';
                    Country := '';
                    "Emirate Name" := '';
                    Community := '';
                end;
            end;
        }
        field(73209577; "Property Name"; Text[100])
        {
            Caption = 'Property Name';
            DataClassification = ToBeClassified;
            ValidateTableRelation = false;
            TableRelation = "Property Registration"."Property Name";
        }
        field(73209578; "Unit Number"; Text[50])
        {
            Caption = 'Actual Unit Number';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                UnitRec: Record Item;
            begin
                // Check duplicate Unit Number for same Property
                UnitRec.Reset();
                UnitRec.SetRange("Property ID", Rec."Property ID");
                UnitRec.SetRange("Unit Number", Rec."Unit Number");

                // Exclude current record (important for Modify case)
                if not UnitRec.IsEmpty() then
                    Error('Unit Number %1 already exists for Property %2.', "Unit Number", "Property ID");
            end;
        }
        field(73209579; "Floor Number"; Integer)
        {
            Caption = 'Floor Number';
            DataClassification = ToBeClassified;
        }
        field(73209580; "Usage Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Usage Type';
            TableRelation = "Primary Classification"."Classification Name";
            NotBlank = true;
        }
        field(73209581; "Unit Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Type';
            TableRelation = "Secondary Classification" where("Classification Name" = field("Usage Type"));
            trigger OnValidate()
            var
                secondaryClassification: Record "Secondary Classification";
                id: Integer;
            begin
                Evaluate(id, Rec."Unit Type");
                secondaryClassification.SetRange(ID, id);
                if secondaryClassification.FindFirst() then
                    Rec."Unit Type" := secondaryClassification."Property Type";
            end;
        }
        field(73209582; "Unit Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Status';
            OptionMembers = " ",Free,Selected,Occupied;
            OptionCaption = ' ,Free,Selected,Occupied';
            Editable = true;
        }
        field(73209583; "Selected"; Boolean)
        {
            Caption = 'Selected';
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(73209584; "MergeSplitOption"; Option)
        {
            Caption = 'Unit Classification';
            OptionMembers = "Single","Merge";
            DataClassification = ToBeClassified;
        }
        field(73209585; "Unit Name"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Name';
        }
        field(73209586; "Floor plans"; Text[250])
        {
            Caption = 'Floor plans';
            DataClassification = ToBeClassified;
        }
        field(73209587; "Inspection certificates"; Text[250])
        {
            Caption = 'Inspection certificates';
            DataClassification = ToBeClassified;
        }
        field(73209588; "Other Documents"; Text[250])
        {
            Caption = 'Other Documents';
            DataClassification = ToBeClassified;
        }
        field(73209589; "GTIN_"; Code[100])
        {
            Caption = 'GTIN';
            DataClassification = ToBeClassified;
        }
        field(73209590; "Country"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Country';
        }
        field(73209591; "Emirate Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Emirate';
        }
        field(73209592; "Community"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Community';
        }
        field(73209593; "Unit Address"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Address';
        }
        field(73209594; "Market Rate per Sq. Ft."; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Market Rate per Sq. Ft.';
            trigger OnValidate()
            begin
                CalculateAmount();
            end;
        }
        field(73209595; "Unit Size"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Size (sq. ft./meters)';
            trigger OnValidate()
            begin
                CalculateAmount();
            end;
        }
        field(73209596; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
            Editable = false;
        }
        field(73209597; "FixedNumber"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(73209598; "Merged Unit ID"; Integer)
        {
            Caption = 'Merged Unit ID';
            DataClassification = ToBeClassified;
        }
        field(73209599; "Primary Classification Type"; Text[100])
        {
            Caption = 'Primary Classification Type';
            DataClassification = ToBeClassified;
            TableRelation = "Primary Classification"."Classification Name";
        }
        field(73209600; "Item Type"; Enum "Module Enum")
        {
            Caption = 'Item Type';
            DataClassification = ToBeClassified;
        }
        field(73209601; "Item Template"; Enum "Item Template Enum")
        {
            Caption = 'Item Template';
            DataClassification = ToBeClassified;
        }
        field(73209602; "Item type template"; Enum "Item Type Template Enum")
        {
            Caption = 'Item type template';
            DataClassification = ToBeClassified;
        }
        field(73209603; "Primary Item Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary Item';
            TableRelation = "Primary Item"."Primary Item Type";
            Editable = false;
        }
        field(73209604; "Category Types"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Category';
            TableRelation = "Category Type";
            trigger OnValidate()
            var
                CategoryType: Record "Category type";
            begin
                if CategoryType.Get("Category Types") then begin
                    "Category Types" := CategoryType."Category Types";
                    "Primary Item Type" := CategoryType."Primary Item Type";
                end;
            end;
        }
        field(73209605; "VAT Type"; Option)
        {
            Caption = 'VAT Type';
            OptionMembers = "Zero-0%","Standard-5%";
            trigger OnValidate()
            begin
                case "VAT Type" of
                    0:
                        "VAT %" := 0;
                    1:
                        "VAT %" := 1;
                    else
                        "VAT %" := 0;
                end;
            end;
        }
        field(73209606; "VAT %"; Option)
        {
            OptionMembers = "0","5";
            Caption = 'VAT %';
            Editable = false;
        }
        field(73209607; "Charges Status"; Option)
        {
            OptionMembers = " ","Regular Charges","Additional Charges";
            Caption = 'Charges Status';
        }
        field(73209608; "Inventory Unit Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Status';
            OptionMembers = " ",Free,Reserved,Sold;
            OptionCaption = ' ,Free,Reserved,Sold';
            Editable = true;
        }
    }
    procedure CalculateAmount()
    var
        MarketRate: Decimal;
        UnitSize: Decimal;
    begin
        MarketRate := "Market Rate per Sq. Ft.";
        UnitSize := "Unit Size";
        if (MarketRate <> 0) and (UnitSize <> 0) then
            "Amount" := MarketRate * UnitSize
        else
            "Amount" := 0;
    end;

    trigger OnInsert()
    var
        NoSeriesManagement: Codeunit "No. Series";
        NewNo: Code[20];
        NewUnitNo: Code[20];
    begin
        if ("No." = '') then begin
            NewNo := NoSeriesManagement.GetNextNo('UNITID', 0D, true);
            "No." := NewNo;
        end;
        if ("FixedNumber" = '') then begin
            NewUnitNo := NoSeriesManagement.GetNextNo('UNITNO', 0D, true);
            FixedNumber := NewUnitNo;
        end;
    end;
}