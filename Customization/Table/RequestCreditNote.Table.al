table 73209667 "BLRRequestCreditNote"
{
    DataClassification = CustomerContent;
    Caption = 'Request Credit Note';
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
        field(73209577; "BLRProperty Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Name';
        }
        field(73209578; "BLRTenant No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant No.';
        }
        field(73209579; "BLRCustomer Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Customer Name';
        }
        field(73209580; "BLRRequest Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Request Date';
        }
        field(73209581; "BLRCredit Note Start Month"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note Start Month';
        }
        field(73209582; "BLRCredit Note End Month"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note End Month';
        }
        field(73209583; "BLRPayment Frequency"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Frequency';
        }
        field(73209584; "BLRMonthly Reduction"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Monthly Reduction';
        }
        field(73209585; "BLRReason"; Text[1000])
        {
            DataClassification = CustomerContent;
            Caption = 'Reason';
        }
        field(73209586; "BLRStatus"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Pending,Approved,Rejected;
            Caption = 'Status';
        }
        field(73209587; "BLRRequest Source"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Email,Phone,WalkIn,Other;
            Caption = 'Request Source';
        }
        field(73209588; "BLRTotal Reduction"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Reduction';
        }
        field(73209589; "BLRPayment Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Series';
        }
        field(73209590; "BLRCurrent Rent Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Current Rent Amount';
        }
        field(73209591; "BLRReason for Rejection"; Text[1000])
        {
            DataClassification = CustomerContent;
            Caption = 'Reason for Rejection';
        }
        field(73209592; "BLRProperty Classification"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Classification';
        }
        field(73209593; "BLRAdjust with Invoice"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Pending,Adjusted;
        }
    }
    trigger OnInsert()
    var
        NoSeriesManagement: Codeunit "No. Series";
        Requestno: Code[20];
    begin
        Requestno := NoSeriesManagement.GetNextNo('RCNID', 0D, true);
        "BLRRequest No." := Requestno;
    end;

    trigger OnDelete()
    var
    begin
        Deletepaymetnscheudlesubpage();
    end;

    procedure Deletepaymetnscheudlesubpage()
    var
        RequestCreditNoteGrid: Record "BLRRequestCreditNoteGrid";
    begin
        RequestCreditNoteGrid.SetRange("BLRRequest No.", Rec."BLRRequest No.");
        if RequestCreditNoteGrid.FindSet() then
            repeat
                RequestCreditNoteGrid.DeleteAll();
            until RequestCreditNoteGrid.Next() = 0;
    end;
}
