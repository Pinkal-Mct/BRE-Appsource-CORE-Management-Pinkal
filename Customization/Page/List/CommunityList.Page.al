page 73209644 "BLRCommunity List"
{
    PageType = List;
    SourceTable = "BLRCommunity";
    ApplicationArea = All;
    Caption = 'Community List';
    UsageCategory = Lists;
    CardPageId = 73209621;

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
                    ToolTip = 'The unique identifier for the community.';
                }
                field("Sl No."; Rec."BLRSl No.")
                {
                    ApplicationArea = All;
                    Caption = 'Sl No.';
                    ToolTip = 'The serial number of the community.';
                }
                field("Emirate Name"; Rec."BLREmirate Name")
                {
                    ApplicationArea = All;
                    Caption = 'Emirate Name';
                    TableRelation = "BLREmirate";
                    Lookup = true;
                    ToolTip = 'The name of the emirate where the community is located.';
                }
                field("Community Code"; Rec."BLRCommunity Code")
                {
                    ApplicationArea = All;
                    Caption = 'Community Code';
                    ToolTip = 'The unique code assigned to the community.';
                }
                field("Community Name"; Rec."BLRCommunity Name")
                {
                    ApplicationArea = All;
                    Caption = 'Community Name';
                    ToolTip = 'The name of the community.';
                }
            }
        }
    }
}
