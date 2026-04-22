table 73209609 "CR Single LumAnnualAmnt SP"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(73209575; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(73209576; "SL_Merged Unit ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                LeaseProposal: Record "Contract Renewal";
            begin
                if LeaseProposal.Get("ID", "SL_Merged Unit ID") then begin
                    Rec."SL_Start Date" := LeaseProposal."Contract Start Date";
                    Rec."SL_End Date" := LeaseProposal."Contract End Date";
                    Rec."SL_Unit Sq Ft" := LeaseProposal."Unit Sq. Feet";
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
            DataClassification = ToBeClassified;
        }
        field(73209578; "SL_Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(73209579; "SL_Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(73209580; "SL_End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(73209581; "SL_Number of Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(73209582; "SL_Unit Sq Ft"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73209583; "SL_Rate per Sq.Ft"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73209584; "SL_Rent Increase %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73209585; "SL_Annual Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73209586; "SL_Round off"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73209587; "SL_Final Annual Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73209588; "SL_Per Day Rent"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73209589; "Single Lumpsum Rent1"; Code[100])
        {
            DataClassification = ToBeClassified;
            InitValue = 'Click Here For Get Data.';
            Caption = 'Click Here For Get Data.';
        }
        field(73209590; "SL_Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(73209591; "TotalFinalAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("CR Single LumAnnualAmnt SP"."SL_Final Annual Amount" where("Id" = field("Id")));
        }

        field(73209592; "TotalAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("CR Single LumAnnualAmnt SP"."SL_Annual Amount" where("Id" = field("Id")));
        }

        field(73209593; "TotalRoundOff"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("CR Single LumAnnualAmnt SP"."SL_Round off" where("Id" = field("Id")));
        }


        field(73209594; "TotalFirstAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("CR Single LumAnnualAmnt SP"."SL_Final Annual Amount" where("Id" = field("Id"), SL_Year = const(1)));
        }

    }

    keys
    {
        key(PK; "ID", "SL_Line No.")
        {
            Clustered = true;
        }
    }
}
