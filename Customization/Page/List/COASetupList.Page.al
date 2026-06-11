page 73209643 "BLRCOA Setup List"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "BLRCOASetupLine";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Item; Rec."BLRSecondary Item")
                {
                    ApplicationArea = All;
                    ToolTip = 'Secondary Item';
                }
                field(Residential; Rec."BLRResidential") { ApplicationArea = All; ToolTip = 'Residential Property'; }
                field(Commercial; Rec."BLRCommercial") { ApplicationArea = All; ToolTip = 'Commercial Property'; }
                field("Residential-Unearned"; Rec."BLRResidential-Unearned") { ApplicationArea = All; ToolTip = 'Residential-Unearned'; }
                field("Commercial-Unearned"; Rec."BLRCommercial-Unearned") { ApplicationArea = All; ToolTip = 'Commercial-Unearned'; }

            }
        }
    }
}