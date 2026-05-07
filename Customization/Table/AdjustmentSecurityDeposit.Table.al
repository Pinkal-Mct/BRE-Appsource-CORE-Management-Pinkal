table 73209577 "Adjustment Security Deposit"
{
    DataClassification = CustomerContent;
    DataCaptionFields = ID;
    fields
    {
        field(73209575; "ID"; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
            Editable = false;
        }
        field(73209576; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
            TableRelation = "Tenancy Contract"."Contract ID";
            trigger OnValidate()
            var
                ContractRec: Record "Tenancy Contract";
                AdjustSecurityDeposit: Record "Adjustment Security Deposit";
            begin
                AdjustSecurityDeposit.Reset();
                AdjustSecurityDeposit.SetRange("Contract ID", Rec."Contract ID");
                if not AdjustSecurityDeposit.IsEmpty() then
                    Error('This Contract ID %1 is already used in another record.', Rec."Contract ID");
                ContractRec.SetRange("Contract ID", "Contract ID");
                if ContractRec.Get() then begin
                    Rec."Main Security Deposit" := ContractRec."Security Deposit Amount";
                    Rec."Security Deposit" := ContractRec."Security Balanced Amount";
                    Rec."Contract Start Date" := ContractRec."Contract Start Date";
                    Rec."Contract End Date" := ContractRec."Contract End Date";
                end;
            end;
        }
        field(73209577; "Security Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Security Deposit';
            Editable = false;
        }
        field(73209578; "Contract Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start Date';
            Editable = false;
        }
        field(73209579; "Contract End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract End Date';
            Editable = false;
        }
        field(73209580; "Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Pending,Approved';
            OptionMembers = Pending,Approved;
            Editable = false;
        }
        field(73209581; "Security Amount Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Termination Charges';
            OptionMembers = "Termination Charges";
            Editable = false;
            trigger OnValidate()
            var
                TermChargesGrid: Record "Additional Charges Sub";
                TotalAmount: Decimal;
                TotalVATAmount: Decimal;
                TotalAmountInclVAT: Decimal;
            begin
                if Rec."Security Amount Status" = Rec."Security Amount Status"::"Termination Charges" then begin
                    if Rec."Contract ID" = 0 then
                        Error('Please select a Contract ID first');
                    Clear(TotalAmount);
                    Clear(TotalVATAmount);
                    Clear(TotalAmountInclVAT);
                    TermChargesGrid.Reset();
                    TermChargesGrid.SetRange("Contract ID", Rec."Contract ID");
                    if TermChargesGrid.FindSet() then begin
                        repeat
                            TotalAmount += TermChargesGrid.Amount;
                            TotalVATAmount += TermChargesGrid."VAT Amount";
                            TotalAmountInclVAT += TermChargesGrid."Amount Including VAT";
                        until TermChargesGrid.Next() = 0;
                        Rec.Amount := TotalAmount;
                        Rec."VAT Amount" := TotalVATAmount;
                        Rec."Amount Including VAT" := TotalAmountInclVAT;
                    end;
                end;
            end;
        }
        field(73209582; "Payment Series"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Series';
        }
        field(73209583; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
        field(73209584; "VAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Amount';
        }
        field(73209585; "Amount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount Including VAT';
        }
        field(73209586; "Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date';
        }
        field(73209587; "Main Security Deposit"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Main Security Deposit';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "ID")
        {
            Clustered = true;
        }
    }
}
