table 73209575 "BLRAdditionalChargesSub"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209576; "BLRSecondary Item Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Secondary Item';
            TableRelation = Item WHERE("BLRItem type template" = const("BLRItem Type Template Enum"::"Secondary Item"), "BLRCharges Status" = CONST("Additional Charges"));
            trigger OnValidate()
            var
                SecondaryItemRec: Record "Item";
            begin
                SecondaryItemRec.SetRange("No.", Rec."BLRSecondary Item Type");
                if SecondaryItemRec.FindFirst() then begin
                    "BLRSecondary Item Type" := SecondaryItemRec.Description;
                    "BLRVAT %" := SecondaryItemRec."BLRVAT %";
                end else
                    "BLRVAT %" := 0;
            end;
        }
        field(73209577; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
            Caption = 'Amount';
            trigger OnValidate()
            begin
                CalcVATAndTotal();
            end;
        }
        field(73209578; "BLRVAT %"; Option)
        {
            OptionMembers = "0%","5%";
            Caption = 'VAT %';
            Editable = false;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                CalcVATAndTotal();
            end;
        }
        field(73209579; "BLRVAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
            Caption = 'VAT Amount';
            Editable = false;
            trigger OnValidate()
            var
                vatPer: Integer;
            begin
                if "BLRVAT %" = "BLRVAT %"::"5%" then
                    vatPer := 5
                else
                    vatPer := 0;
                "BLRVAT Amount" := "BLRAmount" * (vatPer / 100);
            end;
        }
        field(73209580; "BLRAmount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
            Caption = 'Amount Including VAT';
            Editable = false;
            trigger OnValidate()
            begin
                "BLRAmount Including VAT" := "BLRAmount" + "BLRVAT Amount";
            end;
        }
        field(73209581; "BLRStart Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
            Editable = True;
        }
        field(73209582; "BLREnd Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
            Editable = True;
        }
        field(73209583; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209584; "BLRTenant ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
        }
        field(73209585; "BLRTotal Amount"; Decimal)
        {
            Caption = 'Total Amount';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("BLRAdditionalChargesSub"."BLRAmount Including VAT" where("BLRContract ID" = field("BLRContract ID"), "BLRTenant ID" = field("BLRTenant ID")));
        }
        field(73209586; "BLRInvoiced"; Boolean)
        {
            Caption = 'Invoiced';
            DataClassification = CustomerContent;
        }
        field(73209587; "BLRInvoiced ID"; Code[20])
        {
            Caption = 'Invoice ID';
            DataClassification = CustomerContent;
        }
        field(73209588; "BLRUnit Type"; Text[20])
        {
            Caption = 'Unit Type';
            DataClassification = CustomerContent;
        }
        field(73209589; "BLRPosted Invoice ID"; Code[20])
        {
            Caption = 'Invoice ID';
            DataClassification = CustomerContent;
        }
        field(73209590; "BLRInvoice Document"; Text[250])
        {
            Caption = 'Invoice Document';
            DataClassification = CustomerContent;
        }
        field(73209591; "BLRInvoice Document URL"; Text[250])
        {
            Caption = 'Invoice Document URL';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "BLREntry No.", "BLRContract ID")
        {
            Clustered = true;
        }
    }
    local procedure CalcVATAndTotal()
    var
        finalCalculation: Record "BLRFinalCalculation";
        InvoiceCreditNoteSummaryRec: Record "BLRInvoiceCreditNoteSummary";
        vatPer: Integer;
    begin
        if "BLRVAT %" = "BLRVAT %"::"5%" then
            vatPer := 5
        else
            vatPer := 0;
        "BLRVAT Amount" := "BLRAmount" * (vatPer / 100);
        "BLRAmount Including VAT" := "BLRAmount" + "BLRVAT Amount";
        Rec.Modify();

        finalCalculation.SetRange("BLRContract ID", Rec."BLRContract ID");
        if finalCalculation.FindFirst() then
            finalCalculation.CalculateFinalSummary(finalCalculation);

        InvoiceCreditNoteSummaryRec.CalculateTotalInvoiceAmount(Rec);
    end;

    trigger OnDelete()
    var
        finalcalculationRec: Record "BLRFinalCalculation";
        InvoiceCreditNoteSummaryRec: Record "BLRInvoiceCreditNoteSummary";
    begin
        finalcalculationRec.SetRange("BLRContract ID", Rec."BLRContract ID");
        if finalcalculationRec.FindFirst() then begin
            finalcalculationRec."BLRTotal Claim" -= Rec."BLRAmount Including VAT";
            finalcalculationRec."BLRSummery Net Balance" := finalcalculationRec."BLRTotal Claim" - finalcalculationRec."BLRTotal Refund";

            finalcalculationRec."BLRAmount Refundable" := 0;
            finalcalculationRec."BLRNetRecvFromTheTenant" := 0;
            if finalcalculationRec."BLRSummery Net Balance" < 0 then begin
                finalcalculationRec."BLRAmount Refundable" := Abs(finalcalculationRec."BLRSummery Net Balance");
                finalcalculationRec."BLRNetRecvFromTheTenant" := 0;
            end
            else
                finalcalculationRec."BLRNetRecvFromTheTenant" := finalcalculationRec."BLRSummery Net Balance";

            finalcalculationRec.Modify();
        end;

        InvoiceCreditNoteSummaryRec.SetRange("BLRContract No.", Rec."BLRContract ID");
        InvoiceCreditNoteSummaryRec.SetRange("BLRDescription", 'Termination Additional Charges');
        if InvoiceCreditNoteSummaryRec.FindFirst() then
            InvoiceCreditNoteSummaryRec."BLRInvoice" -= Rec."BLRAmount Including VAT";

        InvoiceCreditNoteSummaryRec.Modify();
    end;
}
