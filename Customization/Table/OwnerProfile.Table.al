table 73209643 "BLROwnerProfile"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "BLROwner ID";
    fields
    {
        field(73209575; "BLROwner ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Owner ID';
            AutoIncrement = true;
            BlankZero = true;
            Editable = false;
        }

        field(73209576; "BLRFull Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Full Name';
        }
        field(73209577; "BLRNationality"; Text[50])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Nationality';
        }
        field(73209578; "BLREmirates ID"; Code[25])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Emirates ID';
        }
        field(73209579; "BLRPhone Number"; Text[30])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Phone Number';
        }
        field(73209580; "BLREmail Address"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Email Address';
        }
        field(73209581; "BLRMailing Address"; Text[250])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Mailing Address';
        }
        field(73209582; "BLRLocal Address in UAE"; Text[250])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Local Address in UAE';
        }
        field(73209583; "BLROwnership Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Ownership Type';
            OptionMembers = Individual,Corporate,Joint;
        }
        field(73209584; "BLRTRN"; Code[15])
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'Tax Registration Number';
        }
        field(73209585; "BLRBank Account Number"; Code[20])
        {
            DataClassification = AccountData;
            Caption = 'Bank Account Number';
        }
        field(73209586; "BLRIBAN"; Code[34])
        {
            DataClassification = AccountData;
            Caption = 'IBAN';
        }
        field(73209587; "BLRBank Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank Name';
        }
        field(73209588; "BLRSWIFT/IFSC Code"; Code[20])
        {
            DataClassification = AccountData;
            Caption = 'SWIFT/IFSC Code';
        }
        field(73209589; "BLRStatus"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionMembers = Active,Inactive;
        }
        field(73209590; "BLRDate of Registration"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date of Registration';
        }
        field(73209591; "BLRRemarks/Notes"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Remarks/Notes';
        }
        field(73209592; "BLREjari Registration Number"; Code[20])
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'Ejari Registration Number';
            Tooltip = 'Required for legal tenancy agreements in Dubai';
        }
        field(73209593; "BLRRERA Owner ID"; Code[20])
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'RERA Owner ID';
            Tooltip = 'RERA (Real Estate Regulatory Agency) registration details for property owners';
        }
        field(73209594; "BLRP.O.Box"; Code[50])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'P.O.Box';
        }
    }

    keys
    {
        key(PK;"BLROwner ID", "BLRFull Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"BLROwner ID", "BLRFull Name")
        {

        }
    }
}
