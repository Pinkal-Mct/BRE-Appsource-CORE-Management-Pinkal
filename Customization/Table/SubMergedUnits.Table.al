table 73209692 "Sub Merged Units"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(73209575; "Merged Unit ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Merged Unit ID';

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
    }

    keys
    {
        key(PK; "Merged Unit ID", "Unit ID")
        {
            Clustered = true;
        }
    }






}