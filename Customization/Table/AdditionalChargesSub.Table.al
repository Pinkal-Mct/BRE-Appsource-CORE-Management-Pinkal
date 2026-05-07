table 73209575 "Additional Charges Sub"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209576; "Secondary Item Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Secondary Item';
            TableRelation = Item WHERE("Item type template" = const("Item Type Template Enum"::"Secondary Item"), "Charges Status" = CONST("Additional Charges"));
            trigger OnValidate()
            var
                SecondaryItemRec: Record "Item";
            begin
                SecondaryItemRec.SetRange("No.", Rec."Secondary Item Type");
                if SecondaryItemRec.FindFirst() then begin
                    "Secondary Item Type" := SecondaryItemRec.Description;
                    "VAT %" := SecondaryItemRec."VAT %";
                end else
                    "VAT %" := 0;
            end;
        }
        field(73209577; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
            Caption = 'Amount';
            trigger OnValidate()
            begin
                CalcVATAndTotal();
            end;
        }
        field(73209578; "VAT %"; Option)
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
        field(73209579; "VAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
            Caption = 'VAT Amount';
            Editable = false;
            trigger OnValidate()
            var
                vatPer: Integer;
            begin
                if "VAT %" = "VAT %"::"5%" then
                    vatPer := 5
                else
                    vatPer := 0;
                "VAT Amount" := Amount * (vatPer / 100);
            end;
        }
        field(73209580; "Amount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
            Caption = 'Amount Including VAT';
            Editable = false;
            trigger OnValidate()
            begin
                "Amount Including VAT" := Amount + "VAT Amount";
            end;
        }
        field(73209581; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
            Editable = True;
        }
        field(73209582; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
            Editable = True;
        }
        field(73209583; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209584; "Tenant ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
        }
        field(73209585; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("Additional Charges Sub"."Amount Including VAT" where("Contract ID" = field("Contract ID"), "Tenant ID" = field("Tenant ID")));
        }
        field(73209586; "Invoiced"; Boolean)
        {
            Caption = 'Invoiced';
            DataClassification = CustomerContent;
        }
        field(73209587; "Invoiced ID"; Code[20])
        {
            Caption = 'Invoice ID';
            DataClassification = CustomerContent;
        }
        field(73209588; "Unit Type"; Text[20])
        {
            Caption = 'Unit Type';
            DataClassification = CustomerContent;
        }
        field(73209589; "Posted Invoice ID"; Code[20])
        {
            Caption = 'Invoice ID';
            DataClassification = CustomerContent;
        }
        field(73209590; "Invoice Document"; Text[250])
        {
            Caption = 'Invoice Document';
            DataClassification = CustomerContent;
        }
        field(73209591; "Invoice Document URL"; Text[250])
        {
            Caption = 'Invoice Document URL';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Entry No.", "Contract ID")
        {
            Clustered = true;
        }
    }
    local procedure CalcVATAndTotal()
    var
        finalCalculation: Record "Final Calculation";
        InvoiceCreditNoteSummaryRec: Record "InvoiceCreditNoteSummary";
        vatPer: Integer;
    begin
        if "VAT %" = "VAT %"::"5%" then
            vatPer := 5
        else
            vatPer := 0;
        "VAT Amount" := Amount * (vatPer / 100);
        "Amount Including VAT" := Amount + "VAT Amount";
        Rec.Modify();

        finalCalculation.SetRange("Contract ID", Rec."Contract ID");
        if finalCalculation.FindFirst() then
            finalCalculation.CalculateFinalSummary(finalCalculation);

        InvoiceCreditNoteSummaryRec.CalculateTotalInvoiceAmount(Rec);
    end;

    trigger OnDelete()
    var
        finalcalculationRec: Record "Final Calculation";
        InvoiceCreditNoteSummaryRec: Record "InvoiceCreditNoteSummary";
    begin
        finalcalculationRec.SetRange("Contract ID", Rec."Contract ID");
        if finalcalculationRec.FindFirst() then begin
            finalcalculationRec."Total Claim" -= Rec."Amount Including VAT";
            finalcalculationRec."Summery Net Balance" := finalcalculationRec."Total Claim" - finalcalculationRec."Total Refund";

            finalcalculationRec."Amount Refundable" := 0;
            finalcalculationRec."Net Receivable From The Tenant" := 0;
            if finalcalculationRec."Summery Net Balance" < 0 then begin
                finalcalculationRec."Amount Refundable" := Abs(finalcalculationRec."Summery Net Balance");
                finalcalculationRec."Net Receivable From The Tenant" := 0;
            end
            else
                finalcalculationRec."Net Receivable From The Tenant" := finalcalculationRec."Summery Net Balance";

            finalcalculationRec.Modify();
        end;

        InvoiceCreditNoteSummaryRec.SetRange("Contract No.", Rec."Contract ID");
        InvoiceCreditNoteSummaryRec.SetRange("Description", 'Termination Additional Charges');
        if InvoiceCreditNoteSummaryRec.FindFirst() then
            InvoiceCreditNoteSummaryRec.Invoice -= Rec."Amount Including VAT";

        InvoiceCreditNoteSummaryRec.Modify();
    end;
}
