table 50507 "PDC Transaction"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "PDC ID";
    fields
    {
        field(50501; "PDC ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50502; "Tenant Id"; Text[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";
        }

        field(50509; "Tenant Name Display"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Tenant Id"))); // Displays Customer Name
        }

        field(50504; "Cheque Number"; Text[100])
        {
            DataClassification = CustomerContent;

        }
        field(50505; "Cheque Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50506; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(50507; "Cheque Status"; Enum "PDC Status Type Enum")
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
        field(50508; "Contract ID"; Integer)
        {
            TableRelation = "Tenancy Contract";
        }

        field(50510; "Reason"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50511; "Old Cheque#"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50512; "Bank Name"; code[100])
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

        field(50513; "Approval Status"; Enum "Approval Status Enum")
        {
            DataClassification = ToBeClassified;
        }

        field(50517; "View Document URL"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }

        field(50514; View; text[250])
        {
            DataClassification = ToBeClassified;
            InitValue = 'View Document';
        }

        field(50515; Selected; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50516; "payment Series"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50518; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50519; "Payment Mode"; Text[100])
        {
            Caption = 'Payment Mode';
            TableRelation = "Payment Type"."Payment Method";
        }
        field(50520; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Due Date';
        }
        field(50521; "New Cheque Number"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cheque Number';
        }
        field(50522; "Deposit Bank"; Code[100])
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
        field(50523; Inserted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50524; "Upload Cheque"; Text[2048])
        {
            DataClassification = ToBeClassified;
            Caption = 'Upload Cheque';
            InitValue = 'Upload Cheque';
        }
        field(50525; "New View Document URL"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }

        field(50526; "New View"; Text[250])
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