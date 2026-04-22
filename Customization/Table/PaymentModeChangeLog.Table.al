table 73209647 "PaymentModeChangeLog"
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
        field(73209580; "Payment mode"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment mode';
            Editable = false;
        }

        field(73209581; "Payment Series"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Series';
            Editable = false;
        }
        field(73209582; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
        }
        field(73209583; "Deposit Bank Name"; Text[100])
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
        field(73209584; "Cheque Number"; Text[20])
        {
            DataClassification = ToBeClassified;
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

