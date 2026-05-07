tableextension 73209577 "Customer Ext" extends Customer
{
    fields
    {
        field(73209575; "Username"; Text[50])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Username';
        }
        field(73209576; "Password"; Text[30])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Password';
        }
        field(73209577; "Date Of Birth"; Date)
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Date Of Birth';
        }
        field(73209578; "Nationality"; Text[50])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Nationality';
        }
        field(73209579; "Emirates ID"; Code[25])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Emirates ID Number';
        }
        field(73209580; "Emirates ID Expiry Date"; Date)
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Emirates ID Expiry Date';
        }
        field(73209581; "License No."; Code[20])
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'Tenant Trade License No.';
        }

        field(73209582; "Licensing Authority"; Text[100])
        {
            Caption = 'Licensing Authority';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(73209583; "Code Area"; Enum "UAE Phone Code Area")
        {
            DataClassification = CustomerContent;
            Caption = 'Code Area';
        }
        field(73209584; "Occupation"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Occupation';
        }
        field(73209585; "Passport Number"; Text[20])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Passport Number';
        }
        field(73209586; "Passport Issue Date"; Date)
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Passport Issue Date';
        }
        field(73209587; "Passport Expiry Date"; Date)
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Passport Expiry Date';
        }
        field(73209588; "Country of Passport"; Text[50])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Country of Passport';
        }
        field(73209589; "Approve"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Approve" = true then
                    "Decline" := false;
            end;
        }
        field(73209590; "Decline"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Decline" = true then
                    "Approve" := false;
            end;
        }
        field(73209591; "Customer Type"; Enum "Customer Type Enum")
        {
            Caption = 'Customer Type';
            DataClassification = CustomerContent;
        }
        field(73209592; "Business Unit"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Business Unit';
        }
        field(73209593; "P.O.Box"; Code[50])
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
            "Business Unit" := 'PM';
        if BusinessUnit.Get('PS') then
            "Business Unit" := 'PS';
    end;
}
