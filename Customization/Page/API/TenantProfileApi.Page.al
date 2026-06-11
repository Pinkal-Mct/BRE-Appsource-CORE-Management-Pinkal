page 73209612 "BLRtenantProfileAPI"
{
    PageType = API;
    DelayedInsert = true;
    SourceTable = Customer;
    APIPublisher = 'realestate';
    APIGroup = 'tenants';
    APIVersion = 'v2.0';
    EntityName = 'tenantProfile';
    EntitySetName = 'tenantProfiles';
    Caption = 'tenantProfileAPI';
    ODataKeyFields = SystemId;
    DeleteAllowed = true;
    ModifyAllowed = true;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            field("systemId"; Rec.SystemId) // Add SystemId explicitly to the layout
            {
                Caption = 'System Identifier';
            }
            field("tenantID"; Rec."No.") { }
            field("fullName"; Rec.Name) { }
            field("username"; Rec."BLRUsername") { }
            field("password"; Rec."BLRPassword") { }
            field("dateOfBirth"; Rec."BLRDate Of Birth") { }
            field("nationality"; Rec."BLRNationality") { }
            field("codeArea"; Rec."BLRCode Area") { }
            field("contactNumber"; rec."Phone No.") { }
            field("emailAddress"; rec."E-Mail") { }
            field("localAddress"; rec.Address) { }
            field("emergencyContact"; rec."Mobile Phone No.") { }
            field("occupation"; rec."BLROccupation") { }
            field("passportNumber"; rec."BLRPassport Number") { }
            field("passportIssueDate"; rec."BLRPassport Issue Date") { }
            field("passportExpiryDate"; rec."BLRPassport Expiry Date") { }
            field("countryofPassport"; rec."BLRCountry of Passport") { }
            field("emiratesID"; rec."BLREmirates ID") { }
            field("emiratesIDExpiryDate"; rec."BLREmirates ID Expiry Date") { }
            field(approve; Rec.BLRApprove) { }
            field(decline; Rec.BLRDecline) { }
        }
    }
}