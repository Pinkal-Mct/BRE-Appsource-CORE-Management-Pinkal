table 73209649 "Payment Schedule2"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(73209575; "Secondary Item Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Secondary Item Type';
        }
        field(73209576; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            Caption = 'Amount';
        }

        field(73209577; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            Caption = 'VAT Amount';
        }

        field(73209578; "Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            Caption = 'Amount Including VAT';
        }

        field(73209579; "Installment Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Installment Start Date';

        }

        field(73209580; "Installment End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Installment End Date';

        }



        field(73209581; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Due Date';

        }

        field(73209582; "Installment No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Installment No.';

        }



        field(73209583; "Payment Series"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Series';

        }

        field(73209584; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }


        field(73209585; "Tenant ID"; Code[20])
        {

            Caption = 'Tenant ID';

        }
        field(73209586; "Tenant Name"; Text[100])
        {

            Caption = 'Tenant Name';

        }
        field(73209587; "Invoiced"; Boolean)
        {
            Caption = 'Invoiced';
        }


        field(73209588; "Contract ID"; Integer)
        {
            Caption = 'Contract ID';
        }

        field(73209589; "Payment Status"; Text[100])
        {
            Caption = 'Payment Status';

            trigger OnValidate()

            begin
                if "Payment Status" = 'Received' then
                    UpdateBalanceAmountOnPaymentReceived();
                UpdateTenancySubpageInvoicedAndPaid();
            end;
        }
        field(73209590; "Property Classification"; Text[100])
        {
            Caption = 'Property Classification';
            DataClassification = ToBeClassified;
        }
        field(73209591; "Contract Status"; Text[100])
        {
            Caption = 'Contract Status';
            DataClassification = ToBeClassified;
        }
        field(73209592; "Invoice ID"; Code[50])
        {
            Caption = 'Invoice ID';
            DataClassification = ToBeClassified;
        }
        field(73209593; "Overdue Invoice"; Text[20])
        {
            Caption = 'Overdue Invoice';
            DataClassification = ToBeClassified;
        }
        field(73209594; "Payment Recieved Date"; Date)
        {
            Caption = 'Payment Recived Date';
            DataClassification = ToBeClassified;
        }

        field(73209595; "Payment Mode"; Text[100])
        {
            Caption = 'Payment Mode';
        }

        field(73209596; "Cheque Number"; Text[100])
        {
            Caption = 'Cheque Number';
        }
        field(73209597; "Contract start date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Start date';
        }
        field(73209598; "Property ID"; Code[40])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property ID';

        }
        field(73209599; "No of Days"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'No of Days';

        }
        field(73209600; "Workflow frequency date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Workflow Frequency Date';
        }
        field(73209601; "VAT%"; Integer)
        {
            //OptionMembers = "0%","5%";
            DataClassification = ToBeClassified;
            Caption = 'VAT%';
        }
        field(73209602; "Credit Note No."; Code[100])
        {
            //OptionMembers = "0%","5%";
            DataClassification = ToBeClassified;
            Caption = 'Credit Note No.';
        }
        field(73209603; "Credit Note Amount"; Decimal)
        {
            //OptionMembers = "0%","5%";
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            Caption = 'Credit Note Amount';
        }
        field(73209604; "Final Rent Amount"; Decimal)
        {
            //OptionMembers = "0%","5%";
            DataClassification = ToBeClassified;
            Caption = 'Final Rent Amount';
        }
        field(73209605; "Final RentAmountIncludingVAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Final Rent Amount Including VAT';
        }
        field(73209606; "Invoice Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Pending,Approved,Rejected;
            Caption = 'Invoice Approval Status';
        }
        field(73209607; "Year"; Integer)
        {
            Caption = 'Year';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Secondary Item Type", "Amount", "VAT Amount", "Amount Including VAT")
        {
            Caption = 'Payment Schedule';
        }
    }
    local procedure UpdateBalanceAmountOnPaymentReceived()
    var
        TenancyContractRec: Record "Tenancy Contract";
    begin

        TenancyContractRec.SetRange("Contract ID", Rec."Contract ID");
        if TenancyContractRec.FindSet() then
            if (Rec."Secondary Item Type" = 'Security Deposit') and (Rec."Payment Status" = 'Received') then begin
                if TenancyContractRec."Security Deposit Amt. Received" <> 0 then begin
                    TenancyContractRec."Security Deposit Amt. Received" += Rec."Amount Including VAT";
                    TenancyContractRec."Security Balanced Amount" += Rec."Amount Including VAT";
                end
                else begin
                    TenancyContractRec."Security Deposit Amt. Received" := Rec."Amount Including VAT";
                    TenancyContractRec."Security Balanced Amount" := Rec."Amount Including VAT";
                end;
                TenancyContractRec.Modify();
            end;

    end;

    trigger OnModify()
    var
        SalesHeader: Record "Sales Header";
        PostedSalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        SalesHeader.SetRange("No.", Rec."Invoice ID");
        if SalesHeader.FindFirst() then begin
            Rec."Invoice Approval Status" := SalesHeader."Approval Status";
            Rec.Modify();
        end;

        PostedSalesInvoiceHeader.SetRange("No.", Rec."Invoice ID");
        if PostedSalesInvoiceHeader.FindFirst() then begin
            Rec."Invoice Approval Status" := PostedSalesInvoiceHeader."Approval Status";
            Rec.Modify();
        end;
    end;

    local procedure UpdateTenancySubpageInvoicedAndPaid()
    var
        TenancyContractSubPageRec: Record "Tenancy Contract Subpage";
    begin
        TenancyContractSubPageRec.SetRange("ContractID", Rec."Contract ID");
        TenancyContractSubPageRec.SetRange("Secondary Item Type", Rec."Secondary Item Type");
        if TenancyContractSubPageRec.FindFirst() then begin
            if Rec."Payment Status" = 'Received' then
                TenancyContractSubPageRec.Validate("Invoiced and Paid", TenancyContractSubPageRec."Invoiced and Paid" + Rec."Amount Including VAT")
            else
                TenancyContractSubPageRec.Validate("Invoiced and Paid", TenancyContractSubPageRec."Invoiced and Paid" - Rec."Amount Including VAT");
            TenancyContractSubPageRec.Modify();

        end;
    end;
}
