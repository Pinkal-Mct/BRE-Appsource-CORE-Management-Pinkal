table 73209617 "Final Calculation"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';


        }
        field(73209576; "ContractYear(Termination Date)"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Year On Termination Date';

        }

        field(73209577; "FC ID"; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }

        field(73209578; "Contract Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start Date';

        }

        field(73209579; "Contract End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract End Date';

        }

        field(73209580; "Unit Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Type';

        }

        field(73209581; "Contract Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Amount';

        }

        field(73209582; "Tenant ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';

            TableRelation = "Lease Proposal Details"."Tenant ID";
        }
        field(73209583; "Intimation Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Intimation Date';

        }
        field(73209584; "Termination Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Termination Date';

            trigger OnValidate()
            var
                StartDate: Date;
                TerminateDate: Date;
            begin
                if ("Contract Start Date" = 0D) or ("Contract End Date" = 0D) then
                    Error('Contract Start and End Date must be defined first.');

                StartDate := "Contract Start Date";
                TerminateDate := "Termination Date";

                if TerminateDate > "Contract End Date" then
                    Error('Termination Date cannot be greater than Contract End Date.');

                if TerminateDate = "Contract End Date" then
                    "Termination Status" := "Termination Status"::"Regular Termination"
                else
                    "Termination Status" := "Termination Status"::"Early Termination";

                "Actual Contract Tenure" :=
                    TerminateDate - StartDate + 1;
            end;
        }

        field(73209585; "Original Contract Tenure"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Original Contract Tenure';

        }

        field(73209586; "Actual Contract Tenure"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Actual Contract Tenure';

        }

        field(73209587; "Total No. Of Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Total No. Of Days(Termination Year)';

        }


        field(73209588; "Per Day Rent"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Per Day Rent(Termination Year)';

        }

        field(73209589; "Annual Rent Amount TermiYear"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Annual Rent Amount of Termination Year';
        }

        field(73209590; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Pending,Approved,Rejected;
        }

        field(73209591; "Security Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Security Deposit';
        }
        field(73209592; "Adjustment Security Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Adjustment Security Deposit';
        }
        field(73209593; "Net Balance"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Net Balance';
        }
        field(73209594; "Chiller Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Chiller Deposit';
        }
        field(73209595; "Other Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Other Deposit';
        }

        field(73209596; "Termination Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Regular Termination","Early Termination","Suspension to Termination";
            Editable = false;
        }

        field(73209597; "Total Refundable Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209598; "Total Claim"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Claim';
        }
        field(73209599; "Total Refund"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Refund';
        }
        field(73209600; "Summery Net Balance"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Net Balance';
        }
        field(73209601; "Amount Refundable"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount Refundable To The Tenant';
        }
        field(73209602; "Net Receivable From The Tenant"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Net Receivable From The Tenant';
        }
        field(73209603; "Total Receive"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Receive';
        }

        field(73209604; "Final Calculation Document"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Final Calculation Document';
            InitValue = 'Final Calculation Document';
        }

        field(73209605; "Total Adjustment"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Adjustment';
        }
        field(73209606; "Final Calculation URL"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Final Calculaion URL';
        }
        field(73209607; "Tenant Email"; Text[250])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Email';
        }
        field(73209608; "Tenant Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Name';
        }
        field(73209609; "Credit Note Document"; Text[1000])
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note Document';
            InitValue = 'Credit Note Document';
        }
        field(73209610; "Credit Note URL"; Text[1000])
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note View';
            InitValue = 'Credit Note View';
        }
        field(73209611; "Updated Payments"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated Payments';
            Editable = false;
        }

        field(73209612; "Final Payments"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Final Payments';
            Editable = false;
        }
        field(73209613; "Remaining Security Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Remaining Security Deposit';
        }

        field(73209614; "Remaining Chiller Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Remaining Chiller Deposit';
        }
        field(73209615; "Remaining Other Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Remaining Other Deposit';
        }
        field(73209616; "Credit Not To Be Raised"; Decimal)
        {
            Caption = 'Credit Note To Be Raised';
            FieldClass = FlowField;
            CalcFormula = sum(FinancialAdjContractReduction."Amount Incl. VAT" where("Contract No." = field("Contract ID")));
        }
    }



    keys
    {
        key(PK; "FC ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Contract ID", "FC ID")
        {

        }
    }
    trigger OnDelete()
    var
    begin
        DeleteFinalcalculationlink();
        deletefinalrevenuecalculation();
        deletebillingcaculation();
        PendingreceivablePayable();
        TerminationAdditionalCharges();
        RentCalculationGrid();
        RevenueStructureGrid();
        RevenueStructureyearlyBrokdownGrid();
        finalsettlement();
        finalsettlementrefund();
        DeleteAdjustmentDeposits();
        finaladjustmentreduction();
        invoicecreditnotesummary();
    end;

    procedure DeleteFinalcalculationlink()
    var
        TenancyContractRec: Record "Tenancy Contract";
    begin
        TenancyContractRec.SetRange("Contract ID", Rec."Contract ID");
        if TenancyContractRec.FindFirst() then begin
            TenancyContractRec.Link := 0;
            TenancyContractRec.Modify();
        end;
    end;

    procedure deletefinalrevenuecalculation()
    var
        finalrevenuecalculation: Record "Final Revenue Calculation Grid";

    begin
        finalrevenuecalculation.SetRange("Contract Id", Rec."Contract ID");
        if finalrevenuecalculation.FindSet() then
            finalrevenuecalculation.DeleteAll();

    end;

    procedure deletebillingcaculation()
    var
        billingcalculation: Record "Final Billing Calculation Grid";
    begin
        billingcalculation.SetRange("Contract ID", rec."Contract ID");
        if billingcalculation.FindSet() then
            billingcalculation.DeleteAll();
    end;

    procedure PendingreceivablePayable()
    var
        pendingRecevieable: Record "Pending Receviable Grid";
    begin
        pendingRecevieable.SetRange("Contract ID", Rec."Contract ID");
        if pendingRecevieable.FindSet() then
            pendingRecevieable.DeleteAll();
    end;

    procedure TerminationAdditionalCharges()
    var
        TerminationAdditional: Record "Additional Charges Sub";
    begin
        TerminationAdditional.SetRange("Contract ID", Rec."Contract ID");
        if TerminationAdditional.FindSet() then
            TerminationAdditional.DeleteAll();
    end;

    procedure RentCalculationGrid()
    var
        RentCalculation: Record "Rent Calculate Sub";
    begin
        RentCalculation.SetRange("Contract ID", Rec."Contract ID");
        if RentCalculation.FindSet() then
            RentCalculation.DeleteAll();
    end;

    procedure RevenueStructureGrid()
    var
        RevenueStructureyearlyBrokdown: Record "Other Payment Calculate Sub";
    begin
        RevenueStructureyearlyBrokdown.SetRange("Contract ID", Rec."Contract ID");
        if RevenueStructureyearlyBrokdown.FindSet() then
            RevenueStructureyearlyBrokdown.DeleteAll();
    end;

    procedure RevenueStructureyearlyBrokdownGrid()
    var
        RevenueStructure: Record "Revenue Calculate Sub";
    begin
        RevenueStructure.SetRange("Contract ID", Rec."Contract ID");
        if RevenueStructure.FindSet() then
            RevenueStructure.DeleteAll();
    end;


    procedure Deletepaymentdetails()
    var
        paymentdetails: Record "Payment Details";
    begin
        paymentdetails.SetRange("Contract ID", Rec."Contract ID");
        if paymentdetails.FindSet() then
            paymentdetails.DeleteAll();
    end;

    procedure finalsettlement()
    var
        finalsettlementRec: Record FinalSettlement;

    begin
        finalsettlementRec.SetRange("FC Id", Rec."FC ID");
        if finalsettlementRec.FindSet() then
            finalsettlementRec.DeleteAll();
    end;

    procedure finalsettlementrefund()
    var
        finalsettlementrefundRec: Record FinalSettlementRefund;

    begin
        finalsettlementrefundRec.SetRange("FC Id", Rec."FC ID");
        if finalsettlementrefundRec.FindSet() then
            finalsettlementrefundRec.DeleteAll();
    end;

    procedure DeleteAdjustmentDeposits()
    var
        adjustmentDepositsRec: Record "Adjustment Deposits";
    begin
        adjustmentDepositsRec.SetRange("Contract Id", Rec."Contract ID");
        if adjustmentDepositsRec.FindSet() then
            adjustmentDepositsRec.DeleteAll();
    end;

    procedure finaladjustmentreduction()
    var
        finaladjustmentReductionRec: Record "FinancialAdjContractReduction";
    begin
        finaladjustmentReductionRec.SetRange("Contract No.", Rec."Contract ID");
        if finaladjustmentReductionRec.FindSet() then
            finaladjustmentReductionRec.DeleteAll();
    end;

    procedure invoicecreditnotesummary()
    var
        invoicecreditnotesummaryRec: Record "InvoiceCreditNoteSummary";
    begin
        invoicecreditnotesummaryRec.SetRange("Contract No.", Rec."Contract ID");
        if invoicecreditnotesummaryRec.FindSet() then
            invoicecreditnotesummaryRec.DeleteAll();
    end;

    procedure CalculateFinalSummary(var pFinalCalculation: Record "Final Calculation")
    var
        PendingReceivableGrid: Record "Pending Receviable Grid";
        TerminationAddCharges: Record "Additional Charges Sub";
        totalDifferenceAmountInclVAT: Decimal;
        TotalRefundableAmount: Decimal;
        TotalReceivableAmount: Decimal;
    begin
        PendingReceivableGrid.Reset();

        PendingReceivableGrid.SetRange("Contract ID", pFinalCalculation."Contract ID");
        if PendingReceivableGrid.FindSet() then
            repeat
                totalDifferenceAmountInclVAT += PendingReceivableGrid.DifferenceAmountInclVAT;
            until PendingReceivableGrid.Next() = 0;

        if totalDifferenceAmountInclVAT > 0 then
            TotalReceivableAmount := totalDifferenceAmountInclVAT
        else
            TotalRefundableAmount := Abs(totalDifferenceAmountInclVAT);

        TerminationAddCharges.Reset();
        TerminationAddCharges.SetRange("Contract ID", pFinalCalculation."Contract ID");
        if TerminationAddCharges.FindFirst() then begin
            TerminationAddCharges.CalcSums("Amount Including VAT");
            TotalReceivableAmount += TerminationAddCharges."Amount Including VAT";
        end;

        pFinalCalculation.CalcFields("Credit Not To Be Raised");
        TotalReceivableAmount -= pFinalCalculation."Credit Not To Be Raised";

        TotalRefundableAmount += pFinalCalculation."Total Refundable Deposit";

        pFinalCalculation."Total Claim" := TotalReceivableAmount;
        pFinalCalculation."Total Refund" := TotalRefundableAmount;

        pFinalCalculation."Summery Net Balance" := pFinalCalculation."Total Claim" - pFinalCalculation."Total Refund";

        if pFinalCalculation."Summery Net Balance" < 0 then begin
            pFinalCalculation."Amount Refundable" := Abs(pFinalCalculation."Summery Net Balance");
            pFinalCalculation."Net Receivable From The Tenant" := 0;
        end
        else begin
            pFinalCalculation."Net Receivable From The Tenant" := Abs(pFinalCalculation."Summery Net Balance");
            pFinalCalculation."Amount Refundable" := 0;
        end;
        pFinalCalculation.Modify();
    end;
}





