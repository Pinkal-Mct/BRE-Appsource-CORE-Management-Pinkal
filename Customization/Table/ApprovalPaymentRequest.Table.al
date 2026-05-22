table 73209580 "BLRApprovalPaymentRequest"
{
    DataClassification = CustomerContent;
    DataCaptionFields = SystemId, "BLRID";
    fields
    {
        field(73209575; "BLRID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            Editable = false;
            AutoIncrement = true;
        }
        field(73209576; "BLRManual/Auto Status"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Manual/Auto Status';
        }
        field(73209577; "BLRStatus"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
        }
        field(73209578; "BLRRequest Type"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Request Type';
        }
        field(73209579; "BLRTenant ID"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
        }
        field(73209580; "BLRProposal ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Proposal ID';
        }
        field(73209581; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209582; "BLRPayment Series"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Series';
        }
        field(73209583; "BLRChange Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'New Amount Including VAT';
        }
        field(73209584; "BLRchange Payment series"; Text[300])
        {
            DataClassification = CustomerContent;
            Caption = 'changed Payment series';
        }
        field(73209585; "BLRPayment mode"; Text[300])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment mode';
        }
        field(73209586; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'New Amount';
        }
        field(73209587; "BLRVat Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'New Vat Amount';
        }
        field(73209588; "BLRDue Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'New Due Date';
        }
        Field(73209589; "BLRDescription"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
            Editable = true;
        }
        field(73209590; "BLRItems"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Items';
        }
        field(73209591; "BLRPayment mode ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Payment mode ID';
        }
        field(73209592; "BLRC_Cheque_Number"; Text[20])
        {
            DataClassification = AccountData;
            Caption = 'Cheque Number';
        }
        field(73209593; "BLRC_Deposit_Bank"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Deposit Bank';
            TableRelation = "Bank Account";
        }
        field(73209594; "BLROld Cheque"; Text[20])
        {
            DataClassification = AccountData;
        }
        field(73209595; "BLRTransaction Date"; Date)
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PrimaryKey;"BLRID")
        {
            Clustered = false;
        }
        key(PK;SystemId)
        {
            Clustered = true;
        }
    }
}
