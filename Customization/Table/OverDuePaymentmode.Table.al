table 73209642 "OverDuePaymentmode"
{
    DataClassification = CustomerContent;

    fields
    {

        field(73209575; "ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            AutoIncrement = true;
        }

        field(73209576; "Status"; Enum "Approval Status Enum")
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
        }
        field(73209577; "Tenant Id"; Code[20])
        {
            Caption = 'Tenant Id';
            DataClassification = CustomerContent;
        }

        field(73209578; "Contract ID"; Integer)
        {
            Caption = 'Contract ID';
            DataClassification = CustomerContent;
        }

        field(73209579; "Payment Series"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Series';

        }
        field(73209580; "Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date';
        }

        field(73209581; "Payment Status"; Enum "Payment Status")
        {
            Caption = 'Payment Status';
            DataClassification = CustomerContent;
        }
        field(73209582; "Tenant Name"; Text[100])
        {
            Caption = 'Tenant Name';
            DataClassification = EndUserIdentifiableInformation;
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
