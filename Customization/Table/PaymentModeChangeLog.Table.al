table 73209647 "BLRPaymentModeChangeLog"
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
        field(73209580; "BLRPayment mode"; Text[300])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment mode';
            Editable = false;
        }

        field(73209581; "BLRPayment Series"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Series';
            Editable = false;
        }
        field(73209582; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
            Editable = false;
        }
        field(73209583; "BLRDeposit Bank Name"; Text[100])
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
        field(73209584; "BLRCheque Number"; Text[20])
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

