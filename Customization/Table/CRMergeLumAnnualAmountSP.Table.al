table 73209606 "CR Merge LumAnnualAmount SP"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(73209575; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(73209576; "ML_Merged Unit ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                LeaseProposal: Record "Contract Renewal";
            begin
                if LeaseProposal.Get("ID", "ML_Merged Unit ID") then begin
                    Rec."ML_Start Date" := LeaseProposal."Contract Start Date";
                    Rec."ML_End Date" := LeaseProposal."Contract End Date";
                    Rec."ML_Unit Sq Ft" := LeaseProposal."Unit Sq. Feet";
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
            CalcFormula = sum("CR Merge LumAnnualAmount SP"."ML_Final Annual Amount" where("Id" = field(ID)));
        }
        field(73209592; "TotalAnnualAmount"; Decimal)
        {

            FieldClass = FlowField;
            CalcFormula = sum("CR Merge LumAnnualAmount SP"."ML_Annual Amount" where("Id" = field("Id")));
        }
        field(73209593; "TotalRoundOff"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("CR Merge LumAnnualAmount SP"."ML_Round off" where("Id" = field("Id")));
        }
        field(73209594; "TotalFirstAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("CR Merge LumAnnualAmount SP"."ML_Final Annual Amount" where("Id" = field("Id"), ML_Year = const(1)));
        }

    }

    keys
    {
        key(PK; "ID", "ML_Line No.")
        {
            Clustered = true;
        }
    }
}
