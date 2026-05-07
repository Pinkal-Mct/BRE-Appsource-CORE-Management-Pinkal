table 73209690 "SplitPaymentLog"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "ID";


    fields
    {
        field(73209575; "ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            Editable = false;
        }
        field(73209576; "Approval Status"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            Editable = false;
        }
        field(73209577; "Request Type"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Request Type';
            Editable = false;
        }

        field(73209578; "Tenant ID"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
            Editable = false;
        }
        field(73209579; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
            Editable = false;
        }

        field(73209580; "New Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'New Amount';
            Editable = false;
        }
        field(73209581; "New VAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'New Vat Amount';
            Editable = false;
        }

        field(73209582; "Change Amount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'New Amount Including VAT';
            Editable = false;
        }

        field(73209583; "Payment mode"; Text[300])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment mode';
            TableRelation = "Payment Type"."Payment Method";
            Editable = false;
        }

        field(73209584; "Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'New Due Date';
            Editable = false;
        }

        field(73209585; "Payment Series"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Series';
            Editable = false;
        }
        field(73209586; "Items"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Items';
            Editable = false;
        }

        field(73209587; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
            Editable = false;
        }
        field(73209588; "Deposit Bank Name"; Text[100])
        {
            DataClassification = AccountData;
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
        field(73209589; "Cheque Number"; Text[20])
        {
            DataClassification = AccountData;
            Caption = 'Cheque Number';
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

