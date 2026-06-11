namespace PropertyManagement.PropertyManagement;

page 73209580 BLRCompanyData
{
    APIGroup = 'tenants';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'companyData';
    DelayedInsert = true;
    EntityName = 'companyData';
    EntitySetName = 'companyDatas';
    PageType = API;
    SourceTable = "BLRCompanyData";
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(companyID; Rec."BLRCompany ID")
                {
                    Caption = 'Company ID';
                }
                field(companyLogo; Rec."BLRCompany Logo")
                {
                    Caption = 'Company Logo';
                }
                field("logoURL"; Rec."BLRLogo URL")
                {
                    Caption = 'Company Logo';
                }
                field(companyName; Rec."BLRCompany Name")
                {
                    Caption = 'Company Name';
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
                field("tenantid"; Rec."BLRTenant id")
                {
                    Caption = 'Tenant id';
                }
                field("environmentName"; Rec."BLREnvironment Name")
                {
                    Caption = 'Environment Name';
                }
                field("accessValidity"; Rec."BLRAccess Validity")
                {
                    Caption = 'Access Validity';
                }
                field("apiURL"; Rec."BLRAPI URL")
                {
                    Caption = 'API URL';
                }
            }
        }
    }
}
