table 73209708 "Vendor Calculation Details"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "Vendor ID";
    fields
    {
        field(73209575; "Vendor ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor ID';
            Editable = false;
        }
        field(73209576; "Vendor Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Vendor Name';
            Editable = false;
        }
        field(73209577; "Percentage"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Percentage';
        }
        field(73209578; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
        field(73209579; "Calculation Method"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Calculation Method';
            TableRelation = "Calculation Type"."Calculation Type";
        }
        field(73209580; "Percentage Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Percentage Type';
            OptionMembers = " ","Fixed","Variable";
        }
        field(73209581; "Base Amount"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Base Amount Type';
            OptionMembers = " ","Revenue","Collection","Annual Rent","Monthly Rent";
        }
        field(73209582; "Frequency Of Payment"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Frequency Of Payment';
            OptionMembers = " ","Monthly","Quaterly","Half Yearly","Yearly";
        }
        field(73209583; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
            Editable = false;
        }
        field(73209584; "End Date"; Date)
        {
            DataClassification = CustomerContent;
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
