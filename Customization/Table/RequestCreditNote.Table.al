table 73209667 "Request Credit Note"
{
    DataClassification = ToBeClassified;
    Caption = 'Request Credit Note';
    fields
    {
        field(73209575; "Request No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Request No.';
        }
        field(73209576; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(73209577; "Property Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Name';
        }
        field(73209578; "Tenant No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant No.';
        }
        field(73209579; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Name';
        }
        field(73209580; "Request Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Request Date';
        }
        field(73209581; "Credit Note Start Month"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Note Start Month';
        }
        field(73209582; "Credit Note End Month"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Note End Month';
        }
        field(73209583; "Payment Frequency"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Frequency';
        }
        field(73209584; "Monthly Reduction"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Monthly Reduction';
        }
        field(73209585; "Reason"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reason';
        }
        field(73209586; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Pending,Approved,Rejected;
            Caption = 'Status';
        }
        field(73209587; "Request Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Email,Phone,WalkIn,Other;
            Caption = 'Request Source';
        }
        field(73209588; "Total Reduction"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Reduction';
        }
        field(73209589; "Payment Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Series';
        }
        field(73209590; "Current Rent Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Current Rent Amount';
        }
        field(73209591; "Reason for Rejection"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reason for Rejection';
        }
        field(73209592; "Property Classification"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Classification';
        }
        field(73209593; "Adjust with Invoice"; Option)
        {
            DataClassification = ToBeClassified;
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