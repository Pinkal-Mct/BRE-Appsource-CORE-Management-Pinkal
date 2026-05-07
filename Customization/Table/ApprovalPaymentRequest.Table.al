table 73209580 "Approval Payment Request"
{
    DataClassification = CustomerContent;
    DataCaptionFields = SystemId, "ID";
    fields
    {
        field(73209575; "ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            Editable = false;
            AutoIncrement = true;
        }
        field(73209576; "Manual/Auto Status"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Manual/Auto Status';
        }
        field(73209577; "Status"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
        }
        field(73209578; "Request Type"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Request Type';
        }
        field(73209579; "Tenant ID"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
        }
        field(73209580; "Proposal ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Proposal ID';
        }
        field(73209581; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209582; "Payment Series"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Series';
        }
        field(73209583; "Change Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'New Amount Including VAT';
        }
        field(73209584; "change Payment series"; Text[300])
        {
            DataClassification = CustomerContent;
            Caption = 'changed Payment series';
        }
        field(73209585; "Payment mode"; Text[300])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment mode';
        }
        field(73209586; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'New Amount';
        }
        field(73209587; "Vat Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'New Vat Amount';
        }
        field(73209588; "Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'New Due Date';
        }
        Field(73209589; "Description"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
            Editable = true;
        }
        field(73209590; "Items"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Items';
        }
        field(73209591; "Payment mode ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Payment mode ID';
        }
        field(73209592; "C_Cheque_Number"; Text[20])
        {
            DataClassification = AccountData;
            Caption = 'Cheque Number';
        }
        field(73209593; "C_Deposit_Bank"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Deposit Bank';
            TableRelation = "Bank Account";
        }
        field(73209594; "Old Cheque"; Text[20])
        {
            DataClassification = AccountData;
        }
        field(73209595; "Transaction Date"; Date)
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PrimaryKey; "ID")
        {
            Clustered = false;
        }
        key(PK; SystemId)
        {
            Clustered = true;
        }
    }
}
