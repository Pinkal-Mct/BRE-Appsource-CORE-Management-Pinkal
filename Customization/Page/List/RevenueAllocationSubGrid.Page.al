page 73209658 "Revenue Allocation SubGrid"
{
    PageType = ListPart;
    ApplicationArea = All;
    // UsageCategory = Administration;
    SourceTable = "BLRRevenueAllocationSubGrid";
    Caption = 'Revenue Allocation Master data';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Header No."; Rec."BLRHeader No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the unique identifier for the header of the revenue allocation.';
                }
                field("Line No."; Rec."BLRLine No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the line in the revenue allocation.';
                }
                field("Description"; Rec."BLRDescription")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the revenue allocation line.';
                }
                field("Unit Type"; Rec."BLRUnit Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of unit for the revenue allocation, such as property or single unit.';
                }
                field("Property Name"; Rec."BLRProperty Name")
                {
                    ApplicationArea = All;
                    tooltip = 'Specifies the name of the property associated with the revenue allocation.';
                }
                field("Single Unit Names"; Rec."BLRSingle Unit Names")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the names of single units associated with the revenue allocation.';
                }
                field("Contract Id"; Rec."BLRContract Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the contract associated with the revenue allocation.';
                }
                field("Contract Tenure"; Rec."BLRContract Tenure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the duration of the contract associated with the revenue allocation.';
                }
                field("Customer Name"; Rec."BLRCustomer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the customer associated with the revenue allocation.';
                }
                field("Contract Start Date"; Rec."BLRContract Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the start date of the contract associated with the revenue allocation.';
                }
                field("Contract End Date"; Rec."BLRContract End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the end date of the contract associated with the revenue allocation.';
                }
                field("Grace Days"; Rec."BLRGrace Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of grace days allowed for the revenue allocation.';
                }
                field("Grace Start Date"; Rec."BLRGrace Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the start date of the grace period for the revenue allocation.';
                }
                field("Grace End Date"; Rec."BLRGrace End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the end date of the grace period for the revenue allocation.';
                }
                field("Termination Date"; Rec."BLRTermination Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the termination date of the contract associated with the revenue allocation.';
                }
                field("Suspension Start Date"; Rec."BLRSuspension Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the start date of the suspension period for the revenue allocation.';
                }
                field("Suspension End Date"; Rec."BLRSuspension End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the end date of the suspension period for the revenue allocation.';
                }
                field("Multi Year Start Date"; Rec."BLRMulti Year Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the start date for multi-year contracts associated with the revenue allocation.';
                }
                field("Multi Year End Date"; Rec."BLRMulti Year End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the end date for multi-year contracts associated with the revenue allocation.';
                }
                field("Contract Amount"; Rec."BLRContract Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount of the contract associated with the revenue allocation.';
                }
                field("Annual Amount"; Rec."BLRAnnual Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the annual amount for the revenue allocation.';
                }
                field("Posting Month"; Rec."BLRPosting Month")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the month for posting the revenue allocation.';
                }
                field("Posting Year"; Rec."BLRPosting Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the year for posting the revenue allocation.';
                }
                field("Posting Period"; Rec."BLRPosting Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the posting period for the revenue allocation.';
                }
                field("Final Annual Amount"; Rec."BLRFinal Annual Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the final annual amount after adjustments for the revenue allocation.';
                }
                field("No Of Days"; Rec."BLRNo Of Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of days relevant to the revenue allocation, such as for billing or contract duration.';
                }
                field("Per Day Rent"; Rec."BLRPer Day Rent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the rent amount per day for the revenue allocation.';
                }
                field("Per Month Rent"; Rec."BLRPer Month Rent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the rent amount per month for the revenue allocation.';
                }
                field("Total Value"; Rec."BLRTotal Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total value of the revenue allocation, which may include adjustments or calculations based on the contract terms.';
                }
                field("Owner Name"; Rec."BLROwner Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the owner associated with the revenue allocation.';
                }
                field("Owner Share"; Rec."BLROwner Share")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the share of the owner in the revenue allocation.';
                }
            }
        }
    }
}