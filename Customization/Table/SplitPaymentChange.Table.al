table 50915 "Split Payment Change"
{
    DataClassification = ToBeClassified;
    fields
    {

        field(50100; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';

        }
        field(50101; "Split Payment Series"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(50102; "Secondary Item Type"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "Split Due Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(50104; "Split Payment Mode"; Text[150])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Type"."Payment Method";
        }

        field(50105; "Split Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50106; "Split VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50107; "Split Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50108; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(50109; "Tenant Id"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
        }
        field(50110; "Deposit Bank Name"; Text[100])
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
        field(50111; "Cheque Number"; Text[20])
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