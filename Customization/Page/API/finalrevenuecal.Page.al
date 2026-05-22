namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 73209592 finalrevenuecal
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'finalrevenuecal';
    DelayedInsert = true;
    EntityName = 'finalrevenuecalculationgrid';
    EntitySetName = 'finalrevenuecalculationgrids';
    PageType = API;
    SourceTable = "BLRFinalRevenueCalculationGrid";
    ODataKeyFields = SystemId;
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(actualContractTenure; Rec."BLRActual Contract Tenure")
                {
                    Caption = 'Actual Contract Tenure';
                }
                field(annualRentAmountTermiYear; Rec."BLRAnnualRentAmtTermiYear")
                {
                    Caption = 'Annual Rent Amount of Termination Year';
                }
                field(contractID; Rec."BLRContract ID")
                {
                    Caption = 'Contract ID';
                }
                field(contractYearTerminationDate; Rec."BLRContYearTermDate")
                {
                    Caption = 'Contract Year On Termination Date';
                }
                field(differenceAmount; Rec."BLRDifference Amount")
                {
                    Caption = 'Difference Amount';
                }
                field(differenceAmountIncl; Rec."BLRDifference Amount Incl.")
                {
                    Caption = 'Difference Amount Incl.';
                }
                field(differenceVAT; Rec."BLRDifference VAT")
                {
                    Caption = 'Difference VAT';
                }
                field(entryNo; Rec."BLREntry No.")
                {
                    Caption = 'Entry No.';
                }
                field(originalAmount; Rec."BLROriginal Amount")
                {
                    Caption = 'Amount';
                }
                field(originalAmountIncl; Rec."BLROriginal Amount Incl.")
                {
                    Caption = 'Amount incl.';
                }
                field(originalVAT; Rec."BLROriginal VAT")
                {
                    Caption = 'VAT';
                }
                field(perDayRent; Rec."BLRPer Day Rent")
                {
                    Caption = 'Per Day Rent';
                }
                field(revenueDescription; Rec."BLRRevenue Description")
                {
                    Caption = 'Revenue Description';
                }
                field(revisedAmount; Rec."BLRRevised Amount")
                {
                    Caption = 'Revised Amount';
                }
                field(revisedAmountIncl; Rec."BLRRevised Amount Incl.")
                {
                    Caption = 'Revised Amount Incl.';
                }
                field(revisedVAT; Rec."BLRRevised VAT")
                {
                    Caption = 'Revised VAT';
                }
                field(revisedVAT1; Rec."BLRRevised VAT %")
                {
                    Caption = 'Revised VAT %';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
                field(totalDifferenceAmount; Rec."BLRTotal Difference Amount")
                {
                    Caption = 'Total Difference Amount';
                }
                field(totalDifferenceVAT; Rec."BLRTotal Difference VAT")
                {
                    Caption = 'Total Difference VAT';
                }
                field(totalDifferenceAmountInclVAT; Rec."BLRTotalDiffAmtInclVAT")
                {
                    Caption = 'Total Difference Amount Incl. VAT"';
                }
                field(totalNoOfDays; Rec."BLRTotal No. Of Days")
                {
                    Caption = 'Total No. Of Days(Termination Year)';
                }
                field(totalOrgininalAmountInclVAT; Rec."BLRTotalOrigAmtInclVAT")
                {
                    Caption = 'Total Orgininal Amount Incl. VAT';
                }
                field(totalOriginalAmount; Rec."BLRTotal Original Amount")
                {
                    Caption = 'Total Original Amount';
                }
                field(totalOriginalVAT; Rec."BLRTotal Original VAT")
                {
                    Caption = 'Total Original VAT';
                }
                field(totalRevisedAmount; Rec."BLRTotal Revised Amount")
                {
                    Caption = 'Total Revised Amount';
                }
                field(totalRevisedAmountInclVAT; Rec."BLRTotalRevAmtInclVAT")
                {
                    Caption = 'Total Revised Amount Incl. VAT';
                }
                field(totalRevisedVAT; Rec."BLRTotal Revised VAT")
                {
                    Caption = 'Total Revised VAT';
                }
            }
        }
    }
}
