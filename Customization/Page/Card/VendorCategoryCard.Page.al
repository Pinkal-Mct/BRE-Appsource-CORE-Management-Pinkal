page 73209638 "Vendor Category Card"
{
    PageType = Card;
    SourceTable = "BLRVendorCategory";
    ApplicationArea = All;
    Caption = 'Vendor Category Card';
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Vendor Category Details';
                field("ID"; Rec."BLRID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the unique identifier for the vendor category.';
                }
                field("Vendor Category Type"; Rec."BLRVendor Category Type")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Category Name';
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



