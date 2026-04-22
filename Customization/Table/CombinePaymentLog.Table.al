table 73209596 "CombinePaymentLog"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "ID";
    fields
    {
        field(73209575; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
            Editable = false;
        }
        field(73209576; "Approval Status"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
            Editable = false;
        }
        field(73209577; "Request Type"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Request Type';
            Editable = false;
        }
        field(73209578; "Tenant ID"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
            Editable = false;
        }
        field(73209579; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
            Editable = false;
        }
        field(73209580; "New Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'New Amount';
            Editable = false;
        }
        field(73209581; "New VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'New Vat Amount';
            Editable = false;
        }
        field(73209582; "Change Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'New Amount Including VAT';
            Editable = false;
        }
        field(73209583; "Payment mode"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment mode';
            TableRelation = "Payment Type"."Payment Method";
            Editable = false;
        }
        field(73209584; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'New Due Date';
            Editable = false;
        }
        field(73209585; "Payment Series"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Series';
            Editable = false;
        }
        field(73209586; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
        }
        field(73209587; "C_Cheque_Number"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cheque Number';
        }
        field(73209588; "C_Deposit_Bank"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Deposit Bank';
            TableRelation = "Bank Account";

            trigger OnValidate()
            var
                BankAccountRec: Record "Bank Account";
            begin
                if "C_Deposit_Bank" <> '' then
                    if BankAccountRec.Get("C_Deposit_Bank") then
                        "C_Deposit_Bank" := BankAccountRec."Name";
            end;
        }
    }
    keys
    {
        key(Key1; "Entry No.", "ID")
        {
            Clustered = true;
        }
    }
}
