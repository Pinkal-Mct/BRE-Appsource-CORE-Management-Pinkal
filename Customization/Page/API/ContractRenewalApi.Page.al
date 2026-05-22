page 73209583 "contractRenewalApi"
{
    PageType = API;
    DelayedInsert = true;
    SourceTable = "BLRContractRenewal";
    APIPublisher = 'realestate';
    APIGroup = 'contracts';
    APIVersion = 'v2.0';
    EntityName = 'contractRenewal';    // Singular, PascalCase
    EntitySetName = 'contractRenewals'; // Plural, PascalCase
    Caption = 'Contract Renewal API';
    ODataKeyFields = SystemId;
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(content)
        {
            field("systemId"; Rec.SystemId) // Add SystemId explicitly to the layout
            {
                Caption = 'System Identifier';
            }
            field("id"; Rec."BLRId") { }
            field("ownersName"; Rec."BLROwner's Name") { }
            field("lessorsName"; Rec."BLRLessor's Name") { }
            field("lessorsEmiratesID"; Rec."BLRLessor's Emirates ID") { }
            field("licenseNo"; Rec."BLRLicense No.") { }
            field("licensingAuthority"; Rec."BLRLicensing Authority") { }
            field("lessorsEmail"; Rec."BLRLessor's Email") { }
            field("lessorsPhone"; Rec."BLRLessor's Phone") { }
            field("contractID"; Rec."BLRContract ID") { }
            field("contractStartDate"; Rec."BLRContract Start Date") { }
            field("contractEndDate"; Rec."BLRContract End Date") { }
            field("contractAmount"; Rec."BLRContract Amount") { }
            field("unitID"; Rec."BLRUnit ID") { }
            field("unitName"; Rec."BLRUnit Name") { }
            field("propertyID"; Rec."BLRProperty ID") { }
            field("propertyName"; Rec."BLRProperty Name") { }
            field("renewalContractStatus"; Rec."BLRRenewal Contract Status") { }
            field("tenantFullName"; Rec."BLRTenant Full Name") { }
            field("contractTenor"; Rec."BLRContract Tenor") { }
            field("approvalForRenewal"; Rec."BLRApproval For Renewal") { }
            field("proposalID"; Rec."BLRProposal ID") { }
            field("ejariName"; Rec."BLREjari Name") { }
            field("propertyClassification"; Rec."BLRProperty Classification") { }
            field("propertyType"; Rec."BLRProperty Type") { }
            field("annualRentAmount"; Rec."BLRAnnual Rent Amount") { }
            field("contractDate"; Rec."BLRContract Date") { }
            field("baseUnitOfMeasure"; Rec."BLRBase Unit of Measure") { }
            field("unitSqFeet"; Rec."BLRUnit Sq. Feet") { }
            field("gracePeriod"; Rec."BLRGrace Period") { }
            field("graceStartDate"; Rec."BLRGrace Start Date") { }
            field("graceEndDate"; Rec."BLRGrace End Date") { }
            field("tenantID"; Rec."BLRTenant ID") { }
            field("emiratesID"; Rec."BLREmirates ID") { }
            field("contactNumber"; Rec."BLRContact Number") { }
            field("emailAddress"; Rec."BLREmail Address") { }
            field("paymentFrequency"; Rec."BLRPayment Frequency") { }
            field("paymentMethod"; Rec."BLRPayment Method") { }
            field("createdBy"; Rec."BLRCreated By") { }
            field("mergeUnitID"; Rec."BLRMerge Unit ID") { }
            field("rentAmount"; Rec."BLRRent Amount") { }
            field("tenantLicenseNo"; Rec."BLRTenant_License No.") { }
            field("tenantLicensingAuthority"; Rec."BLRTenant_Licensing Authority") { }
            field("securityDepositAmount"; Rec."BLRSecurity Deposit Amount") { }
            field("unitNumber"; Rec."BLRUnit Number") { }
            field("makaniNumber"; Rec."BLRMakani Number") { }
            field(emirate; Rec."BLREmirate") { }
            field(community; Rec."BLRCommunity") { }
            field("dewaNumber"; Rec."BLRDEWA Number") { }
            field("propertySize"; Rec."BLRProperty Size") { }
            field("noOfInstallments"; Rec."BLRNo of Installments") { }
            field(unitID1; Rec."BLRUnitID") { }
            field(originalContractID; Rec."BLROriginal Contract ID") { }
        }
    }
}
