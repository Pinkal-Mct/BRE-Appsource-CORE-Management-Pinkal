tableextension 73209581 "BLRItem Ext" extends Item
{
    Caption = 'Unit';
    DataCaptionFields = "No.";

    fields
    {
        field(73209575; "BLRUnitID"; code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'UnitID';
        }
        field(73209576; "BLRProperty ID"; Code[20])
        {
            Caption = 'Property ID';
            DataClassification = CustomerContent;
            TableRelation = "BLRPropertyRegistration"."BLRProperty ID";
            trigger OnValidate()
            var
                PropertyRec: Record "BLRPropertyRegistration";
            begin
                PropertyRec.SetRange("BLRProperty ID", Rec."BLRProperty ID");
                if PropertyRec.FindFirst() then begin
                    "BLRProperty Name" := PropertyRec."BLRProperty Name";
                    "BLRUsage Type" := PropertyRec."BLRProperty Classification";
                    "BLRCountry" := PropertyRec."BLRCountry";
                    "BLREmirate Name" := PropertyRec."BLREmirate Name";
                    "BLRCommunity" := PropertyRec."BLRCommunity";
                end else begin
                    "BLRProperty Name" := '';
                    "BLRUsage Type" := '';
                    "BLRCountry" := '';
                    "BLREmirate Name" := '';
                    "BLRCommunity" := '';
                end;
            end;
        }
        field(73209577; "BLRProperty Name"; Text[100])
        {
            Caption = 'Property Name';
            DataClassification = CustomerContent;
            ValidateTableRelation = false;
            TableRelation = "BLRPropertyRegistration"."BLRProperty Name";
        }
        field(73209578; "BLRUnit Number"; Text[50])
        {
            Caption = 'Actual Unit Number';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                UnitRec: Record Item;
            begin
                // Check duplicate Unit Number for same Property
                UnitRec.Reset();
                UnitRec.SetRange("BLRProperty ID", Rec."BLRProperty ID");
                UnitRec.SetRange("BLRUnit Number", Rec."BLRUnit Number");

                // Exclude current record (important for Modify case)
                if not UnitRec.IsEmpty() then
                    Error('Unit Number %1 already exists for Property %2.', "BLRUnit Number", "BLRProperty ID");
            end;
        }
        field(73209579; "BLRFloor Number"; Integer)
        {
            Caption = 'Floor Number';
            DataClassification = CustomerContent;
        }
        field(73209580; "BLRUsage Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Usage Type';
            TableRelation = "BLRPrimaryClassification"."BLRClassification Name";
            NotBlank = true;
        }
        field(73209581; "BLRUnit Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Type';
            TableRelation = "BLRSecondaryClassification" where("BLRClassification Name" = field("BLRUsage Type"));
            trigger OnValidate()
            var
                secondaryClassification: Record "BLRSecondaryClassification";
                id: Integer;
            begin
                Evaluate(id, Rec."BLRUnit Type");
                secondaryClassification.SetRange("BLRID", id);
                if secondaryClassification.FindFirst() then
                    Rec."BLRUnit Type" := secondaryClassification."BLRProperty Type";
            end;
        }
        field(73209582; "BLRUnit Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Status';
            OptionMembers = " ",Free,Selected,Occupied;
            OptionCaption = ' ,Free,Selected,Occupied';
            Editable = true;
        }
        field(73209583; "BLRSelected"; Boolean)
        {
            Caption = 'Selected';
            DataClassification = CustomerContent;
            Editable = true;
        }
        field(73209584; "BLRMergeSplitOption"; Option)
        {
            Caption = 'Unit Classification';
            OptionMembers = "Single","Merge";
            DataClassification = CustomerContent;
        }
        field(73209585; "BLRUnit Name"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Name';
        }
        field(73209586; "BLRFloor plans"; Text[250])
        {
            Caption = 'Floor plans';
            DataClassification = CustomerContent;
        }
        field(73209587; "BLRInspection certificates"; Text[250])
        {
            Caption = 'Inspection certificates';
            DataClassification = CustomerContent;
        }
        field(73209588; "BLROther Documents"; Text[250])
        {
            Caption = 'Other Documents';
            DataClassification = CustomerContent;
        }
        field(73209589; "BLRGTIN_"; Code[100])
        {
            Caption = 'GTIN';
            DataClassification = CustomerContent;
        }
        field(73209590; "BLRCountry"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Country';
        }
        field(73209591; "BLREmirate Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Emirate';
        }
        field(73209592; "BLRCommunity"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Community';
        }
        field(73209593; "BLRUnit Address"; Text[250])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Unit Address';
        }
        field(73209594; "BLRMarket Rate per Sq. Ft."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Market Rate per Sq. Ft.';
            trigger OnValidate()
            begin
                CalculateAmount();
            end;
        }
        field(73209595; "BLRUnit Size"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Size (sq. ft./meters)';
            trigger OnValidate()
            begin
                CalculateAmount();
            end;
        }
        field(73209596; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
            Editable = false;
        }
        field(73209597; "BLRFixedNumber"; Code[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209598; "BLRMerged Unit ID"; Integer)
        {
            Caption = 'Merged Unit ID';
            DataClassification = CustomerContent;
        }
        field(73209599; "BLRPrimary Classification Type"; Text[100])
        {
            Caption = 'Primary Classification Type';
            DataClassification = CustomerContent;
            TableRelation = "BLRPrimaryClassification"."BLRClassification Name";
        }
        field(73209600; "BLRItem Type"; Enum "BLRModule Enum")
        {
            Caption = 'Item Type';
            DataClassification = CustomerContent;
        }
        field(73209601; "BLRItem Template"; Enum "BLRItem Template Enum")
        {
            Caption = 'Item Template';
            DataClassification = CustomerContent;
        }
        field(73209602; "BLRItem type template"; Enum "BLRItem Type Template Enum")
        {
            Caption = 'Item type template';
            DataClassification = CustomerContent;
        }
        field(73209603; "BLRPrimary Item Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Primary Item';
            TableRelation = "BLRPrimaryItem"."BLRPrimary Item Type";
            Editable = false;
        }
        field(73209604; "BLRCategory Types"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Category';
            TableRelation = "BLRCategoryType";
            trigger OnValidate()
            var
                CategoryType: Record "BLRCategoryType";
            begin
                if CategoryType.Get("BLRCategory Types") then begin
                    "BLRCategory Types" := CategoryType."BLRCategory Types";
                    "BLRPrimary Item Type" := CategoryType."BLRPrimary Item Type";
                end;
            end;
        }
        field(73209605; "BLRVAT Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Type';
            OptionMembers = "Zero-0%","Standard-5%";
            trigger OnValidate()
            begin
                case "BLRVAT Type" of
                    0:
                        "BLRVAT %" := 0;
                    1:
                        "BLRVAT %" := 1;
                    else
                        "BLRVAT %" := 0;
                end;
            end;
        }
        field(73209606; "BLRVAT %"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "0","5";
            Caption = 'VAT %';
            Editable = false;
        }
        field(73209607; "BLRCharges Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Regular Charges","Additional Charges";
            Caption = 'Charges Status';
        }
        field(73209608; "BLRInventory Unit Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Status';
            OptionMembers = " ",Free,Reserved,Sold;
            OptionCaption = ' ,Free,Reserved,Sold';
            Editable = true;
        }
        field(73209609; "BLRMakani Number"; Text[100])
        {
            Caption = 'Makani Number';
            DataClassification = ToBeClassified;

        }
        field(73209610; "BLRMunicipality Number"; Text[100])
        {
            Caption = 'Municipality Number';
            DataClassification = ToBeClassified;

        }
        field(73209611; "BLRDEWA Number"; Text[100])
        {
            Caption = 'DEWA Number';
            DataClassification = ToBeClassified;
        }
    }
    procedure CalculateAmount()
    var
        MarketRate: Decimal;
        UnitSize: Decimal;
    begin
        MarketRate := "BLRMarket Rate per Sq. Ft.";
        UnitSize := "BLRUnit Size";
        if (MarketRate <> 0) and (UnitSize <> 0) then
            "BLRAmount" := MarketRate * UnitSize
        else
            "BLRAmount" := 0;
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
        if ("BLRFixedNumber" = '') then begin
            NewUnitNo := NoSeriesManagement.GetNextNo('UNITNO', 0D, true);
            "BLRFixedNumber" := NewUnitNo;
        end;
    end;
}
