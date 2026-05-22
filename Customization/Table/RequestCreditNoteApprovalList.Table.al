table 73209668 "BLRReqCreditNoteApprovalList"
{
    Caption = 'Request Credit Note Approval List';
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLRRequest No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Request No.';
        }
        field(73209576; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209577; "BLRTenant No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant No.';
        }
        field(73209578; "BLRTotal Rent Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Rent Amount';
        }
        field(73209579; "BLRTotal Reduction Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Reduction Amount';
        }
        field(73209580; "BLRRequest Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Request Date';
        }
        field(73209581; "BLRStatus"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
        }
        field(73209582; "BLRRemark"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Remark';
        }
        field(73209583; "BLRID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            AutoIncrement = true;
        }
    }
}
