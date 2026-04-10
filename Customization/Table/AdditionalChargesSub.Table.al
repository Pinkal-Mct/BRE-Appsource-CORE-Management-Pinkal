table 50902 "Additional Charges Sub"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50100; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(50101; "Secondary Item Type"; Text[100])
        {
            DataClassification = ToBeClassified;
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
        field(50102; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            Caption = 'Amount';
            trigger OnValidate()
            begin
                CalcVATAndTotal();
            end;
        }
        field(50103; "VAT %"; Option)
        {
            OptionMembers = "0%","5%";
            Caption = 'VAT %';
            Editable = false;
            trigger OnValidate()
            begin
                CalcVATAndTotal();
            end;
        }
        field(50104; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
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
        field(50105; "Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            Caption = 'Amount Including VAT';
            Editable = false;
            trigger OnValidate()
            begin
                "Amount Including VAT" := Amount + "VAT Amount";
            end;
        }
        field(50106; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';
            Editable = True;
        }
        field(50107; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';
            Editable = True;
        }
        field(50110; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(50114; "Tenant ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
        }
        field(50115; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("Additional Charges Sub"."Amount Including VAT" where("Contract ID" = field("Contract ID"), "Tenant ID" = field("Tenant ID")));
        }
        field(50116; "Invoiced"; Boolean)
        {
            Caption = 'Invoiced';
            DataClassification = ToBeClassified;
        }
        field(50117; "Invoiced ID"; Code[20])
        {
            Caption = 'Invoice ID';
            DataClassification = ToBeClassified;
        }
        field(50118; "Unit Type"; Text[20])
        {
            Caption = 'Unit Type';
            DataClassification = ToBeClassified;
        }
        field(50119; "Posted Invoice ID"; Code[20])
        {
            Caption = 'Invoice ID';
            DataClassification = ToBeClassified;
        }
        field(50120; "Invoice Document"; Text[250])
        {
            Caption = 'Invoice Document';
            DataClassification = ToBeClassified;
        }
        field(50121; "Invoice Document URL"; Text[250])
        {
            Caption = 'Invoice Document URL';
            DataClassification = ToBeClassified;
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
