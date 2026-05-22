page 73209618 "Calculation Type Card"
{
    PageType = Card;
    SourceTable = "BLRCalculationType";
    ApplicationArea = All;
    Caption = 'Calculation Type Card';
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Calculation Type Details';
                field("ID"; Rec."BLRID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the unique identifier for the calculation type.';
                }
                field("Calculation Type"; Rec."BLRCalculation Type")
                {
                    ApplicationArea = All;
                    Caption = 'Calculation Type';
                    ToolTip = 'Enter the Vendor Categoryname.';
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


}



