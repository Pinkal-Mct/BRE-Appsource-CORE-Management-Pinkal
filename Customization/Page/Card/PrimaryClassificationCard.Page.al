page 73209629 "Primary Classification Card"
{
    PageType = Card;
    SourceTable = "BLRPrimaryClassification";
    ApplicationArea = All;
    Caption = 'Primary Classification Card';
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Primary Classification Details';
                field("ID"; Rec."BLRID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the unique identifier for the primary classification.';
                }
                field("Classification Name"; Rec."BLRClassification Name")
                {
                    ApplicationArea = All;
                    Caption = 'Primary Classification Name';
                    ShowMandatory = true;
                    NotBlank = true;
                    ToolTip = 'Enter the primary classification name.';

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
            }
        }

    }


}



