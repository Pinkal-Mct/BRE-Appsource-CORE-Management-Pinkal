table 73209703 "Tenancy Contract Subpage"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "ContractID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209576; "Secondary Item Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Secondary Item';
            TableRelation = Item where("Item Type Template" = const("Item Type Template Enum"::"Secondary Item"));
            Editable = false;
            trigger OnValidate()
            var
                SecondaryItemRec: Record Item;
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
            Caption = 'Amount Including VAT';
            Editable = false;
            trigger OnValidate()
            begin
                "Amount Including VAT" := Amount + "VAT Amount";
                UpdatedPaymentRecords();
            end;
        }
        field(73209581; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
            Editable = false;
        }
        field(73209582; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
            Editable = false;
        }
        field(73209583; "Generate Payment Schedule"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Generate Payment Schedule';
            InitValue = 'Generate Payment Schedule';
            Editable = false;
        }
        field(73209584; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209585; "Payment Type"; Option)
        {
            OptionMembers = "","One Time Payment","Installment";
            Caption = 'Payment Type';
            DataClassification = CustomerContent;
        }
        field(73209586; Invoiced; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoiced';
        }
        field(73209587; "Link"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Revenue Structure Link';
            Editable = false;
        }
        field(73209588; "TenantID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
        }
        field(73209589; "ProposalID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Proposal ID';
        }
        field(73209590; "Contract Renewal ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Renewal ID';
        }
        field(73209591; "Invoiced and Paid"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoiced and Paid';

            trigger OnValidate()
            var
                tenancyContractRec: Record "Tenancy Contract";
            begin
                if Rec."Secondary Item Type" = 'Security Deposit' then
                    if tenancyContractRec.Get("ContractID") then begin
                        tenancyContractRec.Validate("Security Deposit Amt. Received", tenancyContractRec."Carry Forward In" + "Invoiced and Paid");
                        tenancyContractRec.Modify();
                    end;
            end;
        }
    }
    keys
    {
        key(Key1; "Entry No.", ContractID)
        {
            Clustered = true;
        }
    }

    local procedure CalcVATAndTotal()
    var
        vatPer: Integer;
    begin
        if "VAT %" = "VAT %"::"5%" then
            vatPer := 5
        else
            vatPer := 0;
        "VAT Amount" := Amount * (vatPer / 100);
        "Amount Including VAT" := Amount + "VAT Amount";
    end;

    procedure UpdatedPaymentRecords()
    var
        paymentScheduleSub: Record "Payment Schedule2";
        paymentMode2: Record "Payment Mode2";
        differenceAmount: Decimal;
    begin
        paymentScheduleSub.SetRange("Contract ID", Rec.ContractID);
        paymentScheduleSub.SetRange("Secondary Item Type", Rec."Secondary Item Type");
        if paymentScheduleSub.FindFirst() then
            if Rec.Amount = 0 then begin
                differenceAmount := paymentScheduleSub.Amount;
                paymentScheduleSub.Delete()
            end
            else begin
                differenceAmount := paymentScheduleSub.Amount - Rec.Amount;
                paymentScheduleSub.Amount := Rec.Amount;
                paymentScheduleSub."VAT Amount" := Rec."VAT Amount";
                paymentScheduleSub."Amount Including VAT" := Rec."Amount Including VAT";
                paymentScheduleSub.Modify(true);
            end;

        paymentMode2.SetRange("Contract ID", Rec.ContractID);
        paymentMode2.SetRange("Payment Series", 'PAY01');
        if paymentMode2.FindFirst() then begin
            paymentMode2.Amount -= differenceAmount;
            paymentMode2."Amount Including VAT" := paymentMode2.Amount + paymentMode2."VAT Amount";
            paymentMode2.Modify(true);
        end;
    end;
}
