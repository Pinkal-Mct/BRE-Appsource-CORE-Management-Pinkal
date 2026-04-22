table 73209595 "COA Setup Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(73209575; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(73209576; "Primary Key"; Code[10])
        {
            DataClassification = SystemMetadata;
            Caption = 'Primary Key';
        }
        field(73209577; "Secondary Item"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item where("Item Type Template" = const("Item Type Template Enum"::"Secondary Item"));

            trigger onValidate()
            begin
                PopulateItemDescription(Rec."Secondary Item");
            end;
        }
        field(73209578; Residential; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(73209579; Commercial; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(73209580; "Residential-Unearned"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(73209581; "Commercial-Unearned"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Primary Key")
        {
            Clustered = true;
        }
    }

    procedure PopulateItemDescription(pItemNo: Text[100])
    var
        item: Record Item;
    begin
        if item.Get(pItemNo) then
            Rec."Secondary Item" := item.Description
        else
            Rec."Secondary Item" := '';
    end;
}