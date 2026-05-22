table 73209684 "BLRSecurityDeposit"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "BLRSecurity Deposit ID";

    fields
    {
        field(73209575; "BLRSecurity Deposit ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Security Deposit ID';
            AutoIncrement = true;
        }
        field(73209576; "BLRTenant Full Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Full Name';
            TableRelation = Customer.Name;

            trigger OnLookup()
            var
                CustomerRec: Record Customer;
            begin
                if PAGE.RunModal(PAGE::"Customer List", CustomerRec) = ACTION::LookupOK then begin
                    "BLRTenant Full Name" := CustomerRec.Name;
                    "BLRTenant ID" := CustomerRec."No.";
                end;
            end;

            trigger OnValidate()
            var
                CustomerRec: Record Customer;
            begin
                if "BLRTenant Full Name" <> '' then begin
                    CustomerRec.SetRange(Name, "BLRTenant Full Name");
                    if not CustomerRec.FindFirst() then
                        Error('The selected tenant does not exist in the Customer table.')
                    else
                        "BLRTenant ID" := CustomerRec."No.";
                end;
            end;
        }
        field(73209577; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';

            trigger OnValidate()
            var
                tenancyContract: Record "BLRTenancyContract";
            begin
                if tenancyContract.Get(Rec."BLRContract ID") then
                    Rec."BLRProperty Classification" := CopyStr(tenancyContract."BLRProperty Classification", 1, 30);
            end;
        }
        field(73209578; "BLRContract Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start Date';
        }
        field(73209579; "BLRContract End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract End Date';
        }

        field(73209580; "BLRSecurity Deposit Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Security Deposit Amount';
        }

        field(73209581; "BLRNew_Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'New Contract ID';
            TableRelation = "BLRTenancyContract"."BLRContract ID";
        }

        field(73209582; "BLRNew_Tenant Full Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'New Tenant Full Name';
        }

        field(73209583; "BLRNew_Contract Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'New Contract Start Date';
        }

        field(73209584; "BLRNew_Contract End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'New Contract End Date';
        }

        field(73209585; "BLRCarry Forward Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Enter Amount';
        }

        field(73209586; "BLRSecDepAmtPending"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Security Deposit Amount Pending';
            Editable = false; // Make it non-editable since it's auto-calculated
        }

        field(73209587; "BLRNarration"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Narration';
        }
        field(73209588; "BLRBalance Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Available Security Deposit Amount';
        }

        field(73209589; "BLRNew Security Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Security Deposit Amount';

        }

        field(73209590; "BLRSecDepAmtReceived"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Security Deposit Amount Received';
        }
        field(73209591; "BLRProperty Classification"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Classification';
            tableRelation = "BLRTenancyContract"."BLRProperty Classification";
        }
        field(73209592; "BLRStatus"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionMembers = Open,Posted;
        }
        field(73209593; "BLRTenant ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
            Editable = false;
        }
        field(73209594; "BLRPosting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Date';
        }
    }

    keys
    {
        key(PK;"BLRSecurity Deposit ID", "BLRTenant Full Name")
        {
            Clustered = true;
        }
    }
    procedure UpdateAdjustedAmount()
    var
        TenancyContractRec: Record "BLRTenancyContract";
        tenancyContractSubPage: Record "BLRTenancyContractSubpage";
        finalcalcRec: Record "BLRFinalCalculation";
    begin
        if "BLRBalance Amount" > "BLRCarry Forward Amount" then begin
            "BLRBalance Amount" := "BLRBalance Amount" - "BLRCarry Forward Amount";
            "BLRSecDepAmtReceived" += "BLRCarry Forward Amount";
            "BLRSecDepAmtPending" := "BLRNew Security Amount" - "BLRSecDepAmtReceived";
        end else
            "BLRBalance Amount" := 0;

        TenancyContractRec.SetRange("BLRContract ID", "BLRContract ID");
        if TenancyContractRec.FindFirst() then begin
            TenancyContractRec."BLRCarry Forward Out" += "BLRCarry Forward Amount";
            TenancyContractRec."BLRSecurity Balanced Amount" := TenancyContractRec."BLRSecDepAmtReceived" - (TenancyContractRec."BLRCarry Forward Out" + TenancyContractRec."BLRAdjustments" + TenancyContractRec."BLRRefund");
            TenancyContractRec.Modify();

            finalcalcRec.SetRange("BLRContract ID", Rec."BLRContract ID");
            if finalcalcRec.FindFirst() then begin
                finalcalcRec."BLRSecurity Deposit" := TenancyContractRec."BLRSecurity Balanced Amount";
                finalcalcRec."BLRRemaining Security Deposit" := TenancyContractRec."BLRSecurity Balanced Amount";
                finalcalcRec.Modify(true);
            end;
        end;
        Modify(true);
        TenancyContractRec.Reset();
        TenancyContractRec.SetRange("BLRContract ID", "BLRNew_Contract ID");
        if TenancyContractRec.FindFirst() then begin
            TenancyContractRec."BLRCarry Forward In" += "BLRCarry Forward Amount";

            tenancyContractSubPage.SetRange("BLRContractID", TenancyContractRec."BLRContract ID");
            tenancyContractSubPage.SetRange("BLRSecondary Item Type", 'Security Deposit');
            if tenancyContractSubPage.FindSet() then begin
                TenancyContractRec."BLRSecDepAmtReceived" := TenancyContractRec."BLRCarry Forward In" + tenancyContractSubPage."BLRInvoiced and Paid";
                TenancyContractRec."BLRSecurity Amount Pending" := TenancyContractRec."BLRSecurity Deposit Amount" - TenancyContractRec."BLRSecDepAmtReceived";
                TenancyContractRec."BLRSecurity Balanced Amount" := TenancyContractRec."BLRSecDepAmtReceived" - (TenancyContractRec."BLRCarry Forward Out" + TenancyContractRec."BLRAdjustments" + TenancyContractRec."BLRRefund");
                TenancyContractRec."BLRIsCarryForwarded" := true;
                TenancyContractRec.Modify();

                tenancyContractSubPage."BLRAmount" := TenancyContractRec."BLRSecurity Amount Pending";
                tenancyContractSubPage.Validate("BLRAmount");
                tenancyContractSubPage.Modify();
            end;
        end;
    end;
}
