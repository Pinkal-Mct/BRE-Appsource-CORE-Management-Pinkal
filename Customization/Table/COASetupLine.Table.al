table 73209595 "BLRCOASetupLine"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(73209575; "BLREntry No."; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(73209576; "BLRPrimary Key"; Code[10])
        {
            DataClassification = SystemMetadata;
            Caption = 'Primary Key';
        }
        field(73209577; "BLRSecondary Item"; Text[100])
        {
            DataClassification = SystemMetadata;
            TableRelation = Item where("BLRItem Type Template" = const("Item Type Template Enum"::"Secondary Item"));

            trigger onValidate()
            begin
                PopulateItemDescription(Rec."BLRSecondary Item");
            end;
        }
        field(73209578; "BLRResidential"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "G/L Account"."No.";
        }
        field(73209579; "BLRCommercial"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "G/L Account"."No.";
        }
        field(73209580; "BLRResidential-Unearned"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "G/L Account"."No.";
        }
        field(73209581; "BLRCommercial-Unearned"; code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "G/L Account"."No.";
        }
    }

    keys
    {
        key(Key1; "BLREntry No.", "BLRPrimary Key")
        {
            Clustered = true;
        }
    }

    procedure PopulateItemDescription(pItemNo: Text[100])
    var
        item: Record Item;
    begin
        if item.Get(pItemNo) then
            Rec."BLRSecondary Item" := item.Description
        else
            Rec."BLRSecondary Item" := '';
    end;
}
