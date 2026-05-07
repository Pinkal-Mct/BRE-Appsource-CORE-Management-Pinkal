table 73209692 "Sub Merged Units"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "Merged Unit ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Merged Unit ID';

        }
        field(73209576; "Property ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Property ID';
        }
        field(73209577; "Unit ID"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit ID';

        }
        field(73209578; "Unit Name"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Name';

        }
        field(73209579; "Unit Size"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Unit Size';
        }

        field(73209580; "Market Rate per Square"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Market Rate per Square';
        }

        field(73209581; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Amount';
        }

        field(73209582; "Base Unit of Measure"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Base Unit of Measure';

        }

        field(73209583; "Single Unit Name"; Text[500])
        {
            DataClassification = CustomerContent;
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
