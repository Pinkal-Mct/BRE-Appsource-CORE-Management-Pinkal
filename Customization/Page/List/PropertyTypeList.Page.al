page 73209655 "Property Type List"
{
    PageType = List;
    SourceTable = "BLRPropertyType";
    ApplicationArea = All;
    Caption = 'Property Type List';
    UsageCategory = Lists;
    CardPageId = 73209631;

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
                    ToolTip = 'The unique identifier for the property type.';
                }
                field("Classification Name"; Rec."BLRClassification Name")
                {
                    ApplicationArea = All;
                    Caption = 'Primary Classification';
                    TableRelation = "BLRPrimaryClassification";
                    Lookup = true;
                    ToolTip = 'The primary classification of the property type.';
                }
                field("Property Type"; Rec."BLRProperty Type")
                {
                    ApplicationArea = All;
                    Caption = 'Unit Type';
                    ToolTip = 'The name of the property type.';
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
                ToolTip = 'Create a new property type.';

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
