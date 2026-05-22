page 73209669 "Vendor Profile Templates"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "BLRVendorProfileTemplate";
    CardPageId = "Vendor Profile Template";

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