page 73209619 "BLRCategory Card"
{
    PageType = Card;
    SourceTable = "BLRCategoryType";
    ApplicationArea = All;
    Caption = 'Category Type';
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Category Type Details';
                field("ID"; Rec."BLRID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the unique identifier for the category type.';
                }
                field("Primary Item Type"; Rec."BLRPrimary Item Type")
                {
                    ApplicationArea = All;
                    Caption = 'Primary Item Type';
                    ToolTip = 'Select the associated Primary Item Type.';
                    ShowMandatory = true;
                    NotBlank = true;

                }
                field("Category Types"; Rec."BLRCategory Types")
                {
                    ApplicationArea = All;
                    Caption = 'Category Types';
                    ToolTip = 'Enter the Category Types.';
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
        Rec.TestField("BLRPrimary Item Type");
        Rec.TestField("BLRCategory Types");
    end;
}
