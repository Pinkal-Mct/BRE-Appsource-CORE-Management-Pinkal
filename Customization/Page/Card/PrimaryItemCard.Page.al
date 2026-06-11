page 73209630 "BLRPrimary Item Card"
{
    PageType = Card;
    SourceTable = "BLRPrimaryItem";
    ApplicationArea = All;
    Caption = 'Primary Item Card';
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Primary Item Details';
                field("ID"; Rec."BLRID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the unique identifier for the primary classification.';
                }
                field("Primary Item Type"; Rec."BLRPrimary Item Type")
                {
                    ApplicationArea = All;
                    Caption = 'Primary Classification Name';
                    ToolTip = 'Enter the primary classification name.';
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



