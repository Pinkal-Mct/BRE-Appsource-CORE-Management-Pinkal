tableextension 73209585 "Sales Cr. Memo Header Ext" extends "Sales Cr.Memo Header"
{
    fields
    {
        field(73209575; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }

        field(73209576; "BLRProperty Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Name';

        }
        field(73209577; "BLRUnit Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Name';
        }
        field(73209578; "BLRContract Tenure"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Tenure';
        }

        field(73209583; "BLRContract Period"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Period';
        }
        field(73209580; "BLRView Invoice"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'View Invoice';
        }
        field(73209589; "BLRProperty Classification"; Text[40])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Classification';
        }
        field(73209590; "BLRApproval Status for CreditNote"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Approved,Rejected;
            Caption = 'Approval Status for CreditNote';
        }

        field(73209592; "BLRCredit Memo Document"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Memo Document';
        }
        field(73209593; "BLRCredit Memo URL"; Text[1000])
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Memo No';
        }
        field(73209594; "BLRContract Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Amount';
        }
        field(73209595; "BLRTerminated Credit Note"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Terminated Credit Note';
        }
        field(73209591; "BLRRejection Reason CreditNote"; Text[1000])
        {
            DataClassification = CustomerContent;
            Caption = 'Rejection Reason CreditNote';
        }
    }

    trigger OnAfterInsert()
    var
        Requestcreditnotegrid: Record "BLRRequestCreditNoteGrid";
        Requestcreditnotegrid1: Record "BLRRequestCreditNoteGrid";
        Requestcreditnotegrid2: Record "BLRRequestCreditNoteGrid";
        paymentmodegrid: Record "BLRPaymentMode2";
        paymentschedulegrid: Record "BLRPaymentSchedule2";
        PendingReceviableGrid: Record "BLRPendingReceviableGrid";
        finaladjustmentReduction: Record "BLRFinAdjContractReduction";
        InvoiceCreditNoteSummaryRec: Record "BLRInvoiceCreditNoteSummary";
        BillingCalculationCNRec: Record "BLRFinalBillingCalculationGrid";
    begin
        Requestcreditnotegrid.SetRange("BLRCredit Note No.", "Pre-Assigned No.");
        Requestcreditnotegrid.SetRange("BLRContract ID", "BLRContract ID");
        Requestcreditnotegrid.SetRange("BLRCredit Memo Generated", true);
        if Requestcreditnotegrid.FindSet() then
            repeat
                Requestcreditnotegrid."BLRCredit Note No." := "No.";
                Requestcreditnotegrid.Modify();
            until Requestcreditnotegrid.Next() = 0;

        paymentmodegrid.SetRange("BLRContract ID", "BLRContract ID");
        if paymentmodegrid.FindSet() then
            repeat
                paymentmodegrid."BLRCredit Note Amount" := 0;
                Requestcreditnotegrid1.SetRange("BLRContract ID", paymentmodegrid."BLRContract ID");
                Requestcreditnotegrid1.SetRange("BLRPayment Series", paymentmodegrid."BLRPayment Series");
                Requestcreditnotegrid1.SetRange("BLRCredit Memo Generated", true);
                if Requestcreditnotegrid1.FindSet() then
                    repeat
                        paymentmodegrid."BLRCredit Note No." := Requestcreditnotegrid1."BLRCredit Note No.";
                        paymentmodegrid."BLRCredit Note Amount" += Requestcreditnotegrid1."BLRTotal Reduction";
                        paymentmodegrid.Modify();
                    until Requestcreditnotegrid1.Next() = 0;
            until paymentmodegrid.Next() = 0;

        paymentschedulegrid.SetRange("BLRContract ID", "BLRContract ID");
        if paymentschedulegrid.FindSet() then
            repeat
                Requestcreditnotegrid2.SetRange("BLRContract ID", paymentschedulegrid."BLRContract ID");
                Requestcreditnotegrid2.SetRange("BLRPayment Series", paymentschedulegrid."BLRPayment Series");
                Requestcreditnotegrid2.SetRange("BLRCharges", paymentschedulegrid."BLRSecondary Item Type");
                Requestcreditnotegrid2.SetRange("BLRCredit Memo Generated", true);
                if Requestcreditnotegrid2.FindFirst() then begin
                    paymentschedulegrid."BLRCredit Note No." := Requestcreditnotegrid2."BLRCredit Note No.";
                    paymentschedulegrid."BLRCredit Note Amount" := Requestcreditnotegrid2."BLRTotal Reduction";
                    paymentschedulegrid.Modify();
                end;
            until paymentschedulegrid.Next() = 0;

        PendingReceviableGrid.SetRange("BLRContract ID", "BLRContract ID");
        PendingReceviableGrid.SetRange("BLRCrditNoteIDSecDep", "Pre-Assigned No.");
        if PendingReceviableGrid.FindSet() then
            repeat
                PendingReceviableGrid."BLRCrditNoteIDSecDep" := "No.";
                PendingReceviableGrid.Modify();
            until PendingReceviableGrid.Next() = 0;

        finaladjustmentReduction.SetRange("BLRContract No.", "BLRContract ID");
        finaladjustmentReduction.SetRange("BLRCredit Note ID", "Pre-Assigned No.");
        if finaladjustmentReduction.FindSet() then
            repeat
                finaladjustmentReduction."BLRCredit Note ID" := "No.";
                finaladjustmentReduction.Modify();
            until finaladjustmentReduction.Next() = 0;

        InvoiceCreditNoteSummaryRec.SetRange("BLRContract No.", "BLRContract ID");
        InvoiceCreditNoteSummaryRec.SetRange("BLRCredit Note ID", "Pre-Assigned No.");
        if InvoiceCreditNoteSummaryRec.FindSet() then
            repeat
                InvoiceCreditNoteSummaryRec."BLRCredit Note ID" := "No.";
                InvoiceCreditNoteSummaryRec.Modify();
            until InvoiceCreditNoteSummaryRec.Next() = 0;

        BillingCalculationCNRec.SetRange("BLRContract ID", "BLRContract ID");
        BillingCalculationCNRec.SetRange("BLRCredit Note ID", "Pre-Assigned No.");
        if BillingCalculationCNRec.FindSet() then
            repeat
                BillingCalculationCNRec."BLRCredit Note ID" := "No.";
                BillingCalculationCNRec.Modify();
            until BillingCalculationCNRec.Next() = 0;
    end;
}
