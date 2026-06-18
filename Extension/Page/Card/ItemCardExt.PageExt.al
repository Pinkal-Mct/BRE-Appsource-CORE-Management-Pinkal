pageextension 73209575 "BLRItem Card Ext" extends "Item Card"
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
            group("BLRPosting setup")
            {
                ShowCaption = false;
                Visible = hideshowfields and isVenderService or Unitcharges;
            }
        }
        movefirst("BLRPosting setup"; "Gen. Prod. Posting Group", "VAT Prod. Posting Group")
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
            group(BLRDescriptionGrp)
            {
                ShowCaption = false;
                Visible = isVenderService or Unitcharges or isUnitService or isUnitInventory;
            }
        }
        movefirst(BLRDescriptionGrp; Description)
        addafter(Type)
        {
            group("BLRUnit Charges Description")
            {
                ShowCaption = false;
                Visible = Unitcharges or isVenderService;

                field("BLRPrimary Item Type"; Rec."BLRPrimary Item Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Primary Item Type';
                }
                field("BLRCategory Types"; Rec."BLRCategory Types")
                {
                    ApplicationArea = All;
                    ToolTip = 'Category Types';
                }
                field("BLRVAT Type"; Rec."BLRVAT Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'VAT Type';
                }
                field("BLRVAT %"; Rec."BLRVAT %")
                {
                    ApplicationArea = All;
                    ToolTip = 'VAT Percentage';
                }
                field("BLRCharges Status"; Rec."BLRCharges Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Charges Status';
                }
            }
        }
        addafter("Base Unit of Measure")
        {
            group("BLRBaseUnitofMeasure")
            {
                ShowCaption = false;
                Visible = isUnitService or isUnitInventory;
                field("BLRMarket Rate per Sq. Ft."; rec."BLRMarket Rate per Sq. Ft.")
                {
                    ApplicationArea = All;
                    Editable = editablefalsefieldNonInventoryType;
                    ToolTip = 'Market Rate per Square Foot';
                }
            }
        }
        addafter("BLRMarket Rate per Sq. Ft.")
        {
            group("BLRMarketRateperSq.Ft.")
            {
                ShowCaption = false;
                Visible = isUnitService or isUnitInventory;
                field("BLRUnit Size"; rec."BLRUnit Size")
                {
                    ApplicationArea = All;
                    Caption = 'Unit Size';
                    ToolTip = 'Size of the Unit in Square Feet';
                    Editable = editablefalsefieldNonInventoryType;
                }
            }

        }
        addafter("BLRUnit Size")
        {
            group("BLRUnitSize")
            {
                ShowCaption = false;
                Visible = isUnitService or isUnitInventory;
                field("BLRAmount"; rec."BLRAmount")
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
            group("BLRGen.Prod.PostingGroup")
            {
                ShowCaption = false;
                Visible = isUnitService or isUnitInventory;
                field("BLRPrimary Classification Type"; Rec."BLRPrimary Classification Type")
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
            group(BLRUnitManagement)
            {
                Visible = isUnitService or isUnitInventory;
                Caption = 'Unit Management';

                field(BLRFixedNumber; Rec."BLRFixedNumber")
                {
                    ApplicationArea = All;
                    Caption = 'FixedNumber';
                    ToolTip = 'Fixed Number for the Unit';
                    Editable = false;
                    Visible = false;
                }
                field("BLRProperty ID"; Rec."BLRProperty ID")
                {
                    ApplicationArea = All;
                    Caption = 'Property ID';
                    ToolTip = 'Select the associated Property ID.';
                    Editable = editablefalsefieldNonInventoryType;
                    trigger OnValidate()
                    begin
                        BLRAutoGenerateUnitName(Rec);
                    end;
                }

                field("BLRProperty Name"; Rec."BLRProperty Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Select the associated Property Name.';
                    Caption = 'Property Name';
                    Editable = false;
                }
                field("BLRCountry"; Rec."BLRCountry")
                {
                    ApplicationArea = All;
                    Caption = 'Country';
                    ToolTip = 'Country where the Unit is located';
                    Lookup = true;
                    Editable = false;
                    trigger OnValidate()
                    begin
                        BLRAutoGenerateUnitName(Rec);
                    end;

                }
                field("BLREmirate"; Rec."BLREmirate Name")
                {
                    ApplicationArea = All;
                    Caption = 'Emirate';
                    ToolTip = 'Emirate where the Unit is located';
                    Lookup = true;
                    Editable = false;
                    trigger OnValidate()
                    begin
                        BLRAutoGenerateUnitName(Rec);
                    end;
                }
                field("BLRCommunity"; Rec."BLRCommunity")
                {
                    ApplicationArea = All;
                    Caption = 'Community';
                    ToolTip = 'Community where the Unit is located';
                    Lookup = true;
                    Editable = false;
                    trigger OnValidate()
                    begin
                        BLRAutoGenerateUnitName(Rec);
                    end;
                }
                field("BLRMakani Number"; Rec."BLRMakani Number")
                {
                    ApplicationArea = All;
                    Caption = 'Makani Number';
                    ToolTip = 'Makani Number of the Unit';
                }
                field("BLRMunicipality Number"; Rec."BLRMunicipality Number")
                {
                    ApplicationArea = All;
                    Caption = 'Municipality Number';
                    ToolTip = 'Municipality Number of the Unit';
                }
                field("BLRDEWA Number"; Rec."BLRDEWA Number")
                {
                    ApplicationArea = All;
                    Caption = 'DEWA Number';
                    ToolTip = 'DEWA Number of the Unit';
                }
                field("BLRFloor Number"; Rec."BLRFloor Number")
                {
                    ApplicationArea = All;
                    Caption = 'Floor Number';
                    ToolTip = 'Floor Number of the Unit';
                    Editable = editablefalsefieldNonInventoryType;
                }
                field("BLRUnit Number"; Rec."BLRUnit Number")
                {
                    ApplicationArea = All;
                    Caption = 'Unit Number';
                    ToolTip = 'Actual Unit Number within the Property';
                    Editable = editablefalsefieldNonInventoryType;
                    trigger OnValidate()
                    begin
                        BLRAutoGenerateUnitName(Rec);
                    end;
                }

                field("BLRUnit ID"; Rec.BLRUnitID)
                {
                    ApplicationArea = All;
                    Caption = 'Unit ID';
                    ToolTip = 'Unique Identifier for the Unit';
                    Editable = false;
                }
                field("BLRUnit Name"; Rec."BLRUnit Name")
                {
                    ApplicationArea = All;
                    Caption = 'Unit Name';
                    ToolTip = 'Name of the Unit';
                    Editable = false;
                }

                field("BLRUsage Type"; rec."BLRUsage Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Usage Type of the Unit';
                    Lookup = true;
                    Editable = false;
                }

                field("BLRUnit Type"; rec."BLRUnit Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Type of the Unit';
                    Lookup = true;
                    Editable = editablefalsefieldNonInventoryType;
                }
                field("BLRUnit Address"; rec."BLRUnit Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Address of the Unit';
                    Editable = editablefalsefieldNonInventoryType;
                }
                field("BLRMerging/Splitting"; rec."BLRMergeSplitOption")
                {
                    ApplicationArea = All;
                    ToolTip = 'Option for Merging or Splitting the Unit';
                    Editable = false;
                }

                field("BLRUnit Status"; rec."BLRUnit Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Current Status of the Unit';
                    Lookup = true;
                }
            }
            part("BLRDocument Attachments"; "BLRUnit Document SubPage")
            {
                SubPageLink = "BLRUnitID" = field("No.");
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
                BLRAutoGenerateUnitName(Rec);
            end;
        }
        addafter("Item Journal")
        {
            action("BLRAdd New Line")
            {
                ApplicationArea = All;
                ToolTip = 'Add a new line to the Unit Charges';
                Image = New;
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

    procedure BLRAutoGenerateUnitName(var TargetItem: Record Item)
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
        PropertyCode := BLRFormatName(TargetItem."BLRProperty Name");
        lCountry := Format(TargetItem."BLRCountry");
        Emirates := Format(TargetItem."BLREmirate Name");
        lCommunity := Format(TargetItem."BLRCommunity");
        Unitnumber := Format(TargetItem."BLRUnit Number");
        CountryCode := BLRFormatName(lCountry);
        EmiratesCode := BLRFormatName(Emirates);
        CommunityCode := BLRFormatName(lCommunity);
        UnitnumberCode := Format(Unitnumber);
        TargetItem."BLRUnit Name" := PropertyCode + '-SU-' + UnitnumberCode;
        UnitID := CountryCode + '-' + EmiratesCode + '-' + CommunityCode + '-' + PropertyCode + '-' + UnitnumberCode;
        TargetItem."BLRUnitID" := CopyStr(UnitID, 1, StrLen(UnitID));
        TargetItem.Modify();
    end;

    procedure BLRFormatName(Name: Text): Text
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

    procedure BLREvaluateFastTabVisibility(): Boolean
    begin
        if Rec."BLRItem Template" = Enum::"BLRItem Template Enum"::Service then
            if Rec."BLRItem type template" = Enum::"BLRItem Type Template Enum"::"Unit Service" then
                exit(true)
            else
                exit(false);
    end;

    procedure BLREvaluateFastTabVisibilityService(): Boolean
    begin
        if Rec."BLRItem Template" = Enum::"BLRItem Template Enum"::Service then
            if Rec."BLRItem type template" = Enum::"BLRItem Type Template Enum"::"Vendor Service" then
                exit(true)
            else
                exit(false);
    end;

    procedure BLRUnitChargesFieldsVisiblity(): Boolean
    begin
        if Rec."BLRItem Template" = Enum::"BLRItem Template Enum"::Service then
            if Rec."BLRItem type template" = Enum::"BLRItem Type Template Enum"::"Secondary Item" then
                exit(true)
            else
                exit(false);
    end;

    procedure BLRInventoryUnitVisibility(): Boolean
    begin
        if Rec."BLRItem Template" = Enum::"BLRItem Template Enum"::Inventory then
            if Rec."BLRItem type template" = Enum::"BLRItem Type Template Enum"::"Unit Inventory" then
                exit(true)
            else
                exit(false);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        CurrPage."BLRDocument Attachments".Page.SetUnitId(Rec."No.");
        ISPrimaryType := BLRSetPrimaryType();
        hideshowfields := BLRHidefields();
        editablefalsefieldNonInventoryType := BLREditablefalseNonInventory();
        isUnitService := BLREvaluateFastTabVisibility();
        isUnitInventory := BLRInventoryUnitVisibility();
        isVenderService := BLREvaluateFastTabVisibilityService();
        Unitcharges := BLRUnitChargesFieldsVisiblity();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CurrPage."BLRDocument Attachments".Page.SetUnitId(Rec."No.");
        isVisible := true;

        if Rec."BLRProperty Name" = '' then
            exit
        else
            BLRAutoGenerateUnitName(Rec);
    end;

    trigger OnAfterGetRecord()

    begin
        CurrPage."BLRDocument Attachments".Page.SetUnitId(Rec."No.");
        if Format(Rec."No.") <> '' then
            isVisible := true
        else
            isVisible := false;

        ISPrimaryType := BLRSetPrimaryType();
        hideshowfields := BLRHidefields();
        editablefalsefieldNonInventoryType := BLREditablefalseNonInventory();
        isUnitService := BLREvaluateFastTabVisibility();
        isUnitInventory := BLRInventoryUnitVisibility();
        isVenderService := BLREvaluateFastTabVisibilityService();
        Unitcharges := BLRUnitChargesFieldsVisiblity();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        ISPrimaryType := BLRSetPrimaryType();
        hideshowfields := BLRHidefields();
        editablefalsefieldNonInventoryType := BLREditablefalseNonInventory();
        Unitcharges := BLRUnitChargesFieldsVisiblity();
        isUnitService := BLREvaluateFastTabVisibility();
        isUnitInventory := BLRInventoryUnitVisibility();
        isVenderService := BLREvaluateFastTabVisibilityService();
    end;

    procedure BLRSetPrimaryType(): Boolean
    var
    begin
        if Rec.Type = Rec.Type::"Non-Inventory" then
            exit(true)
        else
            exit(false);
    end;

    procedure BLRHidefields(): Boolean
    var
    begin
        if Rec.Type = Rec.Type::Service then
            exit(false)
        else
            exit(true);
    end;

    procedure BLREditablefalseNonInventory(): Boolean
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
        hideshowfields := BLRHidefields();
        editablefalsefieldNonInventoryType := BLREditablefalseNonInventory();
        ShowFinancialFields := not BLRIsUserInProfile('FINANCE MANAGER');
        isUnitService := BLREvaluateFastTabVisibility();
        isUnitInventory := BLRInventoryUnitVisibility();
        isVenderService := BLREvaluateFastTabVisibilityService();
        Unitcharges := BLRUnitChargesFieldsVisiblity();
    end;

    var
        ISPrimaryType: Boolean;
        ShowFinancialFields: Boolean;
        hideshowfields: Boolean;
        editablefalsefieldNonInventoryType: Boolean;
        Unitcharges: Boolean;

    local procedure BLRIsUserInProfile(ProfileID: Code[20]): Boolean
    var
        AccessControl: Record "User Personalization";
    begin
        AccessControl.SetRange("User ID", UserId());
        AccessControl.SetRange("Profile ID", ProfileID);
        exit(not AccessControl.IsEmpty());
    end;
}