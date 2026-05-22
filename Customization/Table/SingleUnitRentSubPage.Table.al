table 73209688 "BLRSingleUnitRentSubPage"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLRProposal ID"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209576; "BLRMerged Unit ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209577; "BLRUnit ID"; Code[100])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                LeaseProposal: Record "BLRLeaseProposalDetails";
            begin
                if LeaseProposal.Get("BLRProposal ID", "BLRUnit ID") then begin
                    Rec."BLRUnit ID" := LeaseProposal."BLRUnit Name";
                    Rec."BLRStart Date" := LeaseProposal."BLRLease Start Date";
                    Rec."BLREnd Date" := LeaseProposal."BLRLease End Date";
                    Rec."BLRUnit Sq Ft" := LeaseProposal."BLRUnit Size";
                    Rec."BLRRate per Sq.Ft" := LeaseProposal."BLRRent Amount";
                    Rec."BLRNumber of Days" := Rec."BLREnd Date" - Rec."BLRStart Date";
                    Modify(true);
                end else
                    Error('No matching Lease Proposal found for the selected "BLRUnit ID".');
            end;
        }
        field(73209578; "BLRYear"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209579; "BLRStart Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209580; "BLREnd Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209581; "BLRNumber of Days"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209582; "BLRUnit Sq Ft"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209583; "BLRRate per Sq.Ft"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209584; "BLRRent Increase %"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209585; "BLRAnnual Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
        }
        field(73209586; "BLRRound off"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209587; "BLRFinal Annual Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209588; "BLRPer Day Rent"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209589; "BLRSingle Unit Rent1"; Code[100])
        {
            DataClassification = CustomerContent;
            InitValue = 'Click Here For Get Data.';
            Caption = 'Click Here For Get Data.';
        }
        field(73209590; "BLRLine No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209591; "BLRTotalFinalAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("BLRSingleUnitRentSubPage"."BLRFinal Annual Amount" where("BLRProposal ID" = field("BLRProposal ID")));
        }
        field(73209592; "BLRTotalAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("BLRSingleUnitRentSubPage"."BLRAnnual Amount" where("BLRProposal ID" = field("BLRProposal ID")));
        }
        field(73209593; "BLRTotalRoundOff"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("BLRSingleUnitRentSubPage"."BLRRound off" where("BLRProposal ID" = field("BLRProposal ID")));
        }
        field(73209594; "BLRTotalFirstAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("BLRSingleUnitRentSubPage"."BLRFinal Annual Amount" where("BLRProposal ID" = field("BLRProposal ID"), "BLRYear" = const(1)));
        }
    }
    keys
    {
        key(PK;"BLRProposal ID", "BLRLine No.")
        {
            Clustered = true;
        }
    }
}
