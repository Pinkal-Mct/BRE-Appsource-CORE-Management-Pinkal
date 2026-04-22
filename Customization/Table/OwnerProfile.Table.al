table 73209643 "Owner Profile"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "Owner ID";
    fields
    {
        field(73209575; "Owner ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Owner ID';
            AutoIncrement = true;
            BlankZero = true;
            Editable = false;
        }

        field(73209576; "Full Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Full Name';
        }
        field(73209577; "Nationality"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nationality';
        }
        field(73209578; "Emirates ID"; Code[25])
        {
            DataClassification = ToBeClassified;
            Caption = 'Emirates ID';
        }
        field(73209579; "Phone Number"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Phone Number';
        }
        field(73209580; "Email Address"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Email Address';
        }
        field(73209581; "Mailing Address"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Mailing Address';
        }
        field(73209582; "Local Address in UAE"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Local Address in UAE';
        }
        field(73209583; "Ownership Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Ownership Type';
            OptionMembers = Individual,Corporate,Joint;
        }
        field(73209584; "TRN"; Code[15])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tax Registration Number';
        }
        field(73209585; "Bank Account Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bank Account Number';
        }
        field(73209586; "IBAN"; Code[34])
        {
            DataClassification = ToBeClassified;
            Caption = 'IBAN';
        }
        field(73209587; "Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bank Name';
        }
        field(73209588; "SWIFT/IFSC Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'SWIFT/IFSC Code';
        }
        field(73209589; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
            OptionMembers = Active,Inactive;
        }
        field(73209590; "Date of Registration"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date of Registration';
        }
        field(73209591; "Remarks/Notes"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Remarks/Notes';
        }
        field(73209592; "Ejari Registration Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Ejari Registration Number';
            Tooltip = 'Required for legal tenancy agreements in Dubai';
        }
        field(73209593; "RERA Owner ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'RERA Owner ID';
            Tooltip = 'RERA (Real Estate Regulatory Agency) registration details for property owners';
        }
        field(73209594; "P.O.Box"; Code[50])
        {
            Caption = 'P.O.Box';
        }
    }

    keys
    {
        key(PK; "Owner ID", "Full Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Owner ID", "Full Name")
        {

        }
    }
}
