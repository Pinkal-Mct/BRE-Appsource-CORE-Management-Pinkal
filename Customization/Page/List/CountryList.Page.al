page 73209646 "Country List"
{
    PageType = List;
    SourceTable = "BLRCountry";
    ApplicationArea = All;
    Caption = 'Country List';
    UsageCategory = Lists;
    CardPageId = 73209623;

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
                    ToolTip = 'The unique identifier for the country.';
                }
                field("Sl No."; Rec."BLRSl No.")
                {
                    ApplicationArea = All;
                    Caption = 'Sl No.';
                    ToolTip = 'The serial number of the country.';
                }
                field("Country Code"; Rec."BLRCountry Code")
                {
                    ApplicationArea = All;
                    Caption = 'Country Code';
                    ToolTip = 'The unique code assigned to the country.';
                }
                field("Country Name"; Rec."BLRCountry Name")
                {
                    ApplicationArea = All;
                    Caption = 'Country Name';
                    ToolTip = 'The name of the country.';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(New)
            {
                ApplicationArea = All;
                Caption = 'New';
                Image = New;
                ToolTip = 'Create a new country.';
                trigger OnAction()
                begin
                    Rec.Init();
                    Rec.Insert(true);
                    CurrPage.Update();
                end;
            }
        }

        area(Promoted)
        {
            actionref(new_; New) { }
        }
    }
}
