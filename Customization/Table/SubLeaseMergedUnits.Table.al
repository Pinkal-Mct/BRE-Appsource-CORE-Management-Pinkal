table 73209691 "Sub Lease Merged Units"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(73209575; "Merge Unit ID"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Merge Unit ID';

        }
        field(73209576; "Property ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property ID';
        }
        field(73209577; "Unit ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit ID';

        }
        field(73209578; "Unit Name"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Name';

        }

        field(73209579; "Unit Size"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Unit Size';
        }

        field(73209580; "Market Rate per Square"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Market Rate per Square';
        }

        field(73209581; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Amount';
        }

        field(73209582; "Base Unit of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Base Unit of Measure';

        }

        field(73209583; "Single Unit Name"; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Single Unit Names';
        }
        field(73209584; "Proposal ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(73209585; "Per Day Rent"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(73209586; "Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(73209587; "Get Data"; Code[100])
        {
            DataClassification = ToBeClassified;
            InitValue = 'Click Here For Get Data.';
            Caption = 'Click Here For Get Data.';


        }
    }

    keys
    {
        key(PK; "Merge Unit ID", "Unit ID", "Proposal ID")
        {
            Clustered = true;
        }
    }

}