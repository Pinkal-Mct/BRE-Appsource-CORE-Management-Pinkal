table 73209623 "FinalSettlementRefund"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "FC ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Refund FC ID';
        }
        field(73209576; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Refund Contract ID';
        }
        field(73209577; "Net Refund to the Tenant"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Net Refund to the Tenant';
        }
        field(73209578; "Refund Processed"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Refund Processed';
        }
        field(73209579; "Balance Refundable"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Balance Refundable';
        }
        field(73209580; "Refund Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Pending","Paid";
            Caption = 'Refund Status';
        }
        field(73209581; "Refund Total Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Amount';
        }
        field(73209582; "Refund Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date';
        }
        field(73209583; "Refund Payment mode"; Text[300])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment mode';
            TableRelation = "Payment Type"."Payment Method";
        }
        field(73209584; "Refund Payment Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Scheduled","Due","Overdue","Paid","Cancelled";
            Caption = 'Payment Status';
        }
        field(73209585; "Refund Cheque No."; Text[300])
        {
            DataClassification = AccountData;
            Caption = 'Cheque No.';
        }
        field(73209586; "Payment Receipt/Proof"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Receipt/Proof';
            InitValue = 'View';
        }
        field(73209587; "Pay Receipt/Proof document URL"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Receipt/Proof document URL';
        }
        field(73209588; "Deposit Bank"; Code[100])
        {
            DataClassification = AccountData;
            Caption = 'Deposit Bank';
            TableRelation = "Bank Account";
            trigger OnValidate()
            var
                BankAccountRec: Record "Bank Account";
            begin
                if "Deposit Bank" <> '' then
                    if BankAccountRec.Get("Deposit Bank") then
                        "Deposit Bank" := BankAccountRec."Name";
            end;
        }
        field(73209589; "Tenant ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Refund Tenant ID';
        }
        field(73209590; "Adjust Security Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209591; "Adjust Chiller Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209592; "Adjust other deposit"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "FC ID")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if Rec."Refund Payment Mode" = 'Cheque' then
            if DelChr(Rec."Refund Cheque No.", '=', ' ') = '' then
                Error('Cheque Number cannot be blank when Payment Mode is Cheque.');
    end;
}
