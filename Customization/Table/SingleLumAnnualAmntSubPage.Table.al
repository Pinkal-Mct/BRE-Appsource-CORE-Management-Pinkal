table 73209687 "Single Lum_AnnualAmnt SubPage"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "Proposal ID"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209576; "SL_Merged Unit ID"; Code[100])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                LeaseProposal: Record "Lease Proposal Details";
            begin
                if LeaseProposal.Get("Proposal ID", "SL_Merged Unit ID") then begin
                    Rec."SL_Start Date" := LeaseProposal."Lease Start Date";
                    Rec."SL_End Date" := LeaseProposal."Lease End Date";
                    Rec."SL_Unit Sq Ft" := LeaseProposal."Unit Size";
                    Rec."SL_Rate per Sq.Ft" := LeaseProposal."Rent Amount";
                    Rec."SL_Merged Unit ID" := LeaseProposal."Unit Name";
                    Rec."SL_Number of Days" := Rec."SL_End Date" - Rec."SL_Start Date";
                    Modify(true);
                end else
                    Error('No matching Lease Proposal found for the selected Unit ID.');
            end;
        }
        field(73209577; "SL_Unit ID"; Code[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209578; "SL_Year"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209579; "SL_Start Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209580; "SL_End Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209581; "SL_Number of Days"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209582; "SL_Unit Sq Ft"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209583; "SL_Rate per Sq.Ft"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209584; "SL_Rent Increase %"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209585; "SL_Annual Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209586; "SL_Round off"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209587; "SL_Final Annual Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209588; "SL_Per Day Rent"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209589; "Single Lumpsum Rent1"; Code[100])
        {
            DataClassification = CustomerContent;
            InitValue = 'Click Here For Get Data.';
            Caption = 'Click Here For Get Data.';
        }
        field(73209590; "SL_Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209591; "TotalFinalAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Single Lum_AnnualAmnt SubPage"."SL_Final Annual Amount" where("Proposal Id" = field("Proposal Id")));
        }
        field(73209592; "TotalAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Single Lum_AnnualAmnt SubPage"."SL_Annual Amount" where("Proposal Id" = field("Proposal Id")));
        }
        field(73209593; "TotalRoundOff"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Single Lum_AnnualAmnt SubPage"."SL_Round off" where("Proposal Id" = field("Proposal Id")));
        }
        field(73209594; "TotalFirstAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Single Lum_AnnualAmnt SubPage"."SL_Final Annual Amount" where("Proposal Id" = field("Proposal Id"), SL_Year = const(1)));
        }
    }
    keys
    {
        key(PK; "Proposal ID", "SL_Line No.")
        {
            Clustered = true;
        }
    }
}
