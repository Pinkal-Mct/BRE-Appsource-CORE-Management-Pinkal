page 73209648 "BLRInteger List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = Integer;

    layout
    {
        area(Content)
        {
            repeater(List)
            {
                field(Number; Rec.Number)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the integer number.';
                }
            }
        }
    }
}