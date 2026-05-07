table 73209667 "Request Credit Note"
{
    DataClassification = CustomerContent;
    Caption = 'Request Credit Note';
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
        field(73209577; "Property Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Name';
        }
        field(73209578; "Tenant No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant No.';
        }
        field(73209579; "Customer Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Customer Name';
        }
        field(73209580; "Request Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Request Date';
        }
        field(73209581; "Credit Note Start Month"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note Start Month';
        }
        field(73209582; "Credit Note End Month"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note End Month';
        }
        field(73209583; "Payment Frequency"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Frequency';
        }
        field(73209584; "Monthly Reduction"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Monthly Reduction';
        }
        field(73209585; "Reason"; Text[1000])
        {
            DataClassification = CustomerContent;
            Caption = 'Reason';
        }
        field(73209586; "Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Pending,Approved,Rejected;
            Caption = 'Status';
        }
        field(73209587; "Request Source"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Email,Phone,WalkIn,Other;
            Caption = 'Request Source';
        }
        field(73209588; "Total Reduction"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Reduction';
        }
        field(73209589; "Payment Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Series';
        }
        field(73209590; "Current Rent Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Current Rent Amount';
        }
        field(73209591; "Reason for Rejection"; Text[1000])
        {
            DataClassification = CustomerContent;
            Caption = 'Reason for Rejection';
        }
        field(73209592; "Property Classification"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Classification';
        }
        field(73209593; "Adjust with Invoice"; Option)
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
        "Request No." := Requestno;
    end;

    trigger OnDelete()
    var
    begin
        Deletepaymetnscheudlesubpage();
    end;

    procedure Deletepaymetnscheudlesubpage()
    var
        RequestCreditNoteGrid: Record "Request Credit Note Grid";
    begin
        RequestCreditNoteGrid.SetRange("Request No.", Rec."Request No.");
        if RequestCreditNoteGrid.FindSet() then
            repeat
                RequestCreditNoteGrid.DeleteAll();
            until RequestCreditNoteGrid.Next() = 0;
    end;
}
