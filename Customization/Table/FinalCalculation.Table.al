table 73209617 "BLRFinalCalculation"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';


        }
        field(73209576; "BLRContYearTermDate"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Year On Termination Date';

        }

        field(73209577; "BLRFC ID"; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }

        field(73209578; "BLRContract Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start Date';

        }

        field(73209579; "BLRContract End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract End Date';

        }

        field(73209580; "BLRUnit Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Type';

        }

        field(73209581; "BLRContract Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Amount';

        }

        field(73209582; "BLRTenant ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';

            TableRelation = "BLRLeaseProposalDetails"."BLRTenant ID";
        }
        field(73209583; "BLRIntimation Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Intimation Date';

        }
        field(73209584; "BLRTermination Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Termination Date';

            trigger OnValidate()
            var
                StartDate: Date;
                TerminateDate: Date;
            begin
                if ("BLRContract Start Date" = 0D) or ("BLRContract End Date" = 0D) then
                    Error('Contract Start and End Date must be defined first.');

                StartDate := "BLRContract Start Date";
                TerminateDate := "BLRTermination Date";

                if TerminateDate > "BLRContract End Date" then
                    Error('Termination Date cannot be greater than "BLRContract End Date".');

                if TerminateDate = "BLRContract End Date" then
                    "BLRTermination Status" := "BLRTermination Status"::"Regular Termination"
                else
                    "BLRTermination Status" := "BLRTermination Status"::"Early Termination";

                "BLRActual Contract Tenure" :=
                    TerminateDate - StartDate + 1;
            end;
        }

        field(73209585; "BLROriginal Contract Tenure"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Original Contract Tenure';

        }

        field(73209586; "BLRActual Contract Tenure"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Actual Contract Tenure';

        }

        field(73209587; "BLRTotal No. Of Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Total No. Of Days(Termination Year)';

        }


        field(73209588; "BLRPer Day Rent"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Per Day Rent(Termination Year)';

        }

        field(73209589; "BLRAnnualRentAmtTermiYear"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Annual Rent Amount of Termination Year';
        }

        field(73209590; "BLRStatus"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Pending,Approved,Rejected;
        }

        field(73209591; "BLRSecurity Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Security Deposit';
        }
        field(73209592; "BLRAdjustment Security Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Adjustment Security Deposit';
        }
        field(73209593; "BLRNet Balance"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Net Balance';
        }
        field(73209594; "BLRChiller Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Chiller Deposit';
        }
        field(73209595; "BLROther Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Other Deposit';
        }

        field(73209596; "BLRTermination Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Regular Termination","Early Termination","Suspension to Termination";
            Editable = false;
        }

        field(73209597; "BLRTotal Refundable Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209598; "BLRTotal Claim"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Claim';
        }
        field(73209599; "BLRTotal Refund"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Refund';
        }
        field(73209600; "BLRSummery Net Balance"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Net Balance';
        }
        field(73209601; "BLRAmount Refundable"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount Refundable To The Tenant';
        }
        field(73209602; "BLRNetRecvFromTheTenant"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Net Receivable From The Tenant';
        }
        field(73209603; "BLRTotal Receive"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Receive';
        }

        field(73209604; "BLRFinal Calculation Document"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Final Calculation Document';
            InitValue = 'Final Calculation Document';
        }

        field(73209605; "BLRTotal Adjustment"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Adjustment';
        }
        field(73209606; "BLRFinal Calculation URL"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Final Calculaion URL';
        }
        field(73209607; "BLRTenant Email"; Text[250])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Email';
        }
        field(73209608; "BLRTenant Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Name';
        }
        field(73209609; "BLRCredit Note Document"; Text[1000])
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note Document';
            InitValue = 'Credit Note Document';
        }
        field(73209610; "BLRCredit Note URL"; Text[1000])
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note View';
            InitValue = 'Credit Note View';
        }
        field(73209611; "BLRUpdated Payments"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated Payments';
            Editable = false;
        }

        field(73209612; "BLRFinal Payments"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Final Payments';
            Editable = false;
        }
        field(73209613; "BLRRemaining Security Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Remaining Security Deposit';
        }

        field(73209614; "BLRRemaining Chiller Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Remaining Chiller Deposit';
        }
        field(73209615; "BLRRemaining Other Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Remaining Other Deposit';
        }
        field(73209616; "BLRCredit Not To Be Raised"; Decimal)
        {
            Caption = 'Credit Note To Be Raised';
            FieldClass = FlowField;
            CalcFormula = sum("BLRFinAdjContractReduction"."BLRAmount Incl. VAT" where("BLRContract No." = field("BLRContract ID")));
        }
    }



    keys
    {
        key(PK;"BLRFC ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"BLRContract ID", "BLRFC ID")
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
        TenancyContractRec: Record "BLRTenancyContract";
    begin
        TenancyContractRec.SetRange("BLRContract ID", Rec."BLRContract ID");
        if TenancyContractRec.FindFirst() then begin
            TenancyContractRec."BLRLink" := 0;
            TenancyContractRec.Modify();
        end;
    end;

    procedure deletefinalrevenuecalculation()
    var
        finalrevenuecalculation: Record "BLRFinalRevenueCalculationGrid";

    begin
        finalrevenuecalculation.SetRange("BLRContract ID", Rec."BLRContract ID");
        if finalrevenuecalculation.FindSet() then
            finalrevenuecalculation.DeleteAll();

    end;

    procedure deletebillingcaculation()
    var
        billingcalculation: Record "BLRFinalBillingCalculationGrid";
    begin
        billingcalculation.SetRange("BLRContract ID", rec."BLRContract ID");
        if billingcalculation.FindSet() then
            billingcalculation.DeleteAll();
    end;

    procedure PendingreceivablePayable()
    var
        pendingRecevieable: Record "BLRPendingReceviableGrid";
    begin
        pendingRecevieable.SetRange("BLRContract ID", Rec."BLRContract ID");
        if pendingRecevieable.FindSet() then
            pendingRecevieable.DeleteAll();
    end;

    procedure TerminationAdditionalCharges()
    var
        TerminationAdditional: Record "BLRAdditionalChargesSub";
    begin
        TerminationAdditional.SetRange("BLRContract ID", Rec."BLRContract ID");
        if TerminationAdditional.FindSet() then
            TerminationAdditional.DeleteAll();
    end;

    procedure RentCalculationGrid()
    var
        RentCalculation: Record "BLRRentCalculateSub";
    begin
        RentCalculation.SetRange("BLRContract ID", Rec."BLRContract ID");
        if RentCalculation.FindSet() then
            RentCalculation.DeleteAll();
    end;

    procedure RevenueStructureGrid()
    var
        RevenueStructureyearlyBrokdown: Record "BLROtherPaymentCalculateSub";
    begin
        RevenueStructureyearlyBrokdown.SetRange("BLRContract ID", Rec."BLRContract ID");
        if RevenueStructureyearlyBrokdown.FindSet() then
            RevenueStructureyearlyBrokdown.DeleteAll();
    end;

    procedure RevenueStructureyearlyBrokdownGrid()
    var
        RevenueStructure: Record "BLRRevenueCalculateSub";
    begin
        RevenueStructure.SetRange("BLRContract ID", Rec."BLRContract ID");
        if RevenueStructure.FindSet() then
            RevenueStructure.DeleteAll();
    end;


    procedure Deletepaymentdetails()
    var
        paymentdetails: Record "BLRPaymentDetails";
    begin
        paymentdetails.SetRange("BLRContract ID", Rec."BLRContract ID");
        if paymentdetails.FindSet() then
            paymentdetails.DeleteAll();
    end;

    procedure finalsettlement()
    var
        finalsettlementRec: Record "BLRFinalSettlement";

    begin
        finalsettlementRec.SetRange("BLRFC ID", Rec."BLRFC ID");
        if finalsettlementRec.FindSet() then
            finalsettlementRec.DeleteAll();
    end;

    procedure finalsettlementrefund()
    var
        finalsettlementrefundRec: Record "BLRFinalSettlementRefund";

    begin
        finalsettlementrefundRec.SetRange("BLRFC ID", Rec."BLRFC ID");
        if finalsettlementrefundRec.FindSet() then
            finalsettlementrefundRec.DeleteAll();
    end;

    procedure DeleteAdjustmentDeposits()
    var
        adjustmentDepositsRec: Record "BLRAdjustmentDeposits";
    begin
        adjustmentDepositsRec.SetRange("BLRContract Id", Rec."BLRContract ID");
        if adjustmentDepositsRec.FindSet() then
            adjustmentDepositsRec.DeleteAll();
    end;

    procedure finaladjustmentreduction()
    var
        finaladjustmentReductionRec: Record "BLRFinAdjContractReduction";
    begin
        finaladjustmentReductionRec.SetRange("BLRContract No.", Rec."BLRContract ID");
        if finaladjustmentReductionRec.FindSet() then
            finaladjustmentReductionRec.DeleteAll();
    end;

    procedure invoicecreditnotesummary()
    var
        invoicecreditnotesummaryRec: Record "BLRInvoiceCreditNoteSummary";
    begin
        invoicecreditnotesummaryRec.SetRange("BLRContract No.", Rec."BLRContract ID");
        if invoicecreditnotesummaryRec.FindSet() then
            invoicecreditnotesummaryRec.DeleteAll();
    end;

    procedure CalculateFinalSummary(var pFinalCalculation: Record "BLRFinalCalculation")
    var
        PendingReceivableGrid: Record "BLRPendingReceviableGrid";
        TerminationAddCharges: Record "BLRAdditionalChargesSub";
        totalDifferenceAmountInclVAT: Decimal;
        TotalRefundableAmount: Decimal;
        TotalReceivableAmount: Decimal;
    begin
        PendingReceivableGrid.Reset();

        PendingReceivableGrid.SetRange("BLRContract ID", pFinalCalculation."BLRContract ID");
        if PendingReceivableGrid.FindSet() then
            repeat
                totalDifferenceAmountInclVAT += PendingReceivableGrid."BLRDifferenceAmountInclVAT";
            until PendingReceivableGrid.Next() = 0;

        if totalDifferenceAmountInclVAT > 0 then
            TotalReceivableAmount := totalDifferenceAmountInclVAT
        else
            TotalRefundableAmount := Abs(totalDifferenceAmountInclVAT);

        TerminationAddCharges.Reset();
        TerminationAddCharges.SetRange("BLRContract ID", pFinalCalculation."BLRContract ID");
        if TerminationAddCharges.FindFirst() then begin
            TerminationAddCharges.CalcSums("BLRAmount Including VAT");
            TotalReceivableAmount += TerminationAddCharges."BLRAmount Including VAT";
        end;

        pFinalCalculation.CalcFields("BLRCredit Not To Be Raised");
        TotalReceivableAmount -= pFinalCalculation."BLRCredit Not To Be Raised";

        TotalRefundableAmount += pFinalCalculation."BLRTotal Refundable Deposit";

        pFinalCalculation."BLRTotal Claim" := TotalReceivableAmount;
        pFinalCalculation."BLRTotal Refund" := TotalRefundableAmount;

        pFinalCalculation."BLRSummery Net Balance" := pFinalCalculation."BLRTotal Claim" - pFinalCalculation."BLRTotal Refund";

        if pFinalCalculation."BLRSummery Net Balance" < 0 then begin
            pFinalCalculation."BLRAmount Refundable" := Abs(pFinalCalculation."BLRSummery Net Balance");
            pFinalCalculation."BLRNetRecvFromTheTenant" := 0;
        end
        else begin
            pFinalCalculation."BLRNetRecvFromTheTenant" := Abs(pFinalCalculation."BLRSummery Net Balance");
            pFinalCalculation."BLRAmount Refundable" := 0;
        end;
        pFinalCalculation.Modify();
    end;
}





