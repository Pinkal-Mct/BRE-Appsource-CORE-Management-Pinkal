table 73209605 "CR Merge DifferentSq SubPage"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "ID"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209576; "MD_Merged Unit ID"; Code[100])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                LeaseProposal: Record "Contract Renewal";
            begin
                if LeaseProposal.Get("ID", "MD_Merged Unit ID") then begin
                    Rec."MD_Merged Unit ID" := LeaseProposal."Unit Name";
                    Rec."MD_Start Date" := LeaseProposal."Contract Start Date";
                    Rec."MD_End Date" := LeaseProposal."Contract End Date";
                    Rec."MD_Unit Sq Ft" := LeaseProposal."Unit Sq. Feet";
                    Rec."MD_Rate per Sq.Ft" := LeaseProposal."Rent Amount";
                    Rec."MD_Number of Days" := Rec."MD_End Date" - Rec."MD_Start Date";
                    Modify(true);
                end else
                    Error('No matching Lease Proposal found for the selected Unit ID.');
            end;
        }
        field(73209577; "MD_Unit ID"; Code[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209578; "MD_Year"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209579; "MD_Start Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209580; "MD_End Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209581; "MD_Number of Days"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209582; "MD_Unit Sq Ft"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209583; "MD_Rate per Sq.Ft"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209584; "MD_Rent Increase %"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209585; "MD_Annual Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209586; "MD_Round off"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209587; "MD_Final Annual Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209588; "MD_Per Day Rent"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209589; "Merge DifferentSqure Rent1"; Code[100])
        {
            DataClassification = CustomerContent;
            InitValue = 'Click Here For Get Data.';
            Caption = 'Click Here For Get Data.';
        }

        field(73209590; "MD_Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209591; "TotalFinalAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("CR Merge DifferentSq SubPage"."MD_Final Annual Amount" where("Id" = field("Id")));

        }
        field(73209592; "TotalAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("CR Merge DifferentSq SubPage"."MD_Annual Amount" where("Id" = field("Id")));

        }
        field(73209593; "TotalRoundOff"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("CR Merge DifferentSq SubPage"."MD_Round off" where("Id" = field("Id")));

        }
        field(73209594; "TotalFirstAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("CR Merge DifferentSq SubPage"."MD_Final Annual Amount" where("Id" = field(ID), MD_Year = const(1)));

        }
    }

    keys
    {
        key(PK; "ID", "MD_Line No.")
        {
            Clustered = true;
        }
    }
}
