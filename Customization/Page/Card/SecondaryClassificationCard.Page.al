page 73209634 "BLRSecondaryClassificationCard"
{
    PageType = Card;
    SourceTable = "BLRSecondaryClassification";
    ApplicationArea = All;
    Caption = 'Unit Type';
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Unit Type Details';
                field("ID"; Rec."BLRID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the unique identifier for the secondary classification.';
                }
                field("Classification Name"; Rec."BLRClassification Name")
                {
                    ApplicationArea = All;
                    Caption = 'Primary Classification';
                    ToolTip = 'Select the associated primary classification.';
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field("Property Type"; Rec."BLRProperty Type")
                {
                    ApplicationArea = All;
                    Caption = 'Unit Type';
                    ToolTip = 'Enter the property type.';
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
        Rec.TestField("BLRClassification Name");
        Rec.TestField("BLRProperty Type");
    end;

}
