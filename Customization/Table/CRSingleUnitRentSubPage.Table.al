table 73209610 "BLRCRSingleUnitRentSubPage"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLRId"; Integer)
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
                LeaseProposal: Record "BLRContractRenewal";
            begin
                if LeaseProposal.Get("BLRId", "BLRUnit ID") then begin
                    Rec."BLRUnit ID" := LeaseProposal."BLRUnit Name";
                    Rec."BLRStart Date" := LeaseProposal."BLRContract Start Date";
                    Rec."BLREnd Date" := LeaseProposal."BLRContract End Date";
                    Rec."BLRUnit Sq Ft" := LeaseProposal."BLRUnit Sq. Feet";
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
            CalcFormula = sum("BLRCRSingleUnitRentSubPage"."BLRFinal Annual Amount" where("BLRId" = field("BLRId")));
        }
        field(73209592; "BLRTotalAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("BLRCRSingleUnitRentSubPage"."BLRAnnual Amount" where("BLRId" = field("BLRId")));
        }
        field(73209593; "BLRTotalRoundOff"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("BLRCRSingleUnitRentSubPage"."BLRRound off" where("BLRId" = field("BLRId")));
        }
        field(73209594; "BLRTotalFirstAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("BLRCRSingleUnitRentSubPage"."BLRFinal Annual Amount" where("BLRId" = field("BLRId"), "BLRYear" = const(1)));
        }
    }
    keys
    {
        key(PK;"BLRId", "BLRLine No.")
        {
            Clustered = true;
        }
    }
}
