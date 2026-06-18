pageextension 73209576 "BLRItem Templ. Card Ext" extends "Item Templ. Card"
{
    layout
    {
        addafter("No. Series")
        {
            field("BLRItem Type"; Rec."BLRModule Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the module type for the item template.';
            }
            field(BLRTypes; Rec."BLRTypes")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the type of item template.';
            }
            field("BLRItem type template"; Rec."BLRItem type template")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the item type template.';
            }
        }
    }
}