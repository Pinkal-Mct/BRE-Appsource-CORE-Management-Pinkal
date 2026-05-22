table 73209670 "BLRRevenueAllocationApproval"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLRRA_ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'RA_ID';
            Editable = false;
            AutoIncrement = true;
        }
        field(73209576; "BLRID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209577; "BLRFinancial Year"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Financial Year';
        }
        field(73209578; "BLRMonth"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
            Caption = 'Month';
        }
        field(73209579; "BLRStatus"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionMembers = "Pending","Approved","Reject";
        }
    }
    keys
    {
        key(PK;"BLRRA_ID")
        {
            Clustered = false;
        }
    }

    trigger OnInsert()
    var
        approvalRevenuerequest: Codeunit "Approval Revenue Allocation";
    begin
        approvalRevenuerequest.SendRevenueApprovalrequest(Rec);
    end;
}
