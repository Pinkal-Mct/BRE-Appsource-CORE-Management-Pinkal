table 73209670 "Revenue Allocation Approval"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(73209575; "RA_ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'RA_ID';
            Editable = false;
            AutoIncrement = true;
        }
        field(73209576; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(73209577; "Financial Year"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Financial Year';
        }
        field(73209578; "Month"; Option)
        {
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
            Caption = 'Month';
        }
        field(73209579; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
            OptionMembers = "Pending","Approved","Reject";
        }
    }
    keys
    {
        key(PK; "RA_ID")
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
