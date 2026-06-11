table 73209642 "BLROverDuePaymentmode"
{
    DataClassification = CustomerContent;

    fields
    {

        field(73209575; "BLRID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            AutoIncrement = true;
        }

        field(73209576; "BLRStatus"; Enum "BLRApproval Status Enum")
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
        }
        field(73209577; "BLRTenant Id"; Code[20])
        {
            Caption = 'Tenant Id';
            DataClassification = CustomerContent;
        }

        field(73209578; "BLRContract ID"; Integer)
        {
            Caption = 'Contract ID';
            DataClassification = CustomerContent;
        }

        field(73209579; "BLRPayment Series"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Series';

        }
        field(73209580; "BLRDue Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date';
        }

        field(73209581; "BLRPayment Status"; Enum "BLRPayment Status")
        {
            Caption = 'Payment Status';
            DataClassification = CustomerContent;
        }
        field(73209582; "BLRTenant Name"; Text[100])
        {
            Caption = 'Tenant Name';
            DataClassification = EndUserIdentifiableInformation;
        }
    }

    keys
    {
        key(PK; "BLRID")
        {
            Clustered = false;
        }

    }

    trigger OnInsert()
    var
        overduepaymentapproval: Codeunit BLROverduePaymentReq;
    begin
        overduepaymentapproval.SendApprovalrequest(Rec);
    end;
}
