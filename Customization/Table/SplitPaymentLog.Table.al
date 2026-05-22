table 73209690 "BLRSplitPaymentLog"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "BLRID";


    fields
    {
        field(73209575; "BLRID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            Editable = false;
        }
        field(73209576; "BLRApproval Status"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            Editable = false;
        }
        field(73209577; "BLRRequest Type"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Request Type';
            Editable = false;
        }

        field(73209578; "BLRTenant ID"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
            Editable = false;
        }
        field(73209579; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
            Editable = false;
        }

        field(73209580; "BLRNew Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'New Amount';
            Editable = false;
        }
        field(73209581; "BLRNew VAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'New Vat Amount';
            Editable = false;
        }

        field(73209582; "BLRChange Amount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'New Amount Including VAT';
            Editable = false;
        }

        field(73209583; "BLRPayment mode"; Text[300])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment mode';
            TableRelation = "BLRPaymentType"."BLRPayment Method";
            Editable = false;
        }

        field(73209584; "BLRDue Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'New Due Date';
            Editable = false;
        }

        field(73209585; "BLRPayment Series"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Series';
            Editable = false;
        }
        field(73209586; "BLRItems"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Items';
            Editable = false;
        }

        field(73209587; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
            Editable = false;
        }
        field(73209588; "BLRDeposit Bank Name"; Text[100])
        {
            DataClassification = AccountData;
            TableRelation = "Bank Account";

            trigger OnValidate()
            var
                BankAccountRec: Record "Bank Account";
            begin
                if "BLRDeposit Bank Name" <> '' then
                    if BankAccountRec.Get("BLRDeposit Bank Name") then
                        "BLRDeposit Bank Name" := BankAccountRec."Name";
            end;
        }
        field(73209589; "BLRCheque Number"; Text[20])
        {
            DataClassification = AccountData;
            Caption = 'Cheque Number';
        }
    }

    keys
    {
        key(Key1;"BLREntry No.", "BLRID")
        {
            Clustered = true;
        }
    }

}

