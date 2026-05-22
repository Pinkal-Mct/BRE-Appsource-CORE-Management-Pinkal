table 73209648 "BLRPaymentSchedule"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "BLRContract ID";

    fields
    {
        field(73209575; "BLRTenant Id"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant Id';
            TableRelation = "BLRLeaseProposalDetails"."BLRTenant ID";
            Editable = false;
        }

        field(73209576; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = "BLRTenancyContract"."BLRContract ID" WHERE("BLRTenant Contract Status" = CONST(Active));
            Caption = 'Contract ID';

            trigger OnValidate()
            var
                leaserec: Record "BLRTenancyContract";

            begin
                leaserec.SetRange("BLRContract ID", Rec."BLRContract ID");
                if leaserec.FindFirst() then begin
                    "BLRTenant Id" := leaserec."BLRTenant Id";
                    "BLRTenant Name" := leaserec."BLRCustomer Name";
                    "BLRContract Status" := Format(leaserec."BLRTenant Contract Status");
                    "BLRContract Start date" := leaserec."BLRContract Start Date";
                    "BLRContract End date" := leaserec."BLRContract End Date";
                    "BLRProperty ID" := leaserec."BLRProperty ID";
                    "BLRProperty Classification" := leaserec."BLRProperty Classification";
                end else begin
                    "BLRTenant Id" := '';
                    "BLRTenant Name" := '';
                    "BLRContract Status" := '';
                    "BLRProperty ID" := '';
                    "BLRProperty Classification" := '';

                end;
                UpdatePaymentSchedule2();
                UpdatePaymentSchedule();
                addrevnuestructurpagelinePaymentschedule2();
                EvaluatePaymentSchedule();
            end;
        }

        field(73209577; "BLRTotal Amount Including VAT"; Decimal)
        {
            Caption = 'Total Amount Including VAT';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("BLRPaymentSchedule2"."BLRAmount Including VAT" where("BLRContract ID" = field("BLRContract ID")));
        }


        field(73209578; "BLRTotal Amount"; Decimal)
        {
            Caption = 'Total Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("BLRPaymentSchedule2"."BLRAmount" where("BLRContract ID" = field("BLRContract ID"), "BLRTenant ID" = field("BLRTenant ID")));
        }
        field(73209579; "BLRContract End date"; Date)
        {
            Caption = 'Contract End date';
            DataClassification = CustomerContent;
        }
        field(73209580; "BLRTotal VAT Amount"; Decimal)
        {
            Caption = 'Total VAT Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("BLRPaymentSchedule2"."BLRVAT Amount" where("BLRContract ID" = field("BLRContract ID"), "BLRTenant ID" = field("BLRTenant ID")));
        }
        field(73209581; "BLRTenant Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Name';

        }
        field(73209582; "BLRProperty Classification"; Text[100])
        {
            Caption = 'Property Classification';
            DataClassification = CustomerContent;
        }

        field(73209583; "BLRContract Status"; Text[100])
        {
            Caption = 'Contract Status';
            DataClassification = CustomerContent;
        }
        field(73209584; "BLRContract Start date"; Date)
        {
            Caption = 'Contract Start date';
            DataClassification = CustomerContent;
        }
        field(73209585; "BLRProperty ID"; Code[40])
        {
            Caption = 'Property ID';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK;"BLRContract ID")
        {
            Clustered = true;
        }
    }
    procedure UpdatePaymentSchedule2()
    var
        RevenueSubpage: Record "BLRTenancyContractSubpage";
        PaymentSchedule2: Record "BLRPaymentSchedule2";
        vatper: Integer;

    begin
        PaymentSchedule2.SetRange("BLRContract ID", Rec."BLRContract ID");
        if PaymentSchedule2.FindSet() then
            PaymentSchedule2.DeleteAll();

        RevenueSubpage.SetRange("BLRContractID", Rec."BLRContract ID");
        RevenueSubpage.SetRange("BLRPayment Type", 1);
        RevenueSubpage.SetFilter("BLRAmount Including VAT", '<>%1', 0);
        if not RevenueSubpage.FindSet() then begin
            Message('No Payment Type 1 records found in the Tenancy Contract.');
            exit;
        end;
        repeat
            PaymentSchedule2.Init();
            PaymentSchedule2."BLRContract ID" := RevenueSubpage."BLRContractID";
            PaymentSchedule2."BLRContract start date" := Rec."BLRContract Start date";
            PaymentSchedule2."BLRContract Status" := Rec."BLRContract Status";
            PaymentSchedule2."BLRProperty ID" := Rec."BLRProperty ID";
            PaymentSchedule2."BLRTenant Name" := Rec."BLRTenant Name";
            PaymentSchedule2."BLRTenant ID" := RevenueSubpage."BLRTenantID";
            PaymentSchedule2."BLRProperty Classification" := Rec."BLRProperty Classification";
            PaymentSchedule2."BLRSecondary Item Type" := RevenueSubpage."BLRSecondary Item Type";
            PaymentSchedule2."BLRAmount" := RevenueSubpage."BLRAmount";
            PaymentSchedule2."BLRVAT Amount" := RevenueSubpage."BLRVAT Amount";
            PaymentSchedule2."BLRAmount Including VAT" := RevenueSubpage."BLRAmount Including VAT";
            PaymentSchedule2."BLRInstallment Start Date" := RevenueSubpage."BLRStart Date";
            PaymentSchedule2."BLRInstallment End Date" := RevenueSubpage."BLREnd Date";
            PaymentSchedule2."BLRDue Date" := RevenueSubpage."BLRStart Date";
            PaymentSchedule2."BLRInstallment No." := 1;
            PaymentSchedule2."BLRYear" := 1;
            if RevenueSubpage."BLRVAT %" = RevenueSubpage."BLRVAT %"::"5%" then
                vatper := 5
            else
                vatper := 0;
            PaymentSchedule2."BLRVAT%" := vatper;
            PaymentSchedule2.Insert();
            Clear(PaymentSchedule2);
        until RevenueSubpage.Next() = 0;
    end;

    procedure UpdatePaymentSchedule()
    var
        RentCalculationSubpage: Record "BLRRentCalculationSubpage2";
        PaymentSchedule: Record "BLRPaymentSchedule2";
    begin

        RentCalculationSubpage.SetRange("BLRContract ID", Rec."BLRContract ID");

        if RentCalculationSubpage.FindSet() then
            repeat
                PaymentSchedule.Init();
                PaymentSchedule."BLRContract ID" := RentCalculationSubpage."BLRContract ID";
                PaymentSchedule."BLRContract start date" := Rec."BLRContract Start date";
                PaymentSchedule."BLRContract Status" := Rec."BLRContract Status";
                PaymentSchedule."BLRProperty ID" := Rec."BLRProperty ID";
                PaymentSchedule."BLRTenant Name" := Rec."BLRTenant Name";
                PaymentSchedule."BLRTenant ID" := RentCalculationSubpage."BLRTenant Id";
                PaymentSchedule."BLRSecondary Item Type" := RentCalculationSubpage."BLRSecondary Item Type";
                PaymentSchedule."BLRAmount" := RentCalculationSubpage."BLRAmount";
                PaymentSchedule."BLRVAT Amount" := RentCalculationSubpage."BLRVAT Amount";
                PaymentSchedule."BLRProperty Classification" := RentCalculationSubpage."BLRPrimary Classification";
                PaymentSchedule."BLRInstallment Start Date" := RentCalculationSubpage."BLRInstallment Start Date";
                PaymentSchedule."BLRInstallment End Date" := RentCalculationSubpage."BLRInstallment End Date";
                PaymentSchedule."BLRInstallment No." := RentCalculationSubpage."BLRInstallment No.";
                PaymentSchedule."BLRAmount Including VAT" := RentCalculationSubpage."BLRAmount Including VAT";
                PaymentSchedule."BLRDue Date" := RentCalculationSubpage."BLRDue Date";
                PaymentSchedule."BLRVAT%" := RentCalculationSubpage."BLRVAT %";
                PaymentSchedule."BLRYear" := RentCalculationSubpage."BLRYear";
                PaymentSchedule.Insert();
                Clear(PaymentSchedule);
            until RentCalculationSubpage.Next() = 0;

    end;

    procedure addrevnuestructurpagelinePaymentschedule2()
    var
        RevenueStructureSubpage: Record "BLRRevenueStructureSubpage1";
        PaymentSchedule3: Record "BLRPaymentSchedule2";
    begin

        RevenueStructureSubpage.SetRange("BLRContract ID", Rec."BLRContract ID");


        if RevenueStructureSubpage.FindSet() then
            repeat
                PaymentSchedule3.Init();

                PaymentSchedule3."BLRContract ID" := RevenueStructureSubpage."BLRContract ID";

                PaymentSchedule3."BLRContract start date" := Rec."BLRContract Start date";
                PaymentSchedule3."BLRContract Status" := Rec."BLRContract Status";
                PaymentSchedule3."BLRProperty ID" := Rec."BLRProperty ID";
                PaymentSchedule3."BLRTenant Name" := Rec."BLRTenant Name";
                PaymentSchedule3."BLRTenant ID" := RevenueStructureSubpage."BLRTenant Id";
                PaymentSchedule3."BLRProperty Classification" := Rec."BLRProperty Classification";
                PaymentSchedule3."BLRSecondary Item Type" := RevenueStructureSubpage."BLRSecondary Item Type";
                PaymentSchedule3."BLRAmount" := RevenueStructureSubpage."BLRAmount";
                PaymentSchedule3."BLRVAT Amount" := RevenueStructureSubpage."BLRVAT Amount";
                PaymentSchedule3."BLRInstallment Start Date" := RevenueStructureSubpage."BLRInstallment Start Date";
                PaymentSchedule3."BLRInstallment End Date" := RevenueStructureSubpage."BLRInstallment End Date";
                PaymentSchedule3."BLRInstallment No." := RevenueStructureSubpage."BLRInstallment No.";
                PaymentSchedule3."BLRAmount Including VAT" := RevenueStructureSubpage."BLRAmount Including VAT";
                PaymentSchedule3."BLRDue Date" := RevenueStructureSubpage."BLRDue Date";
                PaymentSchedule3."BLRVAT%" := RevenueStructureSubpage."BLRVAT %";
                PaymentSchedule3."BLRYear" := RevenueStructureSubpage."BLRYear";
                PaymentSchedule3.Insert();
                Clear(PaymentSchedule3);
            until RevenueStructureSubpage.Next() = 0;

    end;

    procedure EvaluatePaymentSchedule()
    var
        PaymentScheduleRec: Record "BLRPaymentSchedule2";
        PaymentScheduleRec2: Record "BLRPaymentSchedule2";
        NewPaymentCode: Code[20];
        SequenceNo: Integer;
        MinDueDate: Date;
        DueDateList: List of [Date];
        TempDate: Date;
        i: Integer;
        SortedDueDateList: List of [Date];
    begin
        PaymentScheduleRec.SetRange("BLRTenant ID", Rec."BLRTenant Id");
        PaymentScheduleRec.SetRange("BLRContract ID", Rec."BLRContract ID");
        if PaymentScheduleRec.FindSet() then
            repeat
                if not DueDateList.Contains(PaymentScheduleRec."BLRDue Date") then
                    DueDateList.Add(PaymentScheduleRec."BLRDue Date");
            until PaymentScheduleRec.Next() = 0;
        while DueDateList.Count() > 0 do begin
            TempDate := DueDateList.Get(1);
            for i := 2 to DueDateList.Count() do
                if DueDateList.Get(i) < TempDate then
                    TempDate := DueDateList.Get(i);
            SortedDueDateList.Add(TempDate);
            DueDateList.Remove(TempDate);
        end;
        SequenceNo := 1;
        for i := 1 to SortedDueDateList.Count() do begin
            MinDueDate := SortedDueDateList.Get(i);
            NewPaymentCode := GeneratePaymentCode(SequenceNo);
            PaymentScheduleRec2.Reset();
            PaymentScheduleRec2.SetRange("BLRDue Date", MinDueDate);
            PaymentScheduleRec2.SetRange("BLRTenant ID", Rec."BLRTenant Id");
            PaymentScheduleRec2.SetRange("BLRContract ID", Rec."BLRContract ID");

            if PaymentScheduleRec2.FindSet() then
                repeat
                    PaymentScheduleRec2."BLRPayment Series" := NewPaymentCode;
                    PaymentScheduleRec2.Modify();
                until PaymentScheduleRec2.Next() = 0;
            SequenceNo += 1;
        end;

        Message('Payment series assignment completed successfully.');
    end;

    local procedure GeneratePaymentCode(SequenceNumber: Integer): Code[20]
    begin
        exit(Format('PAY' + PadStr(Format(SequenceNumber), 2, '0')));
    end;

    local procedure PadStr(Input: Text[20]; Length: Integer; PaddingChar: Char): Text[20]
    begin
        while StrLen(Input) < Length do
            Input := PaddingChar + Input;
        exit(Input);
    end;


    trigger OnDelete()
    var
    begin
        Deletepaymetnscheudlesubpage();
        TenancyContractsubpageInvoicedPaidUpdate();
    end;

    procedure Deletepaymetnscheudlesubpage()
    var
        Paymentschedulesubpage: Record "BLRPaymentSchedule2";
    begin
        Paymentschedulesubpage.SetRange("BLRContract ID", Rec."BLRContract ID");
        if Paymentschedulesubpage.FindSet() then
            Paymentschedulesubpage.DeleteAll();
    end;

    procedure TenancyContractsubpageInvoicedPaidUpdate()
    var
        TenancyContractSubPageRec: Record "BLRTenancyContractSubpage";
    begin
        TenancyContractSubPageRec.SetRange("BLRContractID", Rec."BLRContract ID");
        if TenancyContractSubPageRec.FindSet()
        then
            repeat
                TenancyContractSubPageRec.Validate("BLRInvoiced and Paid", 0);
                TenancyContractSubPageRec.Modify();
            until TenancyContractSubPageRec.Next() = 0;
    end;
}
