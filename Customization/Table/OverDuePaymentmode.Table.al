table 73209642 "OverDuePaymentmode"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(73209575; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
            AutoIncrement = true;
        }

        field(73209576; "Status"; Enum "Approval Status Enum")
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
        }
        field(73209577; "Tenant Id"; Code[20])
        {
            Caption = 'Tenant Id';
        }

        field(73209578; "Contract ID"; Integer)
        {
            Caption = 'Contract ID';
        }

        field(73209579; "Payment Series"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Series';

        }
        field(73209580; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Due Date';
        }

        field(73209581; "Payment Status"; Enum "Payment Status")
        {
            Caption = 'Payment Status';
        }
        field(73209582; "Tenant Name"; Text[100])
        {
            Caption = 'Tenant Name';
        }
    }

    keys
    {
        key(PK; "ID")
        {
            Clustered = false;
        }

    }

    trigger OnInsert()
    var
        overduepaymentapproval: Codeunit OverduePaymentReq;
    begin
        overduepaymentapproval.SendApprovalrequest(Rec);
    end;
}