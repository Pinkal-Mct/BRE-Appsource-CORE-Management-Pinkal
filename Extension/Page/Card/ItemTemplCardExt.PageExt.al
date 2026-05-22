pageextension 73209576 "Item Templ. Card Ext" extends "Item Templ. Card"
{
    layout
    {
        addafter("No. Series")
        {
            field("Item Type"; Rec."BLRModule Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the module type for the item template.';
            }
            field(Types; Rec."BLRTypes")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the type of item template.';
            }
            field("Item type template"; Rec."BLRItem type template")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the item type template.';
            }
        }
    }
}