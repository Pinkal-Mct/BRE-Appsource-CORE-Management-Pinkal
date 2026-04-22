table 73209708 "Vendor Calculation Details"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "Vendor ID";
    fields
    {
        field(73209575; "Vendor ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor ID';
            Editable = false;
        }
        field(73209576; "Vendor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Name';
            Editable = false;
        }
        field(73209577; "Percentage"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Percentage';
        }
        field(73209578; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
        }
        field(73209579; "Calculation Method"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Calculation Method';
            TableRelation = "Calculation Type"."Calculation Type";
        }
        field(73209580; "Percentage Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Percentage Type';
            OptionMembers = " ","Fixed","Variable";
        }
        field(73209581; "Base Amount"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Base Amount Type';
            OptionMembers = " ","Revenue","Collection","Annual Rent","Monthly Rent";
        }
        field(73209582; "Frequency Of Payment"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Frequency Of Payment';
            OptionMembers = " ","Monthly","Quaterly","Half Yearly","Yearly";
        }
        field(73209583; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';
            Editable = false;
        }
        field(73209584; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Vendor ID")
        {
            Clustered = true;
        }
    }
}
