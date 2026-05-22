table 73209697 "BLRTCMergeLumAnnualAmountSP"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "BLRID"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209576; "BLRML_Merged Unit ID"; Code[100])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                LeaseProposal: Record "BLRContractRenewal";
            begin
                if LeaseProposal.Get("BLRID", "BLRML_Merged Unit ID") then begin
                    Rec."BLRML_Start Date" := LeaseProposal."BLRContract Start Date";
                    Rec."BLRML_End Date" := LeaseProposal."BLRContract End Date";
                    Rec."BLRML_Unit Sq Ft" := LeaseProposal."BLRUnit Sq. Feet";
                    Rec."BLRML_Rate per Sq.Ft" := LeaseProposal."BLRRent Amount";
                    Rec."BLRML_Merged Unit ID" := LeaseProposal."BLRUnit Name";
                    Rec."BLRML_Number of Days" := Rec."BLRML_End Date" - Rec."BLRML_Start Date";
                    Modify(true);
                end else
                    Error('No matching Lease Proposal found for the selected Unit ID.');
            end;
        }
        field(73209577; "BLRML_Unit ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209578; "BLRML_Year"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209579; "BLRML_Start Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209580; "BLRML_End Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209581; "BLRML_Number of Days"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209582; "BLRML_Unit Sq Ft"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209583; "BLRML_Rate per Sq.Ft"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209584; "BLRML_Rent Increase %"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209585; "BLRML_Annual Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209586; "BLRML_Round off"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209587; "BLRML_Final Annual Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209588; "BLRML_Per Day Rent"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209589; "BLRMerge Lumpsum Rent1"; Code[100])
        {
            DataClassification = CustomerContent;
            InitValue = 'Click Here For Get Data.';
            Caption = 'Click Here For Get Data.';
        }
        field(73209590; "BLRML_Line No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }


        field(73209591; "BLRTotalFinalAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("BLRTCMergeLumAnnualAmountSP"."BLRML_Final Annual Amount" where("BLRID" = field("BLRID")));


        }
        field(73209592; "BLRTotalAnnualAmount"; Decimal)
        {

            FieldClass = FlowField;
            CalcFormula = sum("BLRTCMergeLumAnnualAmountSP"."BLRML_Annual Amount" where("BLRID" = field("BLRID")));

        }
        field(73209593; "BLRTotalRoundOff"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("BLRTCMergeLumAnnualAmountSP"."BLRML_Round off" where("BLRID" = field("BLRID")));

        }

        field(73209594; "BLRTotalFirstAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("BLRTCMergeLumAnnualAmountSP"."BLRML_Final Annual Amount" where("BLRID" = field("BLRID"), "BLRML_Year" = const(1)));
        }
        field(73209595; "BLRContract Id"; Integer)
        {
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(PK;"BLRID", "BLRML_Line No.")
        {
            Clustered = true;
        }
    }
}
