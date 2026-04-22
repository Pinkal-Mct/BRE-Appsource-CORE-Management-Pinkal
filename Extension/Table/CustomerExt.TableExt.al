tableextension 73209577 "Customer Ext" extends Customer
{
    fields
    {
        field(73209575; "Username"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Username';
        }
        field(73209576; "Password"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Password';
        }
        field(73209577; "Date Of Birth"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date Of Birth';
        }
        field(73209578; "Nationality"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nationality';
        }
        field(73209579; "Emirates ID"; Code[25])
        {
            DataClassification = ToBeClassified;
            Caption = 'Emirates ID Number';
        }
        field(73209580; "Emirates ID Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Emirates ID Expiry Date';
        }
        field(73209581; "License No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Trade License No.';
        }

        field(73209582; "Licensing Authority"; Text[100])
        {
            Caption = 'Licensing Authority';
            DataClassification = ToBeClassified;
        }
        field(73209583; "Code Area"; Enum "UAE Phone Code Area")
        {
            DataClassification = ToBeClassified;
            Caption = 'Code Area';
        }
        field(73209584; "Occupation"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Occupation';
        }
        field(73209585; "Passport Number"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Passport Number';
        }
        field(73209586; "Passport Issue Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Passport Issue Date';
        }
        field(73209587; "Passport Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Passport Expiry Date';
        }
        field(73209588; "Country of Passport"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Country of Passport';
        }
        field(73209589; "Approve"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Approve" = true then
                    "Decline" := false;
            end;
        }
        field(73209590; "Decline"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Decline" = true then
                    "Approve" := false;
            end;
        }
        field(73209591; "Customer Type"; Enum "Customer Type Enum")
        {
            Caption = 'Customer Type';
            DataClassification = ToBeClassified;
        }
        field(73209592; "Business Unit"; Code[20])
        {
            Caption = 'Business Unit';
        }
        field(73209593; "P.O.Box"; Code[50])
        {
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