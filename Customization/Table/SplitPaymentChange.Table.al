table 73209689 "Split Payment Change"
{
    DataClassification = ToBeClassified;
    fields
    {

        field(73209575; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';

        }
        field(73209576; "Split Payment Series"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(73209577; "Secondary Item Type"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(73209578; "Split Due Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(73209579; "Split Payment Mode"; Text[150])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Type"."Payment Method";
        }

        field(73209580; "Split Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(73209581; "Split VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(73209582; "Split Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(73209583; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(73209584; "Tenant Id"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
        }
        field(73209585; "Deposit Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";

            trigger OnValidate()
            var
                BankAccountRec: Record "Bank Account";
            begin
                if "Deposit Bank Name" <> '' then
                    if BankAccountRec.Get("Deposit Bank Name") then
                        "Deposit Bank Name" := BankAccountRec."Name";
            end;
        }
        field(73209586; "Cheque Number"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cheque Number';
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Contract ID")
        {
            Clustered = true;
        }
    }


    trigger OnModify()
    var
        SplitPaymentHandler: Codeunit "Split Payment Handler";
    begin
        SplitPaymentHandler.ProcessSplitPayment(Rec);
    end;



}