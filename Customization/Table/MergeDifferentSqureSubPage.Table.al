table 73209633 "BLRMergeDifferentSqureSubPage"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLRProposal ID"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209576; "BLRMD_Merged Unit ID"; Code[100])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                LeaseProposal: Record "BLRLeaseProposalDetails";
            begin
                if LeaseProposal.Get("BLRProposal ID", "BLRMD_Merged Unit ID") then begin
                    Rec."BLRMD_Merged Unit ID" := LeaseProposal."BLRUnit Name";
                    Rec."BLRMD_Start Date" := LeaseProposal."BLRLease Start Date";
                    Rec."BLRMD_End Date" := LeaseProposal."BLRLease End Date";
                    Rec."BLRMD_Unit Sq Ft" := LeaseProposal."BLRUnit Size";
                    Rec."BLRMD_Rate per Sq.Ft" := LeaseProposal."BLRRent Amount";
                    Rec."BLRMD_Number of Days" := Rec."BLRMD_End Date" - Rec."BLRMD_Start Date";
                    Modify(true);
                end else
                    Error('No matching Lease Proposal found for the selected Unit ID.');
            end;
        }
        field(73209577; "BLRMD_Unit ID"; Code[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209578; "BLRMD_Year"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209579; "BLRMD_Start Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209580; "BLRMD_End Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209581; "BLRMD_Number of Days"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209582; "BLRMD_Unit Sq Ft"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209583; "BLRMD_Rate per Sq.Ft"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209584; "BLRMD_Rent Increase %"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209585; "BLRMD_Annual Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209586; "BLRMD_Round off"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209587; "BLRMD_Final Annual Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209588; "BLRMD_Per Day Rent"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209589; "BLRMerge DifferentSqure Rent1"; Code[100])
        {
            DataClassification = CustomerContent;
            InitValue = 'Click Here For Get Data.';
            Caption = 'Click Here For Get Data.';
        }
        field(73209590; "BLRMD_Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209591; "BLRTotalFinalAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("BLRMergeDifferentSqureSubPage"."BLRMD_Final Annual Amount" where("BLRProposal ID" = field("BLRProposal ID")));
        }
        field(73209592; "BLRTotalAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("BLRMergeDifferentSqureSubPage"."BLRMD_Annual Amount" where("BLRProposal ID" = field("BLRProposal ID")));
        }
        field(73209593; "BLRTotalRoundOff"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("BLRMergeDifferentSqureSubPage"."BLRMD_Round off" where("BLRProposal ID" = field("BLRProposal ID")));
        }
        field(73209594; "BLRTotalFirstAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("BLRMergeDifferentSqureSubPage"."BLRMD_Final Annual Amount" where("BLRProposal ID" = field("BLRProposal ID"), "BLRMD_Year" = const(1)));
        }
    }
    keys
    {
        key(PK;"BLRProposal ID", "BLRMD_Line No.")
        {
            Clustered = true;
        }
    }
}
