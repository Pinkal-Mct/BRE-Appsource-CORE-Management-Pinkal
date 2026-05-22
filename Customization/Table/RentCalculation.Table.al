table 73209664 "BLRRentCalculation"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
            TableRelation = "BLRTenancyContract"."BLRContract ID";
        }
        field(73209576; "BLRRC ID"; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
            Editable = false;
        }
        field(73209577; "BLRSecondary Item Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Secondary Item Type';
            Editable = false;
        }
        field(73209578; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
            Editable = false;
        }
        field(73209579; "BLRContract Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start Date';
            Editable = false;
        }
        field(73209580; "BLRContract End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract End Date';
            Editable = false;
        }
        field(73209581; "BLRNumber of Installments"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Number of Installments';
        }
        field(73209582; "BLRVAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Amount';
            Editable = false;
        }
        field(73209583; "BLRAmount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount Including VAT';
            Editable = false;
        }
        field(73209584; "BLRTenant ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
            Editable = false;
            TableRelation = "BLRLeaseProposalDetails"."BLRTenant ID";
        }
        field(73209585; "BLRRent Calculation Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Rent Calculation Type';
            Editable = false;
        }
        field(73209586; "BLRVAT %"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "0","5";
            Caption = 'VAT %';
            Editable = false;
        }
        field(73209587; "BLRProperty Classification"; Text[100])
        {
            Caption = 'Property Classification';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK;"BLRRC ID")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown;"BLRContract ID")
        {
        }
    }
    trigger OnDelete()
    var
        TenancyContract: Record "BLRTenancyContract";
    begin
        TenancyContract.SetRange("BLRContract ID", Rec."BLRContract ID");
        if TenancyContract.FindFirst() then begin
            TenancyContract."BLRRent Calculation Link" := 0;
            TenancyContract.Modify();

        end;

        deletepaymentschedule();
        deleterevenuestructuresubpag1();
    end;

    procedure deletepaymentschedule()
    var
        paymentschedule: Record "BLRRentCalculationSubpage";
    begin
        paymentschedule.SetRange("BLRContract ID", Rec."BLRContract ID");
        paymentschedule.SetRange("BLRRC ID", Rec."BLRRC ID");
        if paymentschedule.FindSet() then
            paymentschedule.DeleteAll();
    end;

    procedure deleterevenuestructuresubpag1()
    var
        revenuestructuresubpage1: Record "BLRRentCalculationSubpage2";
    begin
        revenuestructuresubpage1.SetRange("BLRContract ID", Rec."BLRContract ID");
        revenuestructuresubpage1.SetRange("BLRRC ID", Rec."BLRRC ID");
        if revenuestructuresubpage1.FindSet() then
            revenuestructuresubpage1.DeleteAll();
    end;
}
