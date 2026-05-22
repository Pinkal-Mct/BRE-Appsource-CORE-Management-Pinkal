page 73209641 "Calculation Type List"
{
    PageType = List;
    SourceTable = "BLRCalculationType";
    ApplicationArea = All;
    Caption = 'Calculation Type List';
    UsageCategory = Lists;
    CardPageId = 73209618;

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
                    ToolTip = 'Specifies the unique identifier for the calculation type.';
                }
                field("Calculation Type"; Rec."BLRCalculation Type")
                {
                    ApplicationArea = All;
                    Caption = 'Calculation Type';
                    ToolTip = 'Specifies the name of the calculation type used for various calculations in the system.';
                }
            }
        }
    }

}
