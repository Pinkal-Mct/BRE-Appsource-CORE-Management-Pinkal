table 73209623 "BLRFinalSettlementRefund"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLRFC ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Refund FC ID';
        }
        field(73209576; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Refund Contract ID';
        }
        field(73209577; "BLRNet Refund to the Tenant"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Net Refund to the Tenant';
        }
        field(73209578; "BLRRefund Processed"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Refund Processed';
        }
        field(73209579; "BLRBalance Refundable"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Balance Refundable';
        }
        field(73209580; "BLRRefund Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Pending","Paid";
            Caption = 'Refund Status';
        }
        field(73209581; "BLRRefund Total Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Amount';
        }
        field(73209582; "BLRRefund Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date';
        }
        field(73209583; "BLRRefund Payment mode"; Text[300])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment mode';
            TableRelation = "BLRPaymentType"."BLRPayment Method";
        }
        field(73209584; "BLRRefund Payment Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Scheduled","Due","Overdue","Paid","Cancelled";
            Caption = 'Payment Status';
        }
        field(73209585; "BLRRefund Cheque No."; Text[300])
        {
            DataClassification = AccountData;
            Caption = 'Cheque No.';
        }
        field(73209586; "BLRPayment Receipt/Proof"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Receipt/Proof';
            InitValue = 'View';
        }
        field(73209587; "BLRPayRcptProofDocURL"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Receipt/Proof document URL';
        }
        field(73209588; "BLRDeposit Bank"; Code[100])
        {
            DataClassification = AccountData;
            Caption = 'Deposit Bank';
            TableRelation = "Bank Account";
            trigger OnValidate()
            var
                BankAccountRec: Record "Bank Account";
            begin
                if "BLRDeposit Bank" <> '' then
                    if BankAccountRec.Get("BLRDeposit Bank") then
                        "BLRDeposit Bank" := BankAccountRec."Name";
            end;
        }
        field(73209589; "BLRTenant ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Refund Tenant ID';
        }
        field(73209590; "BLRAdjust Security Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209591; "BLRAdjust Chiller Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209592; "BLRAdjust other deposit"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209593; "BLRReceipt #"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK;"BLRFC ID")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if Rec."BLRRefund Payment mode" = 'Cheque' then
            if DelChr(Rec."BLRRefund Cheque No.", '=', ' ') = '' then
                Error('Cheque Number cannot be blank when Payment Mode is Cheque.');
    end;
}
