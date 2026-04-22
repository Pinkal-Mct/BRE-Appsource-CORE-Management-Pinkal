table 73209645 "Payment Mode"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(73209575; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Schedule"."Contract ID";
            Caption = 'Contract ID';
            trigger OnValidate()
            var
                leaserec: Record "Payment Schedule";
                Tenancycontract: Record "Tenancy Contract";
            begin
                leaserec.SetRange("Contract ID", Rec."Contract ID");
                Tenancycontract.SetRange("Contract ID", Rec."Contract ID");
                if leaserec.FindFirst() then
                    "Tenant Id" := leaserec."Tenant Id"
                else
                    "Tenant Id" := '';
                if Tenancycontract.FindFirst() then begin
                    "Tenant Name" := Tenancycontract."Customer Name";
                    "Tenant Email" := Tenancycontract."Email Address";
                    "Contract Start date" := Tenancycontract."Contract Start Date";
                    "Contract End date" := Tenancycontract."Contract End Date";
                    "Payment Reminder" := Tenancycontract."Payment Reminder";
                end else begin
                    "Tenant Name" := '';
                    "Tenant Email" := '';
                    "Contract Start date" := 0D;
                    "Contract End date" := 0D;
                end;
                EvaluatePaymentSchedule();
                GetNextSequenceNo();
            end;
        }
        field(73209576; "Contract Start date"; Date)
        {
            Caption = 'Contract Start date';
            DataClassification = ToBeClassified;
        }
        field(73209577; "Contract End date"; Date)
        {
            Caption = 'Contract End date';
            DataClassification = ToBeClassified;
        }
        field(73209578; "Tenant Id"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Id';
            TableRelation = "Payment Schedule"."Contract ID";
            Editable = false;
        }
        field(73209579; "Approval Status"; Option)
        {
            OptionMembers = " ","Pending","Approved","On-Hold","Rejected";
            trigger OnValidate()
            var
                paymentGridRec: Record "Payment Mode2";
                paymentSeriesRec: Record "Payment Mode2";
                PdcTransRec: Record "PDC Transaction";
                sendRejectionToLeaseTeam: Codeunit 73209618;
                approvalPending: Boolean;
                Isrejected: Boolean;
            begin
                if Rec."Approval Status" = Rec."Approval Status"::Approved then begin
                    paymentGridRec.SetRange("Contract ID", Rec."Contract ID");
                    if paymentGridRec.FindSet() then
                        repeat
                            paymentGridRec."Approval Status" := paymentGridRec."Approval Status"::Approved;
                            paymentGridRec.Modify();
                            pdcTransRec.SetRange("Payment Series", paymentGridRec."Payment Series");
                            pdcTransRec.SetRange("Contract ID", Rec."Contract ID");
                            if pdcTransRec.FindSet() then
                                repeat
                                    pdcTransRec."Approval Status" := pdcTransRec."Approval Status"::Approved;
                                    pdcTransRec.Modify();
                                until pdcTransRec.Next() = 0;
                        until paymentGridRec.Next() = 0;
                    Rec."On-hold" := Rec."On-hold"::"False";
                end;
                if Rec."Approval Status" = Rec."Approval Status"::Rejected then begin
                    paymentGridRec.SetRange("Contract ID", Rec."Contract ID");
                    if paymentGridRec.FindSet() then
                        repeat
                            paymentGridRec."Approval Status" := paymentGridRec."Approval Status"::Rejected;
                            paymentGridRec.Modify();
                        until paymentGridRec.Next() = 0;
                    Rec."On-hold" := Rec."On-hold"::"True";
                end;
                if Rec."On-hold" = Rec."On-hold"::"True" then begin
                    approvalPending := false;
                    Isrejected := false;
                    paymentSeriesRec.SetRange("Contract ID", Rec."Contract ID");
                    paymentSeriesRec.SetRange("Tenant Id", Rec."Tenant Id");
                    if paymentSeriesRec.FindSet() then
                        repeat
                            if paymentSeriesRec."Approval Status" = paymentSeriesRec."Approval Status"::Pending then begin
                                approvalPending := true;
                                break;
                            end
                            else
                                if paymentSeriesRec."Approval Status" = paymentSeriesRec."Approval Status"::Rejected then
                                    Isrejected := true;
                        until paymentSeriesRec.Next() = 0;
                    if ApprovalPending then
                        exit;
                    if approvalPending = false and Isrejected = true then
                        sendRejectionToLeaseTeam.SendPaymentRejectionToLeaseManager(paymentSeriesRec."Contract ID", paymentSeriesRec."Tenant Id", paymentSeriesRec."Contract ID");
                end;
            end;
        }
        field(73209580; "On-hold"; Option)
        {
            OptionMembers = " ","True","False";
        }
        field(73209581; "Isupdated"; Option)
        {
            OptionMembers = " ","True","False";
        }
        field(73209582; "Tenant Name"; Text[100])
        {
            Caption = 'Tenant Name';
        }
        field(73209583; "Tenant Email"; Text[100])
        {
            Caption = 'Tenant Email';
        }
        field(73209584; "Combine Payment Series"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(73209585; "Combine Due Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(73209586; "Combine Payment Mode"; Text[150])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Type"."Payment Method";
        }
        field(73209587; "Combine Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73209588; "Combine VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73209589; "Combine Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73209590; "Change Payment Mode"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Type"."Payment Method";
        }
        field(73209591; "Change Payment Series"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(73209592; "Payment Reminder"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Reminder';
            Editable = false;
        }
        field(73209593; "C_Cheque_Number"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cheque Number';
        }
        field(73209594; "C_Deposit_Bank"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Deposit Bank';
            TableRelation = "Bank Account";

            trigger OnValidate()
            var
                BankAccountRec: Record "Bank Account";
            begin
                if "C_Deposit_Bank" <> '' then
                    // Attempt to find the Bank Account using the No. from the Deposit Bank
                    if BankAccountRec.Get("C_Deposit_Bank") then
                        "C_Deposit_Bank" := BankAccountRec."Name";
            end;
        }
        field(73209595; "CP_Cheque_Number"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cheque Number';
        }
        field(73209596; "CP_Deposit_Bank"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Deposit Bank';
            TableRelation = "Bank Account";

            trigger OnValidate()
            var
                BankAccountRec: Record "Bank Account";
            begin
                if "CP_Deposit_Bank" <> '' then
                    if BankAccountRec.Get("CP_Deposit_Bank") then
                        "CP_Deposit_Bank" := BankAccountRec."Name";
            end;
        }
    }
    keys
    {
        key(PK; "Contract ID")
        {
            Clustered = true;
        }
    }
    procedure EvaluatePaymentSchedule()
    var
        PaymentScheduleRec: Record "Payment Schedule2";
        PaymentScheduleRec2: Record "Payment Schedule2";
        MergedRecord: Record "Payment Mode2";
        TotalAmount: Decimal;
        TotalVAT: Decimal;
        GrandTotal: Decimal;
        NewPaymentCode: Code[20];
        SequenceNo: Integer;
        MinDueDate: Date;
        DueDateList: List of [Date];
        i: Integer;
        SortedDueDateList: List of [Date];
        TempDate: Date;
        PaymentStatus: Enum "Payment Status";
    begin
        TotalAmount := 0;
        TotalVAT := 0;
        GrandTotal := 0;
        PaymentScheduleRec.SetRange("Tenant ID", Rec."Tenant ID");
        PaymentScheduleRec.SetRange("Contract ID", Rec."Contract ID");
        if PaymentScheduleRec.FindSet() then
            repeat
                MinDueDate := PaymentScheduleRec."Due Date";
                if not DueDateList.Contains(MinDueDate) then
                    DueDateList.Add(MinDueDate);
            until PaymentScheduleRec.Next() = 0;
        while DueDateList.Count() > 0 do begin
            TempDate := DueDateList.Get(1);
            for i := 2 to DueDateList.Count() do
                if DueDateList.Get(i) < TempDate then
                    TempDate := DueDateList.Get(i);
            SortedDueDateList.Add(TempDate);
            DueDateList.Remove(TempDate);
        end;
        for i := 1 to SortedDueDateList.Count() do begin
            MinDueDate := SortedDueDateList.Get(i);
            TotalAmount := 0;
            TotalVAT := 0;
            GrandTotal := 0;
            PaymentScheduleRec2.SetRange("Due Date", MinDueDate);
            PaymentScheduleRec2.SetRange("Tenant ID", Rec."Tenant ID");
            PaymentScheduleRec2.SetRange("Contract ID", Rec."Contract ID");
            if PaymentScheduleRec2.FindSet() then
                repeat
                    TotalAmount += PaymentScheduleRec2."Amount";
                    TotalVAT += PaymentScheduleRec2."VAT Amount";
                    GrandTotal += PaymentScheduleRec2."Amount Including VAT";
                until PaymentScheduleRec2.Next() = 0;
            SequenceNo := GetNextSequenceNo();
            NewPaymentCode := GeneratePaymentCode(SequenceNo);
            MergedRecord.Reset();
            MergedRecord.SetRange("Tenant ID", Rec."Tenant ID");
            MergedRecord.SetRange("Contract ID", Rec."Contract ID");
            MergedRecord.SetRange("Due Date", MinDueDate);
            if not MergedRecord.FindFirst() then begin
                MergedRecord.Init();
                MergedRecord."Tenant ID" := Rec."Tenant ID";
                MergedRecord."Contract ID" := Rec."Contract ID";
                MergedRecord."Tenant Email" := Rec."Tenant Email";
                MergedRecord."Tenant Name" := Rec."Tenant Name";
                MergedRecord."Payment Series" := NewPaymentCode;
                MergedRecord."Amount" := TotalAmount;
                MergedRecord."VAT Amount" := TotalVAT;
                MergedRecord."Amount Including VAT" := GrandTotal;
                MergedRecord."Due Date" := MinDueDate;
                MergedRecord."Payment Status" := PaymentStatus::Scheduled;
                MergedRecord."Payment Reminder" := Rec."Payment Reminder";
                MergedRecord.Insert();
                Clear(MergedRecord);
            end
        end;
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

    local procedure GetNextSequenceNo(): Integer
    var
        MergedRecord: Record "Payment Mode2";
        MaxSequence: Integer;
        LastSequence: Text[10];
    begin
        MergedRecord.Reset();
        MergedRecord.SetRange("Contract ID", Rec."Contract ID");
        if MergedRecord.FindSet() then
            repeat
                LastSequence := CopyStr(MergedRecord."Payment Series", 4, StrLen(MergedRecord."Payment Series"));
                if Evaluate(MaxSequence, LastSequence) and (MaxSequence > MaxSequence) then
                    MaxSequence := MaxSequence;
            until MergedRecord.Next() = 0
        else
            MaxSequence := 0;
        exit(MaxSequence + 1);
    end;

    trigger OnDelete()
    var
    begin
        Deletepaymetnscheudlesubpage();
    end;

    procedure Deletepaymetnscheudlesubpage()
    var
        Paymentmodesubpage: Record "Payment Mode2";
    begin
        Paymentmodesubpage.SetRange("Contract ID", Rec."Contract ID");
        if Paymentmodesubpage.FindSet() then
            repeat
                Paymentmodesubpage.DeleteAll();
            until Paymentmodesubpage.Next() = 0;
    end;
}
