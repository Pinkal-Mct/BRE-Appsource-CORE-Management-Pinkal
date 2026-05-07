table 73209636 "Merge SameSqure SubPage"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "Proposal ID"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209576; "MS_Merged Unit ID"; Code[100])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                LeaseProposal: Record "Lease Proposal Details";
            begin
                if LeaseProposal.Get("Proposal ID", "MS_Merged Unit ID") then begin
                    Rec."MS_Merged Unit ID" := LeaseProposal."Unit Name";
                    Rec."MS_Start Date" := LeaseProposal."Lease Start Date";
                    Rec."MS_End Date" := LeaseProposal."Lease End Date";
                    Rec."MS_Unit Sq Ft" := LeaseProposal."Unit Size";
                    Rec."MS_Rate per Sq.Ft" := LeaseProposal."Rent Amount";
                    Rec."MS_Number of Days" := Rec."MS_End Date" - Rec."MS_Start Date";
                    Modify(true);
                end else
                    Error('No matching Lease Proposal found for the selected Unit ID.');
            end;
        }
        field(73209577; "MS_Unit ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209578; "MS_Year"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209579; "MS_Start Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209580; "MS_End Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209581; "MS_Number of Days"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209582; "MS_Unit Sq Ft"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209583; "MS_Rate per Sq.Ft"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209584; "MS_Rent Increase %"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209585; "MS_Annual Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209586; "MS_Round off"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209587; "MS_Final Annual Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209588; "MS_Per Day Rent"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209589; "Merge SameSqure Rent1"; Code[100])
        {
            DataClassification = CustomerContent;
            InitValue = 'Click Here For Get Data.';
            Caption = 'Click Here For Get Data.';
        }
        field(73209590; "MS_Line No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209591; "PDR Revenue Allocation Link"; Code[20])
        {
            Caption = 'PDR Revenue Allocation Link';
            DataClassification = CustomerContent;
        }
        field(73209592; "TotalFinalAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Merge SameSqure SubPage"."MS_Final Annual Amount" where("Proposal Id" = field("Proposal Id")));
        }
        field(73209593; "TotalAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Merge SameSqure SubPage"."MS_Annual Amount" where("Proposal Id" = field("Proposal Id")));
        }
        field(73209594; "TotalRoundOff"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Merge SameSqure SubPage"."MS_Round off" where("Proposal Id" = field("Proposal Id")));
        }
        field(73209595; "TotalFirstAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Merge SameSqure SubPage"."MS_Final Annual Amount" where("Proposal Id" = field("Proposal Id"), MS_Year = const(1)));
        }
    }
    keys
    {
        key(PK; "Proposal ID", "MS_Line No.")
        {
            Clustered = true;
        }
    }
}
