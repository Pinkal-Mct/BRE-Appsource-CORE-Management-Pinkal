table 73209654 "PDC Transaction"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "PDC ID";
    fields
    {
        field(73209575; "PDC ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(73209576; "Tenant Id"; Text[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";
        }

        field(73209577; "Tenant Name Display"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Tenant Id"))); // Displays Customer Name
        }

        field(73209578; "Cheque Number"; Text[100])
        {
            DataClassification = CustomerContent;

        }
        field(73209579; "Cheque Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209580; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(73209581; "Cheque Status"; Enum "PDC Status Type Enum")
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                CashReceiptJournalCodeunit: Codeunit "Cash Receipt Journal Entry";
                selectDate: Page "Select Date";
            begin
                if Rec."Cheque Status" = Rec."Cheque Status"::Cancelled then
                    if xRec."Cheque Status" = xRec."Cheque Status"::"Cheque Received" then
                        CashReceiptJournalCodeunit.ReversePDCReceivedTransaction(Rec, 'PDC Payment Cancellation', Rec."Transaction Date");
            end;
        }
        field(73209582; "Contract ID"; Integer)
        {
            TableRelation = "Tenancy Contract";
        }

        field(73209583; "Reason"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(73209584; "Old Cheque#"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(73209585; "Bank Name"; code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";

            trigger OnValidate()
            var
                BankAccountRec: Record "Bank Account";
            begin
                if "Bank Name" <> '' then
                    if BankAccountRec.Get("Bank Name") then
                        "Bank Name" := BankAccountRec."Name";
            end;
        }

        field(73209586; "Approval Status"; Enum "Approval Status Enum")
        {
            DataClassification = ToBeClassified;
        }

        field(73209587; "View Document URL"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }

        field(73209588; View; text[250])
        {
            DataClassification = ToBeClassified;
            InitValue = 'View Document';
        }

        field(73209589; Selected; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(73209590; "payment Series"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(73209591; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(73209592; "Payment Mode"; Text[100])
        {
            Caption = 'Payment Mode';
            TableRelation = "Payment Type"."Payment Method";
        }
        field(73209593; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Due Date';
        }
        field(73209594; "New Cheque Number"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cheque Number';
        }
        field(73209595; "Deposit Bank"; Code[100])
        {
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
        field(73209596; Inserted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(73209597; "Upload Cheque"; Text[2048])
        {
            DataClassification = ToBeClassified;
            Caption = 'Upload Cheque';
            InitValue = 'Upload Cheque';
        }
        field(73209598; "New View Document URL"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }

        field(73209599; "New View"; Text[250])
        {
            DataClassification = ToBeClassified;
            InitValue = 'View Document';
        }
    }
    keys
    {
        key(PK; "PDC ID")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit "No. Series";
    begin
        if "PDC ID" = '' then
            "PDC ID" := NoSeriesMgt.GetNextNo('PDCTRANID', Today(), true);
    end;
}