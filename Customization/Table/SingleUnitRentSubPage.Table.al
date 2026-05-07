table 73209688 "Single Unit Rent SubPage"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "Proposal ID"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209576; "Merged Unit ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209577; "Unit ID"; Code[100])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                LeaseProposal: Record "Lease Proposal Details";
            begin
                if LeaseProposal.Get("Proposal ID", "Unit ID") then begin
                    Rec."Unit ID" := LeaseProposal."Unit Name";
                    Rec."Start Date" := LeaseProposal."Lease Start Date";
                    Rec."End Date" := LeaseProposal."Lease End Date";
                    Rec."Unit Sq Ft" := LeaseProposal."Unit Size";
                    Rec."Rate per Sq.Ft" := LeaseProposal."Rent Amount";
                    Rec."Number of Days" := Rec."End Date" - Rec."Start Date";
                    Modify(true);
                end else
                    Error('No matching Lease Proposal found for the selected Unit ID.');
            end;
        }
        field(73209578; "Year"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209579; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209580; "End Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209581; "Number of Days"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209582; "Unit Sq Ft"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209583; "Rate per Sq.Ft"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209584; "Rent Increase %"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209585; "Annual Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
        }
        field(73209586; "Round off"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209587; "Final Annual Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209588; "Per Day Rent"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209589; "Single Unit Rent1"; Code[100])
        {
            DataClassification = CustomerContent;
            InitValue = 'Click Here For Get Data.';
            Caption = 'Click Here For Get Data.';
        }
        field(73209590; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209591; "TotalFinalAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Single Unit Rent SubPage"."Final Annual Amount" where("Proposal Id" = field("Proposal Id")));
        }
        field(73209592; "TotalAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Single Unit Rent SubPage"."Annual Amount" where("Proposal Id" = field("Proposal Id")));
        }
        field(73209593; "TotalRoundOff"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Single Unit Rent SubPage"."Round off" where("Proposal Id" = field("Proposal Id")));
        }
        field(73209594; "TotalFirstAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Single Unit Rent SubPage"."Final Annual Amount" where("Proposal Id" = field("Proposal Id"), Year = const(1)));
        }
    }
    keys
    {
        key(PK; "Proposal ID", "Line No.")
        {
            Clustered = true;
        }
    }
}
