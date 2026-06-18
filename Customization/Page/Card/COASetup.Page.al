page 73209620 "BLRCOA Setup"
{
    PageType = Card;
    ApplicationArea = All;
    Caption = 'COA Setup';
    UsageCategory = Administration;
    SourceTable = "BLRCOASetup";

    layout
    {
        area(Content)
        {
            group(Tenant)
            {
                Caption = 'Tenant Accounts';
                field("Tenant Receivables-Residential"; Rec."BLRTenantRecvsRes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for residential tenant receivables.';
                }
                field("Tenant Receivables-Commercial"; Rec."BLRTenantRecvsComm")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for commercial tenant receivables.';
                }
            }
            group(Rent)
            {
                Caption = 'Rent Accounts';
                field("Residential Rent"; Rec."BLRResidential Rent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for residential rent.';
                }
                field("Commercial Rent"; Rec."BLRCommercial Rent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for commercial rent.';
                }
                field("Residential Unearned Rent"; Rec."BLRResidential Unearned Rent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for unearned residential rent.';
                }
                field("Commercial Unearned Rent"; Rec."BLRCommercial Unearned Rent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for unearned commercial rent.';
                }
                field(Cash; Rec."BLRCash")
                {
                    ApplicationArea = All;
                    Caption = 'Cash';
                    ToolTip = 'Specifies the G/L account for cash receipts.';
                }
            }
            group(CarryForward)
            {
                Caption = 'Carry Forward Security Deposit Account';

                field("Carriedforward in SD"; Rec."BLRCarried Forward in SD")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for security deposits carried forward as incoming.';
                }
                field("Carried Forward Out SD"; Rec."BLRCarried Forward Out SD")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for security deposits carried forward as outgoing.';
                }
            }
            group(PDCAcoounts)
            {
                Caption = 'PDC Accounts';
                field("PDC Received"; Rec."BLRPDC Received")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for post-dated checks received.';
                }
                field("PDC Collection/Return"; Rec."BLRPDC Collection/Return")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for post-dated checks collection or return.';
                }
                field("PDC Issued"; Rec."BLRPDC Issued")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for post-dated checks issued.';
                }
                field("PDC Cleared/Returned"; Rec."BLRPDC Cleared/Returned")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for post-dated checks that have been cleared or returned.';
                }
                field("PDC Liabilities"; Rec."BLRPDC Liabilities")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for post-dated checks liabilities.';
                }
            }
            part(COASetupLines; "BLRCOA Setup List")
            {
                ApplicationArea = All;
                Caption = 'COA Setup Lines';
                SubPageLink = "BLRPrimary Key" = field("BLRPrimary Key");
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}