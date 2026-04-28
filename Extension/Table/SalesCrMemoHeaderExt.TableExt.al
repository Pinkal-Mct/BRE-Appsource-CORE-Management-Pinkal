tableextension 73209585 "Sales Cr. Memo Header Ext" extends "Sales Cr.Memo Header"
{
    fields
    {
        field(73209575; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }

        field(73209576; "Property Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Name';

        }
        field(73209577; "Unit Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Name';
        }
        field(73209578; "Contract Tenure"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Tenure';
        }

        field(73209583; "Contract Period"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Period';
        }
        field(73209580; "View Invoice"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'View Credit Note';
        }
        field(73209589; "Property Classification"; Text[40])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Classification';
        }
        field(73209582; "Approval Status for CreditNote"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Approved,Rejected;
            Caption = 'Approval Status for CreditNote';
        }

        field(73209584; "Credit Memo Document"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Memo Document';
        }
        field(73209585; "Credit Memo URL"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Memo No';
        }
        field(73209586; "Contract Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Amount';
        }
        field(73209587; "Terminated Credit Note"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Terminated Credit Note';
        }
        field(73209588; "Rejection Reason CreditNote"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Rejection Reason CreditNote';
        }
    }

    trigger OnAfterInsert()
    var
        Requestcreditnotegrid: Record "Request Credit Note Grid";
        Requestcreditnotegrid1: Record "Request Credit Note Grid";
        Requestcreditnotegrid2: Record "Request Credit Note Grid";
        paymentmodegrid: Record "Payment Mode2";
        paymentschedulegrid: Record "Payment Schedule2";
        PendingReceviableGrid: Record "Pending Receviable Grid";
        finaladjustmentReduction: Record "FinancialAdjContractReduction";
        InvoiceCreditNoteSummaryRec: Record "InvoiceCreditNoteSummary";
        BillingCalculationCNRec: Record "Final Billing Calculation Grid";
    begin
        Requestcreditnotegrid.SetRange("Credit Note No.", "Pre-Assigned No.");
        Requestcreditnotegrid.SetRange("Contract ID", "Contract ID");
        Requestcreditnotegrid.SetRange("Credit Memo Generated", true);
        if Requestcreditnotegrid.FindSet() then
            repeat
                Requestcreditnotegrid."Credit Note No." := "No.";
                Requestcreditnotegrid.Modify();
            until Requestcreditnotegrid.Next() = 0;

        paymentmodegrid.SetRange("Contract ID", "Contract ID");
        if paymentmodegrid.FindSet() then
            repeat
                paymentmodegrid."Credit Note Amount" := 0;
                Requestcreditnotegrid1.SetRange("Contract ID", paymentmodegrid."Contract ID");
                Requestcreditnotegrid1.SetRange("Payment Series", paymentmodegrid."Payment Series");
                Requestcreditnotegrid1.SetRange("Credit Memo Generated", true);
                if Requestcreditnotegrid1.FindSet() then
                    repeat
                        paymentmodegrid."Credit Note No." := Requestcreditnotegrid1."Credit Note No.";
                        paymentmodegrid."Credit Note Amount" += Requestcreditnotegrid1."Total Reduction";
                        paymentmodegrid.Modify();
                    until Requestcreditnotegrid1.Next() = 0;
            until paymentmodegrid.Next() = 0;

        paymentschedulegrid.SetRange("Contract ID", "Contract ID");
        if paymentschedulegrid.FindSet() then
            repeat
                Requestcreditnotegrid2.SetRange("Contract ID", paymentschedulegrid."Contract ID");
                Requestcreditnotegrid2.SetRange("Payment Series", paymentschedulegrid."Payment Series");
                Requestcreditnotegrid2.SetRange(Charges, paymentschedulegrid."Secondary Item Type");
                Requestcreditnotegrid2.SetRange("Credit Memo Generated", true);
                if Requestcreditnotegrid2.FindFirst() then begin
                    paymentschedulegrid."Credit Note No." := Requestcreditnotegrid2."Credit Note No.";
                    paymentschedulegrid."Credit Note Amount" := Requestcreditnotegrid2."Total Reduction";
                    paymentschedulegrid.Modify();
                end;
            until paymentschedulegrid.Next() = 0;

        PendingReceviableGrid.SetRange("Contract ID", "Contract ID");
        PendingReceviableGrid.SetRange("CrditNoteID Security Deposit", "Pre-Assigned No.");
        if PendingReceviableGrid.FindSet() then
            repeat
                PendingReceviableGrid."CrditNoteID Security Deposit" := "No.";
                PendingReceviableGrid.Modify();
            until PendingReceviableGrid.Next() = 0;

        finaladjustmentReduction.SetRange("Contract No.", "Contract ID");
        finaladjustmentReduction.SetRange("Credit Note ID", "Pre-Assigned No.");
        if finaladjustmentReduction.FindSet() then
            repeat
                finaladjustmentReduction."Credit Note ID" := "No.";
                finaladjustmentReduction.Modify();
            until finaladjustmentReduction.Next() = 0;

        InvoiceCreditNoteSummaryRec.SetRange("Contract No.", "Contract ID");
        InvoiceCreditNoteSummaryRec.SetRange("Credit Note ID", "Pre-Assigned No.");
        if InvoiceCreditNoteSummaryRec.FindSet() then
            repeat
                InvoiceCreditNoteSummaryRec."Credit Note ID" := "No.";
                InvoiceCreditNoteSummaryRec.Modify();
            until InvoiceCreditNoteSummaryRec.Next() = 0;

        BillingCalculationCNRec.SetRange("Contract ID", "Contract ID");
        BillingCalculationCNRec.SetRange("Credit Note ID", "Pre-Assigned No.");
        if BillingCalculationCNRec.FindSet() then
            repeat
                BillingCalculationCNRec."Credit Note ID" := "No.";
                BillingCalculationCNRec.Modify();
            until BillingCalculationCNRec.Next() = 0;
    end;
}
