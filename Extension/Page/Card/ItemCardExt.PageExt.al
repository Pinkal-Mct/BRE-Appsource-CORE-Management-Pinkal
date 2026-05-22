pageextension 73209575 "Item Card Ext" extends "Item Card"
{
    Caption = 'Unit Card';

    layout
    {
        modify("No.")
        {
            Editable = false;
        }
        modify("Item Category Code")
        {
            Visible = isVenderService;
        }
        modify("Automatic Ext. Texts")
        {
            Visible = false;
        }
        modify("Common Item No.")
        {
            Visible = false;
        }
        modify("Purchasing Code")
        {
            Visible = false;
        }
        modify("VariantMandatoryDefaultNo")
        {
            Visible = false;
        }
        modify(Blocked)
        {
            Visible = false;
        }
        modify("Last Date Modified")
        {
            Visible = false;
        }
        modify(InventoryGrp)
        {
            Visible = isVenderService;
        }
        modify("Costs & Posting")
        {
            Visible = isVenderService;
        }
        modify("Prices & Sales")
        {
            Visible = isVenderService;
        }
        modify(Replenishment)
        {
            Visible = isVenderService;
        }
        modify(Planning)
        {
            Visible = isVenderService;
        }
        modify(ItemTracking)
        {
            Visible = isVenderService;
        }
        modify(Warehouse)
        {
            Visible = isVenderService;
        }
        modify(GTIN)
        {
            Visible = false;
        }
        addafter(Description)
        {
            group("Posting setup")
            {
                ShowCaption = false;
                Visible = hideshowfields and isVenderService or Unitcharges;
            }
        }
        movefirst("Posting setup"; "Gen. Prod. Posting Group", "VAT Prod. Posting Group")
        modify("Service Item Group")
        {
            Editable = editablefalsefieldNonInventoryType;
            Visible = false;
        }
        modify(Item)
        {
            caption = 'Unit';
        }
        addafter("No.")
        {
            group(DescriptionGrp)
            {
                ShowCaption = false;
                Visible = isVenderService or Unitcharges or isUnitService or isUnitInventory;
            }
        }
        movefirst(DescriptionGrp; Description)
        addafter(Type)
        {
            group("Unit Charges Description")
            {
                ShowCaption = false;
                Visible = Unitcharges or isVenderService;

                field("Primary Item Type"; Rec."BLRPrimary Item Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Primary Item Type';
                }
                field("Category Types"; Rec."BLRCategory Types")
                {
                    ApplicationArea = All;
                    ToolTip = 'Category Types';
                }
                field("VAT Type"; Rec."BLRVAT Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'VAT Type';
                }
                field("VAT %"; Rec."BLRVAT %")
                {
                    ApplicationArea = All;
                    ToolTip = 'VAT Percentage';
                }
                field("Charges Status"; Rec."BLRCharges Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Charges Status';
                }
            }
        }
        addafter("Base Unit of Measure")
        {
            group("BaseUnitofMeasure")
            {
                ShowCaption = false;
                Visible = isUnitService or isUnitInventory;
                field("Market Rate per Sq. Ft."; rec."BLRMarket Rate per Sq. Ft.")
                {
                    ApplicationArea = All;
                    Editable = editablefalsefieldNonInventoryType;
                    ToolTip = 'Market Rate per Square Foot';
                }
            }
        }
        addafter("Market Rate per Sq. Ft.")
        {
            group("MarketRateperSq.Ft.")
            {
                ShowCaption = false;
                Visible = isUnitService or isUnitInventory;
                field("Unit Size"; rec."BLRUnit Size")
                {
                    ApplicationArea = All;
                    Caption = 'Unit Size';
                    ToolTip = 'Size of the Unit in Square Feet';
                    Editable = editablefalsefieldNonInventoryType;
                }
            }

        }
        addafter("Unit Size")
        {
            group("UnitSize")
            {
                ShowCaption = false;
                Visible = isUnitService or isUnitInventory;
                field("Amount"; rec."BLRAmount")
                {
                    ApplicationArea = All;
                    Caption = 'Amount';
                    ToolTip = 'Calculated Amount based on Market Rate and Unit Size';
                    Editable = false;
                }
            }
        }
        addafter("Gen. Prod. Posting Group")
        {
            group("Gen.Prod.PostingGroup")
            {
                ShowCaption = false;
                Visible = isUnitService or isUnitInventory;
                field("Primary Classification Type"; Rec."BLRPrimary Classification Type")
                {
                    ApplicationArea = All;
                    Caption = 'Primary Classification Type';
                    Editable = ISPrimaryType;
                    ToolTip = 'Primary Classification Type for the Unit';
                }
            }
        }
        addafter(Item)
        {
            group(UnitManagement)
            {
                Visible = isUnitService or isUnitInventory;
                Caption = 'Unit Management';

                field(FixedNumber; Rec."BLRFixedNumber")
                {
                    ApplicationArea = All;
                    Caption = 'FixedNumber';
                    ToolTip = 'Fixed Number for the Unit';
                    Editable = false;
                    Visible = false;
                }
                field("Property ID"; Rec."BLRProperty ID")
                {
                    ApplicationArea = All;
                    Caption = 'Property ID';
                    ToolTip = 'Select the associated Property ID.';
                    Editable = editablefalsefieldNonInventoryType;
                    trigger OnValidate()
                    begin
                        AutoGenerateUnitName(Rec);
                    end;
                }

                field("Property Name"; Rec."BLRProperty Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Select the associated Property Name.';
                    Caption = 'Property Name';
                    Editable = false;
                }
                field("Country"; Rec."BLRCountry")
                {
                    ApplicationArea = All;
                    Caption = 'Country';
                    ToolTip = 'Country where the Unit is located';
                    Lookup = true;
                    Editable = false;
                    trigger OnValidate()
                    begin
                        AutoGenerateUnitName(Rec);
                    end;

                }
                field("Emirate"; Rec."BLREmirate Name")
                {
                    ApplicationArea = All;
                    Caption = 'Emirate';
                    ToolTip = 'Emirate where the Unit is located';
                    Lookup = true;
                    Editable = false;
                    trigger OnValidate()
                    begin
                        AutoGenerateUnitName(Rec);
                    end;
                }
                field("Community"; Rec."BLRCommunity")
                {
                    ApplicationArea = All;
                    Caption = 'Community';
                    ToolTip = 'Community where the Unit is located';
                    Lookup = true;
                    Editable = false;
                    trigger OnValidate()
                    begin
                        AutoGenerateUnitName(Rec);
                    end;
                }
                field("Makani Number"; Rec."BLRMakani Number")
                {
                    ApplicationArea = All;
                    Caption = 'Makani Number';
                    ToolTip = 'Makani Number of the Unit';
                }
                field("Municipality Number"; Rec."BLRMunicipality Number")
                {
                    ApplicationArea = All;
                    Caption = 'Municipality Number';
                    ToolTip = 'Municipality Number of the Unit';
                }
                field("DEWA Number"; Rec."BLRDEWA Number")
                {
                    ApplicationArea = All;
                    Caption = 'DEWA Number';
                    ToolTip = 'DEWA Number of the Unit';
                }
                field("Floor Number"; Rec."BLRFloor Number")
                {
                    ApplicationArea = All;
                    Caption = 'Floor Number';
                    ToolTip = 'Floor Number of the Unit';
                    Editable = editablefalsefieldNonInventoryType;
                }
                field("Unit Number"; Rec."BLRUnit Number")
                {
                    ApplicationArea = All;
                    Caption = 'Unit Number';
                    ToolTip = 'Actual Unit Number within the Property';
                    Editable = editablefalsefieldNonInventoryType;
                    trigger OnValidate()
                    begin
                        AutoGenerateUnitName(Rec);
                    end;
                }

                field("Unit ID"; Rec.BLRUnitID)
                {
                    ApplicationArea = All;
                    Caption = 'Unit ID';
                    ToolTip = 'Unique Identifier for the Unit';
                    Editable = false;
                }
                field("Unit Name"; Rec."BLRUnit Name")
                {
                    ApplicationArea = All;
                    Caption = 'Unit Name';
                    ToolTip = 'Name of the Unit';
                    Editable = false;
                }

                field("Usage Type"; rec."BLRUsage Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Usage Type of the Unit';
                    Lookup = true;
                    Editable = false;
                }

                field("Unit Type"; rec."BLRUnit Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Type of the Unit';
                    Lookup = true;
                    Editable = editablefalsefieldNonInventoryType;
                }
                field("Unit Address"; rec."BLRUnit Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Address of the Unit';
                    Editable = editablefalsefieldNonInventoryType;
                }
                field("Merging/Splitting"; rec."BLRMergeSplitOption")
                {
                    ApplicationArea = All;
                    ToolTip = 'Option for Merging or Splitting the Unit';
                    Editable = false;
                }

                field("Unit Status"; rec."BLRUnit Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Current Status of the Unit';
                    Lookup = true;
                }
            }
            part("Document Attachments"; "Unit Document SubPage")
            {
                SubPageLink = "BLRUnitID" = FIELD("No.");
                ApplicationArea = All;
                Editable = editablefalsefieldNonInventoryType;
                Visible = ShowFinancialFields and isUnitService and isVisible;
            }
        }
    }

    actions
    {
        modify(CopyItem)
        {
            trigger OnAfterAction()
            begin
                AutoGenerateUnitName(Rec);
            end;
        }
        addafter("Item Journal")
        {
            action("Add New Line")
            {
                ApplicationArea = All;
                ToolTip = 'Add a new line to the Unit Charges';
                Visible = isService;
                trigger OnAction()
                var
                    CustomLinesPage: Record "BLRRevenueStructureSubpage";
                    CustomLinesPage2: Record "BLRRevenueStructure";
                begin
                    if CustomLinesPage.FindSet() then
                        CustomLinesPage.DeleteAll();

                    if CustomLinesPage2.FindSet() then
                        CustomLinesPage2.DeleteAll();
                end;
            }
        }
    }

    procedure AutoGenerateUnitName(var TargetItem: Record Item)
    var
        PropertyCode: Text;
        UnitID: Text;
        CountryCode: Text;
        EmiratesCode: Text;
        CommunityCode: Text;
        UnitnumberCode: Text;
        lCountry: Text;
        Emirates: Text;
        lCommunity: Text;
        Unitnumber: Text;
    begin
        PropertyCode := FormatName(TargetItem."BLRProperty Name");
        lCountry := Format(TargetItem."BLRCountry");
        Emirates := Format(TargetItem."BLREmirate Name");
        lCommunity := Format(TargetItem."BLRCommunity");
        Unitnumber := Format(TargetItem."BLRUnit Number");
        CountryCode := FormatName(lCountry);
        EmiratesCode := FormatName(Emirates);
        CommunityCode := FormatName(lCommunity);
        UnitnumberCode := Format(Unitnumber);
        TargetItem."BLRUnit Name" := PropertyCode + '-SU-' + UnitnumberCode;
        UnitID := CountryCode + '-' + EmiratesCode + '-' + CommunityCode + '-' + PropertyCode + '-' + UnitnumberCode;
        TargetItem."BLRUnitID" := CopyStr(UnitID, 1, StrLen(UnitID));
        TargetItem.Modify();
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
        else begin
            Code := '';
            for i := 1 to Words.Count() do begin
                Word := Words.Get(i);
                Code += CopyStr(Word, 1, 1);
            end;
        end;

        exit(Code);
    end;

    var
        isVisible: Boolean;
        isUnitService: Boolean;
        isVenderService: Boolean;
        isUnitInventory: Boolean;

    procedure EvaluateFastTabVisibility(): Boolean
    begin
        if Rec."BLRItem Template" = Enum::"Item Template Enum"::Service then
            if Rec."BLRItem type template" = Enum::"Item Type Template Enum"::"Unit Service" then
                exit(true)
            else
                exit(false);
    end;

    procedure EvaluateFastTabVisibilityService(): Boolean
    begin
        if Rec."BLRItem Template" = Enum::"Item Template Enum"::Service then
            if Rec."BLRItem type template" = Enum::"Item Type Template Enum"::"Vendor Service" then
                exit(true)
            else
                exit(false);
    end;

    procedure UnitChargesFieldsVisiblity(): Boolean
    begin
        if Rec."BLRItem Template" = Enum::"Item Template Enum"::Service then
            if Rec."BLRItem type template" = Enum::"Item Type Template Enum"::"Secondary Item" then
                exit(true)
            else
                exit(false);
    end;

    procedure InventoryUnitVisibility(): Boolean
    begin
        if Rec."BLRItem Template" = Enum::"Item Template Enum"::Inventory then
            if Rec."BLRItem type template" = Enum::"Item Type Template Enum"::"Unit Inventory" then
                exit(true)
            else
                exit(false);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        CurrPage."Document Attachments".Page.SetUnitId(Rec."No.");
        ISPrimaryType := SetPrimaryType();
        hideshowfields := hidefields();
        editablefalsefieldNonInventoryType := editablefalseNonInventory();
        isUnitService := EvaluateFastTabVisibility();
        isUnitInventory := InventoryUnitVisibility();
        isVenderService := EvaluateFastTabVisibilityService();
        Unitcharges := UnitChargesFieldsVisiblity();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CurrPage."Document Attachments".Page.SetUnitId(Rec."No.");
        isVisible := true;

        if Rec."BLRProperty Name" = '' then
            exit
        else
            AutoGenerateUnitName(Rec);
    end;

    trigger OnAfterGetRecord()

    begin
        CurrPage."Document Attachments".Page.SetUnitId(Rec."No.");
        if Format(Rec."No.") <> '' then
            isVisible := true
        else
            isVisible := false;

        ISPrimaryType := SetPrimaryType();
        hideshowfields := hidefields();
        editablefalsefieldNonInventoryType := editablefalseNonInventory();
        isUnitService := EvaluateFastTabVisibility();
        isUnitInventory := InventoryUnitVisibility();
        isVenderService := EvaluateFastTabVisibilityService();
        Unitcharges := UnitChargesFieldsVisiblity();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        ISPrimaryType := SetPrimaryType();
        hideshowfields := hidefields();
        editablefalsefieldNonInventoryType := editablefalseNonInventory();
        Unitcharges := UnitChargesFieldsVisiblity();
        isUnitService := EvaluateFastTabVisibility();
        isUnitInventory := InventoryUnitVisibility();
        isVenderService := EvaluateFastTabVisibilityService();
    end;

    procedure SetPrimaryType(): Boolean
    var
    begin
        if Rec.Type = Rec.Type::"Non-Inventory" then
            exit(true)
        else
            exit(false);
    end;

    procedure hidefields(): Boolean
    var
    begin
        if Rec.Type = Rec.Type::Service then
            exit(false)
        else
            exit(true);
    end;

    procedure editablefalseNonInventory(): Boolean
    var
    begin
        if Rec.Type = Rec.Type::"Non-Inventory" then
            exit(false)
        else
            exit(true);
    end;

    trigger OnOpenPage()
    var
    begin
        hideshowfields := hidefields();
        editablefalsefieldNonInventoryType := editablefalseNonInventory();
        ShowFinancialFields := not IsUserInProfile('FINANCE MANAGER');
        isUnitService := EvaluateFastTabVisibility();
        isUnitInventory := InventoryUnitVisibility();
        isVenderService := EvaluateFastTabVisibilityService();
        Unitcharges := UnitChargesFieldsVisiblity();
    end;

    var
        ISPrimaryType: Boolean;
        ShowFinancialFields: Boolean;
        hideshowfields: Boolean;
        editablefalsefieldNonInventoryType: Boolean;
        Unitcharges: Boolean;

    local procedure IsUserInProfile(ProfileID: Code[20]): Boolean
    var
        AccessControl: Record "User Personalization";
    begin
        AccessControl.SetRange("User ID", UserId());
        AccessControl.SetRange("Profile ID", ProfileID);
        exit(not AccessControl.IsEmpty());
    end;
}