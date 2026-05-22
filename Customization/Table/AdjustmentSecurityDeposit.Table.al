table 73209577 "BLRAdjustmentSecurityDeposit"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "BLRID";
    fields
    {
        field(73209575; "BLRID"; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
            Editable = false;
        }
        field(73209576; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
            TableRelation = "BLRTenancyContract"."BLRContract ID";
            trigger OnValidate()
            var
                ContractRec: Record "BLRTenancyContract";
                AdjustSecurityDeposit: Record "BLRAdjustmentSecurityDeposit";
            begin
                AdjustSecurityDeposit.Reset();
                AdjustSecurityDeposit.SetRange("BLRContract ID", Rec."BLRContract ID");
                if not AdjustSecurityDeposit.IsEmpty() then
                    Error('This "BLRContract ID" %1 is already used in another record.', Rec."BLRContract ID");
                ContractRec.SetRange("BLRContract ID", "BLRContract ID");
                if ContractRec.Get() then begin
                    Rec."BLRMain Security Deposit" := ContractRec."BLRSecurity Deposit Amount";
                    Rec."BLRSecurity Deposit" := ContractRec."BLRSecurity Balanced Amount";
                    Rec."BLRContract Start Date" := ContractRec."BLRContract Start Date";
                    Rec."BLRContract End Date" := ContractRec."BLRContract End Date";
                end;
            end;
        }
        field(73209577; "BLRSecurity Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Security Deposit';
            Editable = false;
        }
        field(73209578; "BLRContract Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start Date';
            Editable = false;
        }
        field(73209579; "BLRContract End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract End Date';
            Editable = false;
        }
        field(73209580; "BLRStatus"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Pending,Approved';
            OptionMembers = Pending,Approved;
            Editable = false;
        }
        field(73209581; "BLRSecurity Amount Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Termination Charges';
            OptionMembers = "Termination Charges";
            Editable = false;
            trigger OnValidate()
            var
                TermChargesGrid: Record "BLRAdditionalChargesSub";
                TotalAmount: Decimal;
                TotalVATAmount: Decimal;
                TotalAmountInclVAT: Decimal;
            begin
                if Rec."BLRSecurity Amount Status" = Rec."BLRSecurity Amount Status"::"Termination Charges" then begin
                    if Rec."BLRContract ID" = 0 then
                        Error('Please select a "BLRContract ID" first');
                    Clear(TotalAmount);
                    Clear(TotalVATAmount);
                    Clear(TotalAmountInclVAT);
                    TermChargesGrid.Reset();
                    TermChargesGrid.SetRange("BLRContract ID", Rec."BLRContract ID");
                    if TermChargesGrid.FindSet() then begin
                        repeat
                            TotalAmount += TermChargesGrid."BLRAmount";
                            TotalVATAmount += TermChargesGrid."BLRVAT Amount";
                            TotalAmountInclVAT += TermChargesGrid."BLRAmount Including VAT";
                        until TermChargesGrid.Next() = 0;
                        Rec."BLRAmount" := TotalAmount;
                        Rec."BLRVAT Amount" := TotalVATAmount;
                        Rec."BLRAmount Including VAT" := TotalAmountInclVAT;
                    end;
                end;
            end;
        }
        field(73209582; "BLRPayment Series"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Series';
        }
        field(73209583; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
        field(73209584; "BLRVAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Amount';
        }
        field(73209585; "BLRAmount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount Including VAT';
        }
        field(73209586; "BLRDue Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date';
        }
        field(73209587; "BLRMain Security Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Main Security Deposit';
            Editable = false;
        }
    }
    keys
    {
        key(PK;"BLRID")
        {
            Clustered = true;
        }
    }
}
