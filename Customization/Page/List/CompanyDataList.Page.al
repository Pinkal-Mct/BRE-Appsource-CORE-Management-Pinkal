page 73209645 "BLRCompany Data List"
{
    PageType = List;
    SourceTable = "BLRCompanyData";
    ApplicationArea = All;
    Caption = 'Company Data List';
    CardPageId = 73209622;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Company ID"; Rec."BLRCompany ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Your Company ID';
                }
                field("Company Name"; Rec."BLRCompany Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Your Company Name';
                }
                field("Company Logo"; Rec."BLRCompany Logo")
                {
                    ApplicationArea = All;
                    Editable = true;
                    ToolTip = 'Your Company logo';
                }
                field("Tenant id"; Rec."BLRTenant id")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Tenant ID';
                }
                field("Environment Name"; Rec."BLREnvironment Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Environment Name';
                }
            }
        }
    }
}