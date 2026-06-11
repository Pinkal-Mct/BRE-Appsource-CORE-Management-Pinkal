page 73209624 "BLREmirate Card"
{
    PageType = Card;
    SourceTable = "BLREmirate";
    ApplicationArea = All;
    Caption = 'Emirate Card';
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Emirate Details';
                field("ID"; Rec."BLRID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the emirate.';
                }
                field("Sl No."; Rec."BLRSl No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the serial number for the emirate.';
                }
                field("Country Code"; Rec."BLRCountry Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the country code associated with the emirate.';
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field("Emirate Name"; Rec."BLREmirate Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the emirate.';
                    ShowMandatory = true;
                    NotBlank = true;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.TestField("BLRCountry Code");
        Rec.TestField("BLREmirate Name");
    end;
}
