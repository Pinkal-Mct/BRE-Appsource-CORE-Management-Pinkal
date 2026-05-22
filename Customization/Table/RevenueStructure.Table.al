table 73209680 "BLRRevenueStructure"
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

        field(73209576; "BLRRS ID"; Integer)
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
            DecimalPlaces = 2 : 2;

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
            DecimalPlaces = 2 : 2;

        }

        field(73209583; "BLRAmount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount Including VAT';
            Editable = false;
            DecimalPlaces = 2 : 2;

        }

        field(73209584; "BLRTenant ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
            Editable = false;
            TableRelation = "BLRLeaseProposalDetails"."BLRTenant ID";
        }
        field(73209585; "BLRVAT %"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "0","5";
            Caption = 'VAT %';
            Editable = false;
        }
        field(73209586; "BLREntry No"; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
    keys
    {
        key(PK;"BLRRS ID")
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
    begin
        deletepaymentschedule();
        deleterevenuestructuresubpag1();
        Deleterevenuerecognition();
    end;

    procedure deletepaymentschedule()
    var
        paymentschedule: Record "BLRRevenueStructureSubpage";

    begin
        paymentschedule.SetRange("BLRContract ID", Rec."BLRContract ID");
        paymentschedule.SetRange("BLRRS ID", Rec."BLRRS ID");
        if paymentschedule.FindSet() then
            paymentschedule.DeleteAll();
    end;

    procedure deleterevenuestructuresubpag1()
    var
        revenuestructuresubpage1: Record "BLRRevenueStructureSubpage1";
    begin
        revenuestructuresubpage1.SetRange("BLRContract ID", Rec."BLRContract ID");
        revenuestructuresubpage1.SetRange("BLRRS ID", Rec."BLRRS ID");
        if revenuestructuresubpage1.FindSet() then
            revenuestructuresubpage1.DeleteAll();
    end;

    procedure Deleterevenuerecognition()
    var
        revenuerecognition: Record "BLRRevenueRecognitionOthChg";
    begin
        revenuerecognition.SetRange("BLRContract ID", Rec."BLRContract ID");
        if revenuerecognition.FindSet() then
            repeat
                revenuerecognition.DeleteAll();
            until revenuerecognition.Next() = 0;
    end;

}





