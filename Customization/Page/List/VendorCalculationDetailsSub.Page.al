page 73209665 "BLRVendorCalculationDetailsSub"
{
    PageType = ListPart;
    SourceTable = "BLRVendorCalculationDetails";
    ApplicationArea = All;
    Caption = 'Vendor Calculation Details';
    layout
    {
        area(content)
        {
            repeater("Calculation Details")
            {
                field("Vendor ID"; Rec."BLRVendor ID")
                {
                    ToolTip = 'The unique identifier for the vendor associated with the calculation.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Vendor Name"; Rec."BLRVendor Name")
                {
                    ToolTip = 'The name of the vendor associated with the calculation.';
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."BLRStart Date")
                {
                    ToolTip = 'The start date of the calculation period for the vendor.';
                    ApplicationArea = All;
                }
                field("End Date"; Rec."BLREnd Date")
                {
                    ToolTip = 'The end date of the calculation period for the vendor.';
                    ApplicationArea = All;
                }
                field("Calculation Method"; Rec."BLRCalculation Method")
                {
                    ToolTip = 'The method used for calculating the vendor payment.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        UpdateFieldEditability();
                    end;
                }
                field("Base Amount"; Rec."BLRBase Amount")
                {
                    ToolTip = 'The base amount used for the vendor calculation.';
                    ApplicationArea = All;
                }
                field("Percentage Type"; Rec."BLRPercentage Type")
                {
                    ToolTip = 'The type of percentage used in the vendor calculation.';
                    ApplicationArea = All;
                    Editable = IsPercentageTypeEditable;
                }
                field("Percentage"; Rec."BLRPercentage")
                {
                    ToolTip = 'The percentage value used in the vendor calculation.';
                    ApplicationArea = All;
                    Editable = IsPercentageEditable;
                }
                field("Amount"; Rec."BLRAmount")
                {
                    ToolTip = 'The calculated amount for the vendor based on the calculation method.';
                    ApplicationArea = All;
                    Editable = IsAmountEditable;
                }
                field("Frequency Of Payment"; Rec."BLRFrequency Of Payment")
                {
                    ToolTip = 'The frequency at which the vendor is paid.';
                    ApplicationArea = All;
                }
            }
        }
    }
    procedure SetVendorID(pVendorID: Code[20])
    begin
        VendorID := pVendorID;
    end;

    procedure SetStartEndDate(pStartDate: Date; pEndDate: Date; pvendorname: Text[100])
    begin
        startDate := pStartDate;
        endDate := pEndDate;
        vendorName := pvendorname;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."BLRVendor ID" := VendorID;
        Rec."BLRStart Date" := startDate;
        Rec."BLREnd Date" := endDate;
        Rec."BLRVendor Name" := vendorName;
    end;

    var
        VendorID: Code[20];
        startDate: Date;
        endDate: Date;
        vendorName: Text[100];
        IsAmountEditable: Boolean;
        IsPercentageEditable: Boolean;
        IsPercentageTypeEditable: Boolean;

    procedure UpdateFieldEditability()
    begin
        case UpperCase(Rec."BLRCalculation Method") of
            '':
                begin
                    IsAmountEditable := false;
                    IsPercentageEditable := false;
                    IsPercentageTypeEditable := false;
                end;
            'FIXED AMOUNT':
                begin
                    IsAmountEditable := true;
                    IsPercentageEditable := false;
                    IsPercentageTypeEditable := false;
                end;
            'PERCENTAGE BASED':
                begin
                    IsAmountEditable := false;
                    IsPercentageEditable := true;
                    IsPercentageTypeEditable := true;
                end;
            else begin
                IsAmountEditable := false;
                IsPercentageEditable := true;
                IsPercentageTypeEditable := true;
            end;
        end;
    end;
}
