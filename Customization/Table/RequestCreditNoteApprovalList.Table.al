table 73209668 "RequestCreditNoteApprovalList"
{
    Caption = 'Request Credit Note Approval List';
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "Request No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Request No.';
        }
        field(73209576; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209577; "Tenant No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant No.';
        }
        field(73209578; "Total Rent Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Rent Amount';
        }
        field(73209579; "Total Reduction Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Reduction Amount';
        }
        field(73209580; "Request Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Request Date';
        }
        field(73209581; "Status"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
        }
        field(73209582; Remark; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Remark';
        }
        field(73209583; "ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            AutoIncrement = true;
        }
    }
}
