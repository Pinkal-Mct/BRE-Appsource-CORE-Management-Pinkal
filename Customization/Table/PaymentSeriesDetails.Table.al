table 73209650 "Payment Series Details"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209576; "payment Series"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Series';
        }
        field(73209577; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
        field(73209578; "Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date';
        }

        field(73209579; "Payment Mode"; Text[100])
        {

            TableRelation = "Payment Type"."Payment Method";
            Caption = 'Payment Mode';
            DataClassification = CustomerContent;
        }

        field(73209580; "Cheque Number"; Text[100])
        {
            DataClassification = AccountData;
            Caption = 'Cheque Number';
        }
        field(73209581; "Deposite Bank"; Code[100])
        {
            Caption = 'Deposite Bank';
            TableRelation = "Bank Account"."No.";
            DataClassification = CustomerContent;
        }
        field(73209582; "Deposite Status"; Option)
        {
            OptionMembers = "-","N","Y";
            Caption = 'Deposit Status';
            DataClassification = CustomerContent;
        }
        field(73209583; "Payment Status"; Enum "Payment Status")
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Status';
        }
        field(73209584; "Cheque Status"; Enum "PDC Status Type Enum")
        {
            DataClassification = AccountData;
            Caption = 'Cheque Status';
        }
        field(73209585; "Old Cheque"; Text[100])
        {
            DataClassification = AccountData;
            Caption = 'Old Cheque';
        }
        field(73209586; "View"; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'View';
            InitValue = 'View';
        }
        field(73209587; "View Document URL"; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'View Document URL';
        }

        field(73209588; "Approval Status"; Enum "Approval Status Enum")
        {
            DataClassification = CustomerContent;
        }
        field(73209589; "Payment Transaction Id"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209590; "Contract Id"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209591; "Tenant Id"; Text[100])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

}
