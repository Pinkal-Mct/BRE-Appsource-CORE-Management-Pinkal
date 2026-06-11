page 73209649 "BLROtherChargesUnearnedRevenue"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "BLROtherChargesUnearnedRevenue";
    Caption = 'Revenue Item';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."BLRNo.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique identifier for the other charges unearned revenue.';
                    Visible = false;
                }
                field("Item Type"; Rec."BLRItem Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Type of item associated with the other charges unearned revenue.';
                    Caption = 'Item Type';
                }
                field("Entry No."; Rec."BLREntry No.")
                {
                    ApplicationArea = All;
                    Caption = 'Entry No.';
                    ToolTip = 'Unique entry number for the other charges unearned revenue.';
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }


    var
        No: Integer;

    procedure SetNo(pNo: Integer)
    begin
        No := pNo;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."BLRNo." := No;
        exit(true);
    end;
}