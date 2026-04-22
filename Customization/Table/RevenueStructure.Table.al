table 73209680 "Revenue Structure"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(73209575; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
            TableRelation = "Tenancy Contract"."Contract ID";
        }

        field(73209576; "RS ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
        }

        field(73209577; "Secondary Item Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Secondary Item Type';
            Editable = false;
        }

        field(73209578; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
            Editable = false;
            DecimalPlaces = 2 : 2;

        }

        field(73209579; "Contract Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Start Date';
            Editable = false;
        }

        field(73209580; "Contract End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract End Date';
            Editable = false;
        }

        field(73209581; "Number of Installments"; Integer)
        {
            Caption = 'Number of Installments';
        }

        field(73209582; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Amount';
            Editable = false;
            DecimalPlaces = 2 : 2;

        }

        field(73209583; "Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount Including VAT';
            Editable = false;
            DecimalPlaces = 2 : 2;

        }

        field(73209584; "Tenant ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
            Editable = false;
            TableRelation = "Lease Proposal Details"."Tenant ID";
        }
        field(73209585; "VAT %"; Option)
        {
            OptionMembers = "0","5";
            Caption = 'VAT %';
            Editable = false;
        }
        field(73209586; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "RS ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Contract ID")
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
        paymentschedule: Record "Revenue Structure Subpage";

    begin
        paymentschedule.SetRange("Contract Id", Rec."Contract ID");
        paymentschedule.SetRange("RS ID", Rec."RS ID");
        if paymentschedule.FindSet() then
            paymentschedule.DeleteAll();
    end;

    procedure deleterevenuestructuresubpag1()
    var
        revenuestructuresubpage1: Record "Revenue Structure Subpage1";
    begin
        revenuestructuresubpage1.SetRange("Contract ID", Rec."Contract ID");
        revenuestructuresubpage1.SetRange("RS ID", Rec."RS ID");
        if revenuestructuresubpage1.FindSet() then
            revenuestructuresubpage1.DeleteAll();
    end;

    procedure Deleterevenuerecognition()
    var
        revenuerecognition: Record "RevenueRecognition Othercharge";
    begin
        revenuerecognition.SetRange("Contract ID", Rec."Contract ID");
        if revenuerecognition.FindSet() then
            repeat
                revenuerecognition.DeleteAll();
            until revenuerecognition.Next() = 0;
    end;

}





