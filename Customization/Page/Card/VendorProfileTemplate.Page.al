page 73209639 "Vendor Profile Template"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "BLRVendorProfileTemplate";

    layout
    {
        area(Content)
        {
            group(General)
            {
                group(General1)
                {
                    ShowCaption = false;
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
                group(General2)
                {
                    ShowCaption = false;
                    field("No. Series"; Rec."BLRNo. Series")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the number series used for the vendor profile template.';
                        TableRelation = "No. Series";
                    }
                    field(Module; Rec."BLRModule")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the type of vendor profile template.';
                        ValuesAllowed = "FM", "PS";
                    }
                }
            }
        }
    }
}