page 50524 "COA Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "COA Setup";

    layout
    {
        area(Content)
        {
            group(Tenant)
            {
                Caption = 'Tenant Accounts';
                field("Tenant Receivables-Residential"; Rec."Tenant Receivables-Residential")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for residential tenant receivables.';
                }
                field("Tenant Receivables-Commercial"; Rec."Tenant Receivables-Commercial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for commercial tenant receivables.';
                }
            }
            group(Rent)
            {
                Caption = 'Rent Accounts';
                field("Residential Rent"; Rec."Residential Rent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for residential rent.';
                }
                field("Commercial Rent"; Rec."Commercial Rent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for commercial rent.';
                }
                field("Residential Unearned Rent"; Rec."Residential Unearned Rent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for unearned residential rent.';
                }
                field("Commercial Unearned Rent"; Rec."Commercial Unearned Rent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for unearned commercial rent.';
                }
                field(Cash; Rec.Cash)
                {
                    ApplicationArea = All;
                    Caption = 'Cash';
                    ToolTip = 'Specifies the G/L account for cash receipts.';
                }
            }
            group(CarryForward)
            {
                Caption = 'Carry Forward Security Deposit Account';

                field("Carriedforward in SD"; Rec."Carried Forward in SD")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for security deposits carried forward as incoming.';
                }
                field("Carried Forward Out SD"; Rec."Carried Forward Out SD")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for security deposits carried forward as outgoing.';
                }
            }
            group(PDCAcoounts)
            {
                Caption = 'PDC Accounts';
                field("PDC Received"; Rec."PDC Received")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for post-dated checks received.';
                }
                field("PDC Collection/Return"; Rec."PDC Collection/Return")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for post-dated checks collection or return.';
                }
                field("PDC Issued"; Rec."PDC Issued")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for post-dated checks issued.';
                }
                field("PDC Cleared/Returned"; Rec."PDC Cleared/Returned")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for post-dated checks that have been cleared or returned.';
                }
            }
            part(COASetupLines; "COA Setup List")
            {
                ApplicationArea = All;
                Caption = 'COA Setup Lines';
                SubPageLink = "Primary Key" = field("Primary Key");
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