tableextension 73209587 "BLRSales Invoice Header Ext" extends "Sales Invoice Header"
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
        field(73209579; "BLRApproval Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Approved,Rejected;
            Caption = 'Approval Status';
        }
        field(73209580; "BLRTenant Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Name';
        }
        field(73209581; "BLRCustomer P.O"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer P.O';
        }
        field(73209582; "BLRCustomer P.O Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Customer P.O Date';
        }
        field(73209583; "BLRContract Period"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Period';
        }
        field(73209584; "BLRReason For Rejection"; Text[1000])
        {
            DataClassification = CustomerContent;
            Caption = 'Reason For Rejection';
        }
        field(73209585; "BLRView Invoice"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'View Invoice';
        }
        field(73209586; "BLRView Document URL"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'View Document URL';
        }
        field(73209587; "BLROverdue Invoice"; Text[20])
        {
            Caption = 'Overdue Invoice';
            DataClassification = CustomerContent;
        }
        field(73209588; "BLRFC ID"; Integer)
        {
            Caption = 'FC ID';
            DataClassification = CustomerContent;
        }
    }
    trigger OnAfterInsert()
    var
        paymentschedule2: Record "BLRPaymentSchedule2";
        paymentschedule2Rec: Record "BLRPaymentSchedule2";
        additionalcharges: Record "BLRAdditionalChargesSub";
        billingcalculationgrid: Record "BLRFinalBillingCalculationGrid";
        InvoiceCreditNoteSummaryRec: Record "BLRInvoiceCreditNoteSummary";
    begin
        paymentschedule2.SetRange("BLRContract ID", Rec."BLRContract ID");
        paymentschedule2.SetRange("BLRInvoice ID", Rec."Pre-Assigned No.");
        if paymentschedule2.FindSet() then
            repeat
                paymentschedule2."BLRInvoice ID" := Rec."No.";
                paymentschedule2.Modify();
            until paymentschedule2.Next() = 0;

        paymentschedule2Rec.SetRange("BLRContract ID", Rec."BLRContract ID");
        paymentschedule2Rec.SetRange("BLRInvoice ID", Rec."No.");
        if paymentschedule2Rec.FindSet() then
            repeat
                paymentschedule2Rec."BLRInvoice Approval Status" := Rec."BLRApproval Status";
                paymentschedule2Rec.Modify();
            until paymentschedule2Rec.Next() = 0;

        additionalcharges.SetRange("BLRContract ID", Rec."BLRContract ID");
        additionalcharges.SetRange("BLRInvoiced ID", Rec."Pre-Assigned No.");
        if additionalcharges.FindSet() then
            repeat
                additionalcharges."BLRInvoiced ID" := Rec."No.";
                additionalcharges."BLRPosted Invoice ID" := Rec."No.";
                additionalcharges.Modify();
            until additionalcharges.Next() = 0;

        billingcalculationgrid.SetRange("BLRContract ID", Rec."BLRContract ID");
        billingcalculationgrid.SetRange("BLRInvoice ID", Rec."Pre-Assigned No.");
        if billingcalculationgrid.FindSet() then
            repeat
                billingcalculationgrid."BLRInvoice ID" := Rec."No.";
                billingcalculationgrid."BLRPosted Invoice ID" := Rec."No.";
                billingcalculationgrid.Modify();
            until billingcalculationgrid.Next() = 0;

        InvoiceCreditNoteSummaryRec.SetRange("BLRContract No.", Rec."BLRContract ID");
        InvoiceCreditNoteSummaryRec.SetRange("BLRInvoice ID", Rec."Pre-Assigned No.");
        if InvoiceCreditNoteSummaryRec.FindSet() then
            repeat
                InvoiceCreditNoteSummaryRec."BLRInvoice ID" := Rec."No.";
                InvoiceCreditNoteSummaryRec.Modify();
            until InvoiceCreditNoteSummaryRec.Next() = 0;
    end;
}
