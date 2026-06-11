page 73209659 "BLRRevenueRecognitionDetailSub"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "BLRRevenueRecognitionDetails";
    Caption = 'Revenue Recognition Details';
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."BLREntry No.")
                {
                    ToolTip = 'The unique entry number for the revenue recognition item.';
                    ApplicationArea = All;
                    Caption = 'Entry No.';
                    Visible = false;
                }
                field("Description"; Rec."BLRDescription")
                {
                    ToolTip = 'The description of the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Unit Type"; Rec."BLRUnit Type")
                {
                    ToolTip = 'The type of unit associated with the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Item Type"; Rec."BLRItem Type")
                {
                    ToolTip = 'The type of item associated with the revenue recognition.';
                    ApplicationArea = All;
                }
                field("Property Name"; Rec."BLRProperty Name")
                {
                    ToolTip = 'The name of the property associated with the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Single Unit Names"; Rec."BLRSingle Unit Names")
                {
                    ToolTip = 'The names of the single units associated with the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Contract Id"; Rec."BLRContract Id")
                {
                    ToolTip = 'The unique identifier for the contract associated with the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Contract Tenure"; Rec."BLRContract Tenure")
                {
                    ToolTip = 'The tenure of the contract associated with the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."BLRCustomer Name")
                {
                    ToolTip = 'The name of the customer associated with the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Contract Start Date"; Rec."BLRContract Start Date")
                {
                    ToolTip = 'The start date of the contract associated with the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Contract End Date"; Rec."BLRContract End Date")
                {
                    ToolTip = 'The end date of the contract associated with the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Grace Days"; Rec."BLRGrace Days")
                {
                    ToolTip = 'The number of grace days associated with the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Grace Start Date"; Rec."BLRGrace Start Date")
                {
                    ToolTip = 'The start date of the grace period for the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Grace End Date"; Rec."BLRGrace End Date")
                {
                    ToolTip = 'The end date of the grace period for the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Termination Date"; Rec."BLRTermination Date")
                {
                    ToolTip = 'The termination date of the contract associated with the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Suspension Start Date"; Rec."BLRSuspension Start Date")
                {
                    ToolTip = 'The start date of the suspension period for the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Suspension End Date"; Rec."BLRSuspension End Date")
                {
                    ToolTip = 'The end date of the suspension period for the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Multi Year Start Date"; Rec."BLRMulti Year Start Date")
                {
                    ToolTip = 'The start date of the multi-year period for the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Multi Year End Date"; Rec."BLRMulti Year End Date")
                {
                    ToolTip = 'The end date of the multi-year period for the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Contract Amount"; Rec."BLRContract Amount")
                {
                    ToolTip = 'The total amount of the contract associated with the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Annual Amount"; Rec."BLRAnnual Amount")
                {
                    ToolTip = 'The annual amount calculated for the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Posting Month"; Rec."BLRPosting Month")
                {
                    ToolTip = 'The month in which the revenue recognition item is posted.';
                    ApplicationArea = All;
                }
                field("Posting Year"; Rec."BLRPosting Year")
                {
                    ToolTip = 'The year in which the revenue recognition item is posted.';
                    ApplicationArea = All;
                }
                field("Posting Period"; Rec."BLRPosting Period")
                {
                    ToolTip = 'The period in which the revenue recognition item is posted.';
                    ApplicationArea = All;
                }
                field("Final Annual Amount"; Rec."BLRFinal Annual Amount")
                {
                    ToolTip = 'The final annual amount calculated for the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("No Of Days"; Rec."BLRNo Of Days")
                {
                    ToolTip = 'The number of days associated with the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Per Day Rent"; Rec."BLRPer Day Rent")
                {
                    ToolTip = 'The rent amount per day for the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Per Month Rent"; Rec."BLRPer Month Rent")
                {
                    ToolTip = 'The rent amount per month for the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Total Value"; Rec."BLRTotal Value")
                {
                    ToolTip = 'The total value calculated for the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Owner Name"; Rec."BLROwner Name")
                {
                    ToolTip = 'The name of the owner associated with the revenue recognition item.';
                    ApplicationArea = All;
                }
                field("Owner Share"; Rec."BLROwner Share")
                {
                    ToolTip = 'The share of the owner in the revenue recognition item.';
                    ApplicationArea = All;
                }
            }
        }
    }
    procedure SetRIID(pRRID: Integer)
    begin
        RRID := pRRID;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."BLRRR_No." := RRID;
    end;

    var
        RRID: Integer;
}