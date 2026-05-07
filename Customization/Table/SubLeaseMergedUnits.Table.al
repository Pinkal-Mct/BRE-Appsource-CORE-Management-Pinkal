table 73209691 "Sub Lease Merged Units"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "Merge Unit ID"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Merge Unit ID';

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
        field(73209584; "Proposal ID"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(73209585; "Per Day Rent"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(73209586; "Year"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(73209587; "Get Data"; Code[100])
        {
            DataClassification = CustomerContent;
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
