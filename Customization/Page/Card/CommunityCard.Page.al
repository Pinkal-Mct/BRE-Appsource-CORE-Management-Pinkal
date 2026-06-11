page 73209621 "BLRCommunity Card"
{
    PageType = Card;
    SourceTable = "BLRCommunity";
    ApplicationArea = All;
    Caption = 'Community Card';
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Community Details';
                field("ID"; Rec."BLRID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the community.';
                }
                field("Sl No."; Rec."BLRSl No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the serial number for the community.';
                }
                field("Community Name"; Rec."BLRCommunity Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the community.';
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field("Emirate Name"; Rec."BLREmirate Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the emirate associated with the community.';
                    ShowMandatory = true;
                    NotBlank = true;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
                field("Community Code"; Rec."BLRCommunity Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the community.';
                }

            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.TestField("BLRCommunity Name");
        Rec.TestField("BLREmirate Name");
    end;
}
