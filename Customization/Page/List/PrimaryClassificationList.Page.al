page 73209653 "BLRPrimary Classification List"
{
    PageType = List;
    SourceTable = "BLRPrimaryClassification";
    ApplicationArea = All;
    Caption = 'Primary Classification List';
    UsageCategory = Lists;
    CardPageId = 73209629;

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
                    ToolTip = 'Unique identifier for the primary classification.';
                }
                field("Classification Name"; Rec."BLRClassification Name")
                {
                    ApplicationArea = All;
                    Caption = 'Primary Classification Name';
                    ToolTip = 'Name of the primary classification.';
                }
            }
        }
    }
}
