page 73209631 "BLRProperty Type Card"
{
    PageType = Card;
    SourceTable = "BLRPropertyType";
    ApplicationArea = All;
    Caption = 'Property Type Card';
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Property Type Details';
                field("ID"; Rec."BLRID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the unique identifier for the property type.';
                }
                field("Classification Name"; Rec."BLRClassification Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Enter the classification name.';
                    NotBlank = true;
                }
                field("Property Type"; Rec."BLRProperty Type")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    NotBlank = true;
                    ToolTip = 'Enter the property type.';

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
