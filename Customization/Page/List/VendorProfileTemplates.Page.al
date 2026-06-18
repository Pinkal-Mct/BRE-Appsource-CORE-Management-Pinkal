page 73209669 "BLRVendor Profile Templates"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Vendor Profile Templates';
    SourceTable = "BLRVendorProfileTemplate";
    CardPageId = "BLRVendor Profile Template";

    layout
    {
        area(Content)
        {
            repeater(List)
            {
                field(Code; Rec."BLRCode")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the vendor profile template.';
                }
                field(Description; Rec."BLRDescription")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the vendor profile template.';
                }
            }
        }
    }
}