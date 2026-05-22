table 73209636 "BLRMergeSameSqureSubPage"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLRProposal ID"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209576; "BLRMS_Merged Unit ID"; Code[100])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                LeaseProposal: Record "BLRLeaseProposalDetails";
            begin
                if LeaseProposal.Get("BLRProposal ID", "BLRMS_Merged Unit ID") then begin
                    Rec."BLRMS_Merged Unit ID" := LeaseProposal."BLRUnit Name";
                    Rec."BLRMS_Start Date" := LeaseProposal."BLRLease Start Date";
                    Rec."BLRMS_End Date" := LeaseProposal."BLRLease End Date";
                    Rec."BLRMS_Unit Sq Ft" := LeaseProposal."BLRUnit Size";
                    Rec."BLRMS_Rate per Sq.Ft" := LeaseProposal."BLRRent Amount";
                    Rec."BLRMS_Number of Days" := Rec."BLRMS_End Date" - Rec."BLRMS_Start Date";
                    Modify(true);
                end else
                    Error('No matching Lease Proposal found for the selected Unit ID.');
            end;
        }
        field(73209577; "BLRMS_Unit ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209578; "BLRMS_Year"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209579; "BLRMS_Start Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209580; "BLRMS_End Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209581; "BLRMS_Number of Days"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209582; "BLRMS_Unit Sq Ft"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209583; "BLRMS_Rate per Sq.Ft"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209584; "BLRMS_Rent Increase %"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209585; "BLRMS_Annual Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209586; "BLRMS_Round off"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209587; "BLRMS_Final Annual Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209588; "BLRMS_Per Day Rent"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209589; "BLRMerge SameSqure Rent1"; Code[100])
        {
            DataClassification = CustomerContent;
            InitValue = 'Click Here For Get Data.';
            Caption = 'Click Here For Get Data.';
        }
        field(73209590; "BLRMS_Line No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209591; "BLRPDR Revenue Allocation Link"; Code[20])
        {
            Caption = 'PDR Revenue Allocation Link';
            DataClassification = CustomerContent;
        }
        field(73209592; "BLRTotalFinalAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("BLRMergeSameSqureSubPage"."BLRMS_Final Annual Amount" where("BLRProposal ID" = field("BLRProposal ID")));
        }
        field(73209593; "BLRTotalAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("BLRMergeSameSqureSubPage"."BLRMS_Annual Amount" where("BLRProposal ID" = field("BLRProposal ID")));
        }
        field(73209594; "BLRTotalRoundOff"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("BLRMergeSameSqureSubPage"."BLRMS_Round off" where("BLRProposal ID" = field("BLRProposal ID")));
        }
        field(73209595; "BLRTotalFirstAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("BLRMergeSameSqureSubPage"."BLRMS_Final Annual Amount" where("BLRProposal ID" = field("BLRProposal ID"), "BLRMS_Year" = const(1)));
        }
    }
    keys
    {
        key(PK;"BLRProposal ID", "BLRMS_Line No.")
        {
            Clustered = true;
        }
    }
}
