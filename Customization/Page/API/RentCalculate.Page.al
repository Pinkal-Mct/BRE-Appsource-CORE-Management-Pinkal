namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 73209609 RentCalculate
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'rentCalculate';
    DelayedInsert = true;
    EntityName = 'rentcalculatesub';
    EntitySetName = 'rentcalculatesubs';
    PageType = API;
    SourceTable = "BLRRentCalculateSub";
    ODataKeyFields = SystemId;
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(contractID; Rec."BLRContract ID")
                {
                    Caption = 'Contract ID';
                }
                field(entryNo; Rec."BLREntry No.")
                {
                    Caption = 'Entry No.';
                }
                field(finalAnnualAmount; Rec."BLRFinal Annual Amount")
                {
                    Caption = 'Final Annual Amount';
                }
                field(numberOfDays; Rec."BLRNumber of Days")
                {
                    Caption = 'Number of Days';
                }
                field(perDayRent; Rec."BLRPer Day Rent")
                {
                    Caption = 'Per Day Rent';
                }
                field(periodEndDate; Rec."BLRPeriod End Date")
                {
                    Caption = 'End Date';
                }
                field(periodStartDate; Rec."BLRPeriod Start Date")
                {
                    Caption = 'Start Date';
                }
                field(rcID; Rec."BLRRC ID")
                {
                    Caption = 'RC ID';
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
                field(tenantId; Rec."BLRTenant Id")
                {
                    Caption = 'Tenant ID';
                }
                field(totalFinalAnnualAmount; Rec."BLRTotal Final Annual Amount")
                {
                    Caption = 'Total Final Annual Amount';
                }
                field(totalNumberOfDays; Rec."BLRTotal Number of Days")
                {
                    Caption = 'Total Number of Days';
                }
                field(year; Rec."BLRYear")
                {
                    Caption = 'Year';
                }
            }
        }
    }
}
