table 73209654 "BLRPDCTransaction"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "BLRPDC ID";
    fields
    {
        field(73209575; "BLRPDC ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209576; "BLRTenant Id"; Text[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";
        }

        field(73209577; "BLRTenant Name Display"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("BLRTenant Id"))); // Displays Customer Name
        }

        field(73209578; "BLRCheque Number"; Text[100])
        {
            DataClassification = AccountData;

        }
        field(73209579; "BLRCheque Date"; Date)
        {
            DataClassification = AccountData;
        }
        field(73209580; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(73209581; "BLRCheque Status"; Enum "BLRPDC Status Type Enum")
        {
            DataClassification = AccountData;
            trigger OnValidate()
            var
                CashReceiptJournalCodeunit: Codeunit "BLRCash Receipt Journal Entry";
                selectDate: Page "BLRSelect Date";
            begin
                if Rec."BLRCheque Status" = Rec."BLRCheque Status"::Cancelled then
                    if xRec."BLRCheque Status" = xRec."BLRCheque Status"::"Cheque Received" then
                        CashReceiptJournalCodeunit.ReversePDCReceivedTransaction(Rec, 'PDC Payment Cancellation', Rec."BLRTransaction Date");
            end;
        }
        field(73209582; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = "BLRTenancyContract";
        }

        field(73209583; "BLRReason"; text[250])
        {
            DataClassification = CustomerContent;
        }
        field(73209584; "BLROld Cheque#"; Text[20])
        {
            DataClassification = AccountData;
        }

        field(73209585; "BLRBank Name"; code[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "Bank Account";

            trigger OnValidate()
            var
                BankAccountRec: Record "Bank Account";
            begin
                if "BLRBank Name" <> '' then
                    if BankAccountRec.Get("BLRBank Name") then
                        "BLRBank Name" := BankAccountRec."Name";
            end;
        }

        field(73209586; "BLRApproval Status"; Enum "BLRApproval Status Enum")
        {
            DataClassification = CustomerContent;
        }

        field(73209587; "BLRView Document URL"; Text[2048])
        {
            DataClassification = CustomerContent;
        }

        field(73209588; "BLRView"; text[250])
        {
            DataClassification = CustomerContent;
            InitValue = 'View Document';
        }

        field(73209589; "BLRSelected"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(73209590; "BLRpayment Series"; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209591; "BLRTransaction Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209592; "BLRPayment Mode"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Mode';
            TableRelation = "BLRPaymentType"."BLRPayment Method";
        }
        field(73209593; "BLRDue Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date';
        }
        field(73209594; "BLRNew Cheque Number"; Text[20])
        {
            DataClassification = AccountData;
            Caption = 'Cheque Number';
        }
        field(73209595; "BLRDeposit Bank"; Code[100])
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
        field(73209596; "BLRInserted"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(73209597; "BLRUpload Cheque"; Text[2048])
        {
            DataClassification = AccountData;
            Caption = 'Upload Cheque';
            InitValue = 'Upload Cheque';
        }
        field(73209598; "BLRNew View Document URL"; Text[2048])
        {
            DataClassification = CustomerContent;
        }

        field(73209599; "BLRNew View"; Text[250])
        {
            DataClassification = CustomerContent;
            InitValue = 'View Document';
        }
    }
    keys
    {
        key(PK; "BLRPDC ID")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit "No. Series";
    begin
        if "BLRPDC ID" = '' then
            "BLRPDC ID" := NoSeriesMgt.GetNextNo('PDCTRANID', Today(), true);
    end;
}
