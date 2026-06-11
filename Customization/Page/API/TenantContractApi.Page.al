page 73209611 "BLRtenantContractApi"
{
    PageType = API;
    DelayedInsert = true;
    SourceTable = "BLRTenancyContract";
    APIPublisher = 'realestate';
    APIGroup = 'tenants';
    APIVersion = 'v2.0';
    EntityName = 'tenantContract';
    EntitySetName = 'tenantContracts';
    Caption = 'Tenant Contract API';
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
            field("contractID"; Rec."BLRContract ID") { }
            field("proposalID"; Rec."BLRProposal ID") { }
            field("propertyName"; Rec."BLRProperty Name") { }
            field("unitName1"; Rec."BLRUnit Name") { }
            field("ejariName"; Rec."BLREjari Name") { }
            field("propertyClassification"; Rec."BLRProperty Classification") { }
            field("propertyType"; Rec."BLRProperty Type") { }
            field("annualRentAmount"; rec."BLRAnnual Rent Amount") { }
            field("contractDate"; rec."BLRContract Date") { }
            field("contractStartDate"; rec."BLRContract Start Date") { }
            field("contractEndDate"; rec."BLRContract End Date") { }
            field("contractTenor"; rec."BLRContract Tenor") { }
            field("baseUnitofMeasure"; rec."BLRBase Unit of Measure") { }
            field("unitSqFeet"; rec."BLRUnit Sq. Feet") { }
            field("gracePeriod"; rec."BLRGrace Period") { }
            field("graceStartDate"; rec."BLRGrace Start Date") { }
            field("graceEndDate"; rec."BLRGrace End Date") { }
            field("tenantID"; rec."BLRTenant ID") { }
            field("propertyID"; rec."BLRProperty ID") { }
            field("unitID"; rec."BLRUnit ID") { }
            field("emiratesID"; rec."BLREmirates ID") { }
            field("contactNumber"; rec."BLRContact Number") { }
            field("emailAddress"; rec."BLREmail Address") { }
            field("paymentFrequency"; rec."BLRPayment Frequency") { }
            field("paymentMethod"; rec."BLRPayment Method") { }
            field("tenantContractStatus"; rec."BLRTenant Contract Status") { }
            field("unitIDD"; rec."BLRUnitID") { }
            field("handoverisCompleted"; rec."BLRHandover is Completed") { }
            field("mergeUnitID"; rec."BLRMerge Unit ID") { }
            field("rentAmount"; rec."BLRRent Amount") { }
            field("updateContractStatus"; rec."BLRUpdate Contract Status") { }
            field("createdBy"; rec."BLRCreated By") { }
            field("ownersName"; Rec."BLROwner's Name") { }
            field("lessorsName"; Rec."BLRLessor's Name") { }
            field("lessorsEmiratesID"; Rec."BLRLessor's Emirates ID") { }
            field("licenseNo"; Rec."BLRLicense No.") { }
            field("licensingAuthority"; Rec."BLRLicensing Authority") { }
            field("lessorsEmail"; Rec."BLRLessor's Email") { }
            field("lessorsPhone"; Rec."BLRLessor's Phone") { }
            field("unitName"; Rec."BLRUnit Name") { }
            field("tenantLicenseNo"; Rec."BLRTenant_License No.") { }
            field("tenantLicensingAuthority"; Rec."BLRTenant_Licensing Authority") { }
            field("securityDepositAmount"; Rec."BLRSecurity Deposit Amount") { }
            field("unitNumber"; Rec."BLRUnit Number") { }
            field("makaniNumber"; Rec."BLRMakani Number") { }
            field(emirate; Rec."BLREmirate") { }
            field(community; Rec."BLRCommunity") { }
            field("dEWANumber"; Rec."BLRDEWA Number") { }
            field("propertySize"; Rec."BLRProperty Size") { }
            field(id; Rec."BLRID") { }
            field("suspendedReasonlist"; Rec."BLRSuspended Reason list") { }
            field("noofInstallments"; Rec."BLRNo of Installments") { }
            field("tenantName"; Rec."BLRCustomer Name") { }
            field("uploadDocument"; Rec."BLRUpload Document") { }
            field("viewDocument"; Rec."BLRview Document") { }
            field("renewalContractStatus"; Rec."BLRRenewal Contract Status") { }
            field("yesOrNo"; Rec."BLRYes/No") { }

            field("renewalNotificationtoTenant"; rec."BLRRenewalNotiftoTenant")
            {
                Caption = 'Renewal Notification to Tenant';
            }

            field("tenantLoyaltyCheckReminder"; rec."BLRTenantLoyaltyCheckReminder")
            {

                Caption = 'Tenant Loyalty Check Reminder';
            }

            field("paymentReminder"; rec."BLRPayment Reminder")
            {
                Caption = 'Payment Reminder';
            }
            field("previousStatus"; Rec."BLRPrevious Status")
            {
                Caption = 'Previous Status';
            }




        }
    }
}