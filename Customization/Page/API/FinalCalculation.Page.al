namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 73209588 "BLRFinal Calculation"
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'finalCalculation';
    DelayedInsert = true;
    EntityName = 'finalcalculation';
    EntitySetName = 'finalcalculations';
    PageType = API;
    SourceTable = "BLRFinalCalculation";
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
                field(adjustmentSecurityDeposit; Rec."BLRAdjustment Security Deposit")
                {
                    Caption = 'Adjustment Security Deposit';
                }
                field(amountRefundable; Rec."BLRAmount Refundable")
                {
                    Caption = 'Amount Refundable To The Tenant';
                }
                field(annualRentAmountTermiYear; Rec."BLRAnnualRentAmtTermiYear")
                {
                    Caption = 'Annual Rent Amount of Termination Year';
                }
                field(chillerDeposit; Rec."BLRChiller Deposit")
                {
                    Caption = 'Chiller Deposit';
                }
                field(contractAmount; Rec."BLRContract Amount")
                {
                    Caption = 'Contract Amount';
                }
                field(contractEndDate; Rec."BLRContract End Date")
                {
                    Caption = 'Contract End Date';
                }
                field(contractID; Rec."BLRContract ID")
                {
                    Caption = 'Contract ID';
                }
                field(contractStartDate; Rec."BLRContract Start Date")
                {
                    Caption = 'Contract Start Date';
                }
                field(contractYearTerminationDate; Rec."BLRContYearTermDate")
                {
                    Caption = 'Contract Year On Termination Date';
                }
                field(fcID; Rec."BLRFC ID")
                {
                    Caption = 'FC ID';
                }
                field(intimationDate; Rec."BLRIntimation Date")
                {
                    Caption = 'Intimation Date';
                }
                field(netBalance; Rec."BLRNet Balance")
                {
                    Caption = 'Net Balance';
                }
                field(netReceivableFromTheTenant; Rec."BLRNetRecvFromTheTenant")
                {
                    Caption = 'Net Receivable From The Tenant';
                }
                field(originalContractTenure; Rec."BLROriginal Contract Tenure")
                {
                    Caption = 'Original Contract Tenure';
                }
                field(otherDeposit; Rec."BLROther Deposit")
                {
                    Caption = 'Other Deposit';
                }
                field(perDayRent; Rec."BLRPer Day Rent")
                {
                    Caption = 'Per Day Rent(Termination Year)';
                }
                field(securityDeposit; Rec."BLRSecurity Deposit")
                {
                    Caption = 'Security Deposit';
                }
                field(status; Rec."BLRStatus")
                {
                    Caption = 'Status';
                }
                field(summeryNetBalance; Rec."BLRSummery Net Balance")
                {
                    Caption = 'Net Balance';
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
                field(tenantID; Rec."BLRTenant ID")
                {
                    Caption = 'Tenant ID';
                }
                field(terminationDate; Rec."BLRTermination Date")
                {
                    Caption = 'Termination Date';
                }
                field(totalClaim; Rec."BLRTotal Claim")
                {
                    Caption = 'Total Claim';
                }
                field(totalNoOfDays; Rec."BLRTotal No. Of Days")
                {
                    Caption = 'Total No. Of Days(Termination Year)';
                }
                field(totalRefund; Rec."BLRTotal Refund")
                {
                    Caption = 'Total Refund';
                }
                field(totalRefundableDeposit; Rec."BLRTotal Refundable Deposit")
                {
                    Caption = 'Total Refundable Deposit';
                }
                field(unitType; Rec."BLRUnit Type")
                {
                    Caption = 'Unit Type';
                }
                field("finalCalculationDocument"; Rec."BLRFinal Calculation Document")
                {
                    Caption = 'Unit Type';
                }
                field("terminationStatus"; Rec."BLRTermination Status")
                {
                    Caption = 'Termination Status';
                }
                field("finalCalculationURL"; Rec."BLRFinal Calculation URL")
                {
                    Caption = 'Final Calculation URL';
                }
                field("creditNoteDocument"; Rec."BLRCredit Note Document")
                {
                    Caption = 'Credit Note Document';
                }
                field("creditNoteURL"; Rec."BLRCredit Note URL")
                {
                    Caption = 'Credit Note URL';
                }
                field("updatedPayments"; Rec."BLRUpdated Payments")
                {
                    Caption = 'Updated Payments';
                }
                field("finalPayments"; Rec."BLRFinal Payments")
                {
                    Caption = 'Final Payments';
                }
            }
        }
    }
}
