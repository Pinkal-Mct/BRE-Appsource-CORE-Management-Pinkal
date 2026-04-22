table 73209580 "Approval Payment Request"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = SystemId, "ID";
    fields
    {
        field(73209575; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
            Editable = false;
            AutoIncrement = true;
        }
        field(73209576; "Manual/Auto Status"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Manual/Auto Status';
        }
        field(73209577; "Status"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
        }
        field(73209578; "Request Type"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Request Type';
        }
        field(73209579; "Tenant ID"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
        }
        field(73209580; "Proposal ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Proposal ID';
        }
        field(73209581; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(73209582; "Payment Series"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Series';
        }
        field(73209583; "Change Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'New Amount Including VAT';
        }
        field(73209584; "change Payment series"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'changed Payment series';
        }
        field(73209585; "Payment mode"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment mode';
        }
        field(73209586; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'New Amount';
        }
        field(73209587; "Vat Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'New Vat Amount';
        }
        field(73209588; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'New Due Date';
        }
        Field(73209589; "Description"; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
            Editable = true;
        }
        field(73209590; "Items"; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Items';
        }
        field(73209591; "Payment mode ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment mode ID';
        }
        field(73209592; "C_Cheque_Number"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cheque Number';
        }
        field(73209593; "C_Deposit_Bank"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Deposit Bank';
            TableRelation = "Bank Account";
        }
        field(73209594; "Old Cheque"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(73209595; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
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
