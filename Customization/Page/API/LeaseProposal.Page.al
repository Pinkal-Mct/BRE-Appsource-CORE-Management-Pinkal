namespace PropertyManagement.PropertyManagement;

page 73209596 LeaseProposal
{
    APIGroup = 'tenants';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'leaseProposal';
    DelayedInsert = true;
    EntityName = 'leasecontract';
    EntitySetName = 'leasecontracts';
    ODataKeyFields = SystemId;
    PageType = API;
    DeleteAllowed = true;
    ModifyAllowed = true;
    SourceTable = "BLRLeaseProposalDetails";

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(annualRentAmount; Rec."BLRAnnual Rent Amount")
                {
                    Caption = 'Rent Amount ';
                }
                field(baseUnitOfMeasure; Rec."BLRBase Unit of Measure")
                {
                    Caption = 'Base Unit of Measure';
                }
                field(chillerDepositAmount; Rec."BLRChiller Deposit Amount")
                {
                    Caption = 'Chiller Deposit Amount';
                }
                field(earlyTerminationConditions; Rec."BLREarlyTermCond")
                {
                    Caption = 'Early Termination Conditions';
                }
                field(ejariProcessingFees; Rec."BLREjari Processing Fees")
                {
                    Caption = 'Ejari Processing Fees';
                }
                field(electricityDepositAmount; Rec."BLRElectricity Deposit Amount")
                {
                    Caption = 'Electricity Deposit Amount';
                }
                field(emiratesID; Rec."BLREmirates ID")
                {
                    Caption = 'Emirates ID';
                }
                field(facilitiesAmenities; Rec."BLRFacilities/Amenities")
                {
                    Caption = 'Facilities/Amenities';
                }
                field(insuranceRequirements; Rec."BLRInsurance Requirements")
                {
                    Caption = 'Insurance Requirements';
                }
                field(leaseDuration; Rec."BLRLease Duration")
                {
                    Caption = 'Lease Duration';
                }
                field(leaseEndDate; Rec."BLRLease End Date")
                {
                    Caption = 'Lease End Date';
                }
                field(leaseStartDate; Rec."BLRLease Start Date")
                {
                    Caption = 'Lease Start Date';
                }
                field(legalJurisdiction; Rec."BLRLegal Jurisdiction")
                {
                    Caption = 'Legal Jurisdiction (e.g., Dubai Courts)';
                }
                field(legalRepresentative; Rec."BLRLegal Representative")
                {
                    Caption = 'Legal Representative';
                }
                field(maintenanceResponsibilities; Rec."BLRMaintResp")
                {
                    Caption = 'Maintenance Responsibilities';
                }
                field(mergeUnitID; Rec."BLRMerge Unit ID")
                {
                    Caption = 'Merge Unit ID';
                }
                field(otherFees; Rec."BLROther Fees")
                {
                    Caption = 'Other Fees ';
                }
                field(paymentFrequency; Rec."BLRPayment Frequency")
                {
                    Caption = 'Payment Frequency';
                }
                field(paymentMethod; Rec."BLRPayment Method")
                {
                    Caption = 'Payment Method';
                }
                field(praposalTypeSelected; Rec."BLRPraposal Type Selected")
                {
                    Caption = 'Praposal Type Selected';
                }
                field(propertyID; Rec."BLRProperty ID")
                {
                    Caption = 'Property ID';
                }
                field(propertyName; Rec."BLRProperty Name")
                {
                    Caption = 'Property Name';
                }
                field(proposalID; Rec."BLRProposal ID")
                {
                    Caption = 'Proposal ID';
                }
                field(proposalStatus; Rec."BLRProposal Status")
                {
                    Caption = 'Proposal Status';
                }
                field(refundConditions; Rec."BLRRefund Conditions")
                {
                    Caption = 'Refund Conditions';
                }
                field(renewalAmount; Rec."BLRRenewal Amount")
                {
                    Caption = 'Renewal Amount';
                }
                field(rentAmount; Rec."BLRRent Amount")
                {
                    Caption = 'Annual Rent Amount';
                }
                field(rentEscalationClause; Rec."BLRRent Escalation Clause")
                {
                    Caption = 'Rent Escalation Clause';
                }
                field(reraFees; Rec."BLRRera Fees")
                {
                    Caption = 'Rera Fees';
                }
                field(restrictions; Rec."BLRRestrictions")
                {
                    Caption = 'Restrictions';
                }
                field(securityDepositAmount; Rec."BLRSecurity Deposit Amount")
                {
                    Caption = 'Security Deposit Amount';
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
                field(tenantContactEmail; Rec."BLRTenant Contact Email")
                {
                    Caption = 'Tenant Contact Email';
                }
                field(tenantContactPhone; Rec."BLRTenant Contact Phone")
                {
                    Caption = 'Tenant Contact Phone';
                }
                field(tenantFullName; Rec."BLRTenant Full Name")
                {
                    Caption = 'Tenant Full Name';
                }
                field(tenantID; Rec."BLRTenant ID")
                {
                    Caption = 'Tenant ID';
                }
                field(tradeLicense; Rec."BLRTrade License")
                {
                    Caption = 'Trade License';
                }
                field(unitAddress; Rec."BLRUnit Address")
                {
                    Caption = 'Unit Address';
                }
                field(unitIds; Rec."BLRUnit ID")
                {
                    Caption = 'Single Unit ID';
                }
                field(unitName; Rec."BLRUnit Name")
                {
                    Caption = 'Unit Name';
                }
                field(unitNumber; Rec."BLRUnit Number")
                {
                    Caption = 'Unit Number';
                }
                field(unitSize; Rec."BLRUnit Size")
                {
                    Caption = 'Unit Size';
                }
                field(unitType; Rec."BLRUnit Type")
                {
                    Caption = 'Unit Type';
                }
                field(unitIdm; Rec."BLRUnitID")
                {
                    Caption = 'UnitID';
                }
                field(usageType; Rec."BLRUsage Type")
                {
                    Caption = 'Usage Type';
                }
                field(utilityBillsResponsibility; Rec."BLRUtilityBillsResp")
                {
                    Caption = 'Utility Bills Responsibility';
                }
            }
        }
    }
}
