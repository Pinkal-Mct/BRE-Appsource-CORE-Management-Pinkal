table 73209649 "BLRPaymentSchedule2"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "BLRSecondary Item Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Secondary Item Type';
        }
        field(73209576; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
            Caption = 'Amount';
        }

        field(73209577; "BLRVAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
            Caption = 'VAT Amount';
        }

        field(73209578; "BLRAmount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
            Caption = 'Amount Including VAT';
        }

        field(73209579; "BLRInstallment Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Installment Start Date';

        }

        field(73209580; "BLRInstallment End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Installment End Date';

        }



        field(73209581; "BLRDue Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date';

        }

        field(73209582; "BLRInstallment No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Installment No.';

        }



        field(73209583; "BLRPayment Series"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Series';

        }

        field(73209584; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }


        field(73209585; "BLRTenant ID"; Code[20])
        {
            DataClassification = CustomerContent;

            Caption = 'Tenant ID';

        }
        field(73209586; "BLRTenant Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;

            Caption = 'Tenant Name';

        }
        field(73209587; "BLRInvoiced"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoiced';
        }


        field(73209588; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }

        field(73209589; "BLRPayment Status"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Status';

            trigger OnValidate()

            begin
                if "BLRPayment Status" = 'Received' then
                    UpdateBalanceAmountOnPaymentReceived();
                UpdateTenancySubpageInvoicedAndPaid();
            end;
        }
        field(73209590; "BLRProperty Classification"; Text[100])
        {
            Caption = 'Property Classification';
            DataClassification = CustomerContent;
        }
        field(73209591; "BLRContract Status"; Text[100])
        {
            Caption = 'Contract Status';
            DataClassification = CustomerContent;
        }
        field(73209592; "BLRInvoice ID"; Code[50])
        {
            Caption = 'Invoice ID';
            DataClassification = CustomerContent;
        }
        field(73209593; "BLROverdue Invoice"; Text[20])
        {
            Caption = 'Overdue Invoice';
            DataClassification = CustomerContent;
        }
        field(73209594; "BLRPayment Recieved Date"; Date)
        {
            Caption = 'Payment Recived Date';
            DataClassification = CustomerContent;
        }

        field(73209595; "BLRPayment Mode"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Mode';
        }

        field(73209596; "BLRCheque Number"; Text[100])
        {
            DataClassification = AccountData;
            Caption = 'Cheque Number';
        }
        field(73209597; "BLRContract start date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start date';
        }
        field(73209598; "BLRProperty ID"; Code[40])
        {
            DataClassification = CustomerContent;
            Caption = 'Property ID';

        }
        field(73209599; "BLRNo of Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No of Days';

        }
        field(73209600; "BLRWorkflow frequency date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Workflow Frequency Date';
        }
        field(73209601; "BLRVAT%"; Integer)
        {
            //OptionMembers = "0%","5%";
            DataClassification = CustomerContent;
            Caption = 'VAT%';
        }
        field(73209602; "BLRCredit Note No."; Code[100])
        {
            //OptionMembers = "0%","5%";
            DataClassification = CustomerContent;
            Caption = 'Credit Note No.';
        }
        field(73209603; "BLRCredit Note Amount"; Decimal)
        {
            //OptionMembers = "0%","5%";
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
            Caption = 'Credit Note Amount';
        }
        field(73209604; "BLRFinal Rent Amount"; Decimal)
        {
            //OptionMembers = "0%","5%";
            DataClassification = CustomerContent;
            Caption = 'Final Rent Amount';
        }
        field(73209605; "BLRFinalRentAmtInclVAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Final Rent Amount Including VAT';
        }
        field(73209606; "BLRInvoice Approval Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Pending,Approved,Rejected;
            Caption = 'Invoice Approval Status';
        }
        field(73209607; "BLRYear"; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "BLREntry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "BLRSecondary Item Type", "BLRAmount", "BLRVAT Amount", "BLRAmount Including VAT")
        {
            Caption = 'Payment Schedule';
        }
    }
    local procedure UpdateBalanceAmountOnPaymentReceived()
    var
        TenancyContractRec: Record "BLRTenancyContract";
    begin

        TenancyContractRec.SetRange("BLRContract ID", Rec."BLRContract ID");
        if TenancyContractRec.FindSet() then
            if (Rec."BLRSecondary Item Type" = 'Security Deposit') and (Rec."BLRPayment Status" = 'Received') then begin
                if TenancyContractRec."BLRSecDepAmtReceived" <> 0 then begin
                    TenancyContractRec."BLRSecDepAmtReceived" += Rec."BLRAmount Including VAT";
                    TenancyContractRec."BLRSecurity Balanced Amount" += Rec."BLRAmount Including VAT";
                end
                else begin
                    TenancyContractRec."BLRSecDepAmtReceived" := Rec."BLRAmount Including VAT";
                    TenancyContractRec."BLRSecurity Balanced Amount" := Rec."BLRAmount Including VAT";
                end;
                TenancyContractRec.Modify();
            end;

    end;

    trigger OnModify()
    var
        SalesHeader: Record "Sales Header";
        PostedSalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        SalesHeader.SetRange("No.", Rec."BLRInvoice ID");
        if SalesHeader.FindFirst() then begin
            Rec."BLRInvoice Approval Status" := SalesHeader."BLRApproval Status";
            Rec.Modify();
        end;

        PostedSalesInvoiceHeader.SetRange("No.", Rec."BLRInvoice ID");
        if PostedSalesInvoiceHeader.FindFirst() then begin
            Rec."BLRInvoice Approval Status" := PostedSalesInvoiceHeader."BLRApproval Status";
            Rec.Modify();
        end;
    end;

    local procedure UpdateTenancySubpageInvoicedAndPaid()
    var
        TenancyContractSubPageRec: Record "BLRTenancyContractSubpage";
    begin
        TenancyContractSubPageRec.SetRange("BLRContractID", Rec."BLRContract ID");
        TenancyContractSubPageRec.SetRange("BLRSecondary Item Type", Rec."BLRSecondary Item Type");
        if TenancyContractSubPageRec.FindFirst() then begin
            if Rec."BLRPayment Status" = 'Received' then
                TenancyContractSubPageRec.Validate("BLRInvoiced and Paid", TenancyContractSubPageRec."BLRInvoiced and Paid" + Rec."BLRAmount Including VAT")
            else
                TenancyContractSubPageRec.Validate("BLRInvoiced and Paid", TenancyContractSubPageRec."BLRInvoiced and Paid" - Rec."BLRAmount Including VAT");
            TenancyContractSubPageRec.Modify();

        end;
    end;
}
