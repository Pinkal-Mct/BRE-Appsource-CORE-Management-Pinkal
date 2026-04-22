table 73209635 "Merge Lum_AnnualAmount SubPage"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(73209575; "Proposal ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(73209576; "ML_Merged Unit ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                LeaseProposal: Record "Lease Proposal Details";
            begin
                if LeaseProposal.Get("Proposal ID", "ML_Merged Unit ID") then begin
                    Rec."ML_Start Date" := LeaseProposal."Lease Start Date";
                    Rec."ML_End Date" := LeaseProposal."Lease End Date";
                    Rec."ML_Unit Sq Ft" := LeaseProposal."Unit Size";
                    Rec."ML_Rate per Sq.Ft" := LeaseProposal."Rent Amount";
                    Rec."ML_Merged Unit ID" := LeaseProposal."Unit Name";
                    Rec."ML_Number of Days" := Rec."ML_End Date" - Rec."ML_Start Date";
                    Modify(true);
                end else
                    Error('No matching Lease Proposal found for the selected Unit ID.');
            end;
        }
        field(73209577; "ML_Unit ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(73209578; "ML_Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(73209579; "ML_Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(73209580; "ML_End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(73209581; "ML_Number of Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(73209582; "ML_Unit Sq Ft"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73209583; "ML_Rate per Sq.Ft"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73209584; "ML_Rent Increase %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73209585; "ML_Annual Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73209586; "ML_Round off"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73209587; "ML_Final Annual Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73209588; "ML_Per Day Rent"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73209589; "Merge Lumpsum Rent1"; Code[100])
        {
            DataClassification = ToBeClassified;
            InitValue = 'Click Here For Get Data.';
            Caption = 'Click Here For Get Data.';
        }
        field(73209590; "ML_Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(73209591; "TotalFinalAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Merge Lum_AnnualAmount SubPage"."ML_Final Annual Amount" where("Proposal Id" = field("Proposal Id")));
        }
        field(73209592; "TotalAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Merge Lum_AnnualAmount SubPage"."ML_Annual Amount" where("Proposal Id" = field("Proposal Id")));
        }
        field(73209593; "TotalRoundOff"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Merge Lum_AnnualAmount SubPage"."ML_Round off" where("Proposal Id" = field("Proposal Id")));
        }
        field(73209594; "TotalFirstAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Merge Lum_AnnualAmount SubPage"."ML_Final Annual Amount" where("Proposal Id" = field("Proposal Id"), ML_Year = const(1)));
        }
    }
    keys
    {
        key(PK; "Proposal ID", "ML_Line No.")
        {
            Clustered = true;
        }
    }
}
