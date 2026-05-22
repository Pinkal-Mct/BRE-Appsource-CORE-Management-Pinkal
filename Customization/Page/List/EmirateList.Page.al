page 73209647 "Emirate List"
{
    PageType = List;
    SourceTable = "BLREmirate";
    ApplicationArea = All;
    Caption = 'Emirate List';
    UsageCategory = Lists;
    CardPageId = 73209624;

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
                    ToolTip = 'Specifies the unique identifier for the emirate.';
                }
                field("Sl No."; Rec."BLRSl No.")
                {
                    ApplicationArea = All;
                    Caption = 'Sl No.';
                    ToolTip = 'Specifies the serial number for the emirate.';
                }
                field("Country Code"; Rec."BLRCountry Code")
                {
                    ApplicationArea = All;
                    Caption = 'Country Code';
                    TableRelation = "BLRCountry";
                    Lookup = true;
                    ToolTip = 'Specifies the country code associated with the emirate.';
                }
                field("Emirate Name"; Rec."BLREmirate Name")
                {
                    ApplicationArea = All;
                    Caption = 'Emirate Name';
                    ToolTip = 'Specifies the name of the emirate.';
                }
            }
        }
    }
}
