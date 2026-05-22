page 73209623 "Country Card"
{
    PageType = Card;
    SourceTable = "BLRCountry";
    ApplicationArea = All;
    Caption = 'Country Card';
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Country Details';
                field("ID"; Rec."BLRID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the country.';
                }
                field("Sl No."; Rec."BLRSl No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the serial number for the country.';
                }
                field("Country Code"; Rec."BLRCountry Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the country code.';
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field("Country Name"; Rec."BLRCountry Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the country.';
                    ShowMandatory = true;
                    NotBlank = true;

                    trigger onvalidate()
                    begin
                        currpage.saverecord();
                    end;
                }
            }


        }


    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.TestField("BLRCountry Code");
        Rec.TestField("BLRCountry Name");
    end;

}



