table 73209609 "BLRCRSingleLumAnnualAmntSP"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "BLRID"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209576; "BLRSL_Merged Unit ID"; Code[100])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                LeaseProposal: Record "BLRContractRenewal";
            begin
                if LeaseProposal.Get("BLRID", "BLRSL_Merged Unit ID") then begin
                    Rec."BLRSL_Start Date" := LeaseProposal."BLRContract Start Date";
                    Rec."BLRSL_End Date" := LeaseProposal."BLRContract End Date";
                    Rec."BLRSL_Unit Sq Ft" := LeaseProposal."BLRUnit Sq. Feet";
                    Rec."BLRSL_Rate per Sq.Ft" := LeaseProposal."BLRRent Amount";
                    Rec."BLRSL_Merged Unit ID" := LeaseProposal."BLRUnit Name";
                    Rec."BLRSL_Number of Days" := Rec."BLRSL_End Date" - Rec."BLRSL_Start Date";
                    Modify(true);
                end else
                    Error('No matching Lease Proposal found for the selected Unit ID.');
            end;
        }
        field(73209577; "BLRSL_Unit ID"; Code[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209578; "BLRSL_Year"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209579; "BLRSL_Start Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209580; "BLRSL_End Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209581; "BLRSL_Number of Days"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209582; "BLRSL_Unit Sq Ft"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209583; "BLRSL_Rate per Sq.Ft"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209584; "BLRSL_Rent Increase %"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209585; "BLRSL_Annual Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209586; "BLRSL_Round off"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209587; "BLRSL_Final Annual Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209588; "BLRSL_Per Day Rent"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209589; "BLRSingle Lumpsum Rent1"; Code[100])
        {
            DataClassification = CustomerContent;
            InitValue = 'Click Here For Get Data.';
            Caption = 'Click Here For Get Data.';
        }
        field(73209590; "BLRSL_Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209591; "BLRTotalFinalAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("BLRCRSingleLumAnnualAmntSP"."BLRSL_Final Annual Amount" where("BLRID" = field("BLRID")));
        }

        field(73209592; "BLRTotalAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("BLRCRSingleLumAnnualAmntSP"."BLRSL_Annual Amount" where("BLRID" = field("BLRID")));
        }

        field(73209593; "BLRTotalRoundOff"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("BLRCRSingleLumAnnualAmntSP"."BLRSL_Round off" where("BLRID" = field("BLRID")));
        }


        field(73209594; "BLRTotalFirstAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("BLRCRSingleLumAnnualAmntSP"."BLRSL_Final Annual Amount" where("BLRID" = field("BLRID"), "BLRSL_Year" = const(1)));
        }

    }

    keys
    {
        key(PK;"BLRID", "BLRSL_Line No.")
        {
            Clustered = true;
        }
    }
}
