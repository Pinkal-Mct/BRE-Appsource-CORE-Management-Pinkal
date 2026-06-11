tableextension 73209577 "BLRCustomer Ext" extends Customer
{
    fields
    {
        field(73209575; "BLRUsername"; Text[50])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Username';
        }
        field(73209576; "BLRPassword"; Text[30])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Password';
        }
        field(73209577; "BLRDate Of Birth"; Date)
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Date Of Birth';
        }
        field(73209578; "BLRNationality"; Text[50])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Nationality';
        }
        field(73209579; "BLREmirates ID"; Code[25])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Emirates ID Number';
        }
        field(73209580; "BLREmirates ID Expiry Date"; Date)
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Emirates ID Expiry Date';
        }
        field(73209581; "BLRLicense No."; Code[20])
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'Tenant Trade License No.';
        }

        field(73209582; "BLRLicensing Authority"; Text[100])
        {
            Caption = 'Licensing Authority';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(73209583; "BLRCode Area"; Enum "BLRUAE Phone Code Area")
        {
            DataClassification = CustomerContent;
            Caption = 'Code Area';
        }
        field(73209584; "BLROccupation"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Occupation';
        }
        field(73209585; "BLRPassport Number"; Text[20])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Passport Number';
        }
        field(73209586; "BLRPassport Issue Date"; Date)
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Passport Issue Date';
        }
        field(73209587; "BLRPassport Expiry Date"; Date)
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Passport Expiry Date';
        }
        field(73209588; "BLRCountry of Passport"; Text[50])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Country of Passport';
        }
        field(73209589; "BLRApprove"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "BLRApprove" = true then
                    "BLRDecline" := false;
            end;
        }
        field(73209590; "BLRDecline"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "BLRDecline" = true then
                    "BLRApprove" := false;
            end;
        }
        field(73209591; "BLRCustomer Type"; Enum "BLRCustomer Type Enum")
        {
            Caption = 'Customer Type';
            DataClassification = CustomerContent;
        }
        field(73209592; "BLRBusiness Unit"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Business Unit';
        }
        field(73209593; "BLRP.O.Box"; Code[50])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'P.O.Box';
        }
    }

    trigger OnInsert()
    var
        BusinessUnit: Record "Business Unit";
    begin
        if BusinessUnit.Get('PM') then
            "BLRBusiness Unit" := 'PM';
        if BusinessUnit.Get('PS') then
            "BLRBusiness Unit" := 'PS';
    end;
}
