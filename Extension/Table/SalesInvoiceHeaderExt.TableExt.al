tableextension 73209587 "Sales Invoice Header Ext" extends "Sales Invoice Header"
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
        field(73209579; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Approved,Rejected;
            Caption = 'Approval Status';
        }
        field(73209580; "Tenant Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Name';
        }
        field(73209581; "Customer P.O"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer P.O';
        }
        field(73209582; "Customer P.O Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer P.O Date';
        }
        field(73209583; "Contract Period"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Period';
        }
        field(73209584; "Reason For Rejection"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reason For Rejection';
        }
        field(73209585; "View Invoice"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'View Invoice';
        }
        field(73209586; "View Document URL"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'View Document URL';
        }
        field(73209587; "Overdue Invoice"; Text[20])
        {
            Caption = 'Overdue Invoice';
            DataClassification = ToBeClassified;
        }
        field(73209588; "FC ID"; Integer)
        {
            Caption = 'FC ID';
            DataClassification = ToBeClassified;
        }
    }
    trigger OnAfterInsert()
    var
        paymentschedule2: Record "Payment Schedule2";
        paymentschedule2Rec: Record "Payment Schedule2";
        additionalcharges: Record "Additional Charges Sub";
        billingcalculationgrid: Record "Final Billing Calculation Grid";
        InvoiceCreditNoteSummaryRec: Record "InvoiceCreditNoteSummary";
    begin
        paymentschedule2.SetRange("Contract ID", Rec."Contract ID");
        paymentschedule2.SetRange("Invoice ID", Rec."Pre-Assigned No.");
        if paymentschedule2.FindSet() then
            repeat
                paymentschedule2."Invoice ID" := Rec."No.";
                paymentschedule2.Modify();
            until paymentschedule2.Next() = 0;

        paymentschedule2Rec.SetRange("Contract ID", Rec."Contract ID");
        paymentschedule2Rec.SetRange("Invoice ID", Rec."No.");
        if paymentschedule2Rec.FindSet() then
            repeat
                paymentschedule2Rec."Invoice Approval Status" := Rec."Approval Status";
                paymentschedule2Rec.Modify();
            until paymentschedule2Rec.Next() = 0;

        additionalcharges.SetRange("Contract ID", Rec."Contract ID");
        additionalcharges.SetRange("Invoiced ID", Rec."Pre-Assigned No.");
        if additionalcharges.FindSet() then
            repeat
                additionalcharges."Invoiced ID" := Rec."No.";
                additionalcharges."Posted Invoice ID" := Rec."No.";
                additionalcharges.Modify();
            until additionalcharges.Next() = 0;

        billingcalculationgrid.SetRange("Contract ID", Rec."Contract ID");
        billingcalculationgrid.SetRange("Invoice ID", Rec."Pre-Assigned No.");
        if billingcalculationgrid.FindSet() then
            repeat
                billingcalculationgrid."Invoice ID" := Rec."No.";
                billingcalculationgrid."Posted Invoice ID" := Rec."No.";
                billingcalculationgrid.Modify();
            until billingcalculationgrid.Next() = 0;

        InvoiceCreditNoteSummaryRec.SetRange("Contract No.", Rec."Contract ID");
        InvoiceCreditNoteSummaryRec.SetRange("Invoice ID", Rec."Pre-Assigned No.");
        if InvoiceCreditNoteSummaryRec.FindSet() then
            repeat
                InvoiceCreditNoteSummaryRec."Invoice ID" := Rec."No.";
                InvoiceCreditNoteSummaryRec.Modify();
            until InvoiceCreditNoteSummaryRec.Next() = 0;
    end;
}