table 73209689 "BLRSplitPaymentChange"
{
    DataClassification = CustomerContent;
    fields
    {

        field(73209575; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';

        }
        field(73209576; "BLRSplit Payment Series"; Text[100])
        {
            DataClassification = CustomerContent;
        }

        field(73209577; "BLRSecondary Item Type"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209578; "BLRSplit Due Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(73209579; "BLRSplit Payment Mode"; Text[150])
        {
            DataClassification = CustomerContent;
            TableRelation = "BLRPaymentType"."BLRPayment Method";
        }

        field(73209580; "BLRSplit Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(73209581; "BLRSplit VAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(73209582; "BLRSplit Amount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(73209583; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209584; "BLRTenant Id"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
        }
        field(73209585; "BLRDeposit Bank Name"; Text[100])
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
        field(73209586; "BLRCheque Number"; Text[20])
        {
            DataClassification = AccountData;
            Caption = 'Cheque Number';
        }
    }

    keys
    {
        key(Key1; "BLREntry No.", "BLRContract ID")
        {
            Clustered = true;
        }
    }


    trigger OnModify()
    var
        SplitPaymentHandler: Codeunit "BLRSplit Payment Handler";
    begin
        SplitPaymentHandler.ProcessSplitPayment(Rec);
    end;



}
