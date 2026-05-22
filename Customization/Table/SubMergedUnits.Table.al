table 73209692 "BLRSubMergedUnits"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "BLRMerged Unit ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Merged Unit ID';

        }
        field(73209576; "BLRProperty ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Property ID';
        }
        field(73209577; "BLRUnit ID"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit ID';

        }
        field(73209578; "BLRUnit Name"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Name';

        }
        field(73209579; "BLRUnit Size"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Unit Size';
        }

        field(73209580; "BLRMarket Rate per Square"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Market Rate per Square';
        }

        field(73209581; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Amount';
        }

        field(73209582; "BLRBase Unit of Measure"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Base Unit of Measure';

        }

        field(73209583; "BLRSingle Unit Name"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Single Unit Names';
        }
    }

    keys
    {
        key(PK;"BLRMerged Unit ID", "BLRUnit ID")
        {
            Clustered = true;
        }
    }






}
