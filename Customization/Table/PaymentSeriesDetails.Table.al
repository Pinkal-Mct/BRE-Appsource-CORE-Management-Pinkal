table 73209650 "BLRPaymentSeriesDetails"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209576; "BLRpayment Series"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Series';
        }
        field(73209577; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
        field(73209578; "BLRDue Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date';
        }

        field(73209579; "BLRPayment Mode"; Text[100])
        {

            TableRelation = "BLRPaymentType"."BLRPayment Method";
            Caption = 'Payment Mode';
            DataClassification = CustomerContent;
        }

        field(73209580; "BLRCheque Number"; Text[100])
        {
            DataClassification = AccountData;
            Caption = 'Cheque Number';
        }
        field(73209581; "BLRDeposite Bank"; Code[100])
        {
            Caption = 'Deposite Bank';
            TableRelation = "Bank Account"."No.";
            DataClassification = CustomerContent;
        }
        field(73209582; "BLRDeposite Status"; Option)
        {
            OptionMembers = "-","N","Y";
            Caption = 'Deposit Status';
            DataClassification = CustomerContent;
        }
        field(73209583; "BLRPayment Status"; Enum "BLRPayment Status")
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Status';
        }
        field(73209584; "BLRCheque Status"; Enum "BLRPDC Status Type Enum")
        {
            DataClassification = AccountData;
            Caption = 'Cheque Status';
        }
        field(73209585; "BLROld Cheque"; Text[100])
        {
            DataClassification = AccountData;
            Caption = 'Old Cheque';
        }
        field(73209586; "BLRView"; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'View';
            InitValue = 'View';
        }
        field(73209587; "BLRView Document URL"; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'View Document URL';
        }

        field(73209588; "BLRApproval Status"; Enum "BLRApproval Status Enum")
        {
            DataClassification = CustomerContent;
        }
        field(73209589; "BLRPayment Transaction Id"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209590; "BLRContract Id"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209591; "BLRTenant Id"; Text[100])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "BLREntry No.")
        {
            Clustered = true;
        }
    }

}
