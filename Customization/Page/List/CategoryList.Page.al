page 73209642 "Category List"
{
    PageType = List;
    SourceTable = "BLRCategoryType";
    ApplicationArea = All;
    Caption = 'Category List';
    UsageCategory = Lists;
    CardPageId = 73209619;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ID"; Rec."BLRID")
                {
                    ApplicationArea = All;
                    Caption = 'ID';
                    ToolTip = 'Specifies the unique identifier for the category type.';
                }
                field("Primary Item Type"; Rec."BLRPrimary Item Type")
                {
                    ApplicationArea = All;
                    Caption = 'Primary Item';
                    TableRelation = "BLRPrimaryItem";
                    // Display the Primary Classification description
                    Lookup = true; // Enable lookup to Primary Classification
                    ToolTip = 'Specifies the primary item type associated with this category.';
                }
                field("Category Types"; Rec."BLRCategory Types")
                {
                    ApplicationArea = All;
                    Caption = 'Category Types';
                    ToolTip = 'Specifies the category types associated with this record.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
#pragma warning disable AW0005
#pragma warning disable AW0011
            action(New)
#pragma warning restore AW0011
#pragma warning restore AW0005
            {
                ApplicationArea = All;
                Caption = 'New';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Create a new category type record.';
                trigger OnAction()
                begin
                    Rec.Init();
                    Rec.Insert(true);
                    CurrPage.Update();
                end;
            }
        }
    }


}
