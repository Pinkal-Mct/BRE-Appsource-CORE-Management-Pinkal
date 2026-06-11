page 73209625 "BLRItem Dialog Box"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    Caption = 'Select Item Category';

    layout
    {
        area(Content)
        {
            group(Group)
            {
                field(ItemCategory; ItemCategory)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the category of the item.';
                    Caption = 'Item Category';
                }
            }
        }
    }

    procedure GetItemCategory(): Enum "BLRItem Template Enum"
    begin
        exit(ItemCategory);
    end;

    var
        ItemCategory: Enum "BLRItem Template Enum";
}

