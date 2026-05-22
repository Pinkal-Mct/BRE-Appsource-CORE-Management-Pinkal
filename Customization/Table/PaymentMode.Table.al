table 73209645 "BLRPaymentMode"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = "BLRPaymentSchedule"."BLRContract ID";
            Caption = 'Contract ID';
            trigger OnValidate()
            var
                leaserec: Record "BLRPaymentSchedule";
                Tenancycontract: Record "BLRTenancyContract";
            begin
                leaserec.SetRange("BLRContract ID", Rec."BLRContract ID");
                Tenancycontract.SetRange("BLRContract ID", Rec."BLRContract ID");
                if leaserec.FindFirst() then
                    "BLRTenant Id" := leaserec."BLRTenant Id"
                else
                    "BLRTenant Id" := '';
                if Tenancycontract.FindFirst() then begin
                    "BLRTenant Name" := Tenancycontract."BLRCustomer Name";
                    "BLRTenant Email" := Tenancycontract."BLREmail Address";
                    "BLRContract Start date" := Tenancycontract."BLRContract Start Date";
                    "BLRContract End date" := Tenancycontract."BLRContract End Date";
                    "BLRPayment Reminder" := Tenancycontract."BLRPayment Reminder";
                end else begin
                    "BLRTenant Name" := '';
                    "BLRTenant Email" := '';
                    "BLRContract Start date" := 0D;
                    "BLRContract End date" := 0D;
                end;
                EvaluatePaymentSchedule();
                GetNextSequenceNo();
            end;
        }
        field(73209576; "BLRContract Start date"; Date)
        {
            Caption = 'Contract Start date';
            DataClassification = CustomerContent;
        }
        field(73209577; "BLRContract End date"; Date)
        {
            Caption = 'Contract End date';
            DataClassification = CustomerContent;
        }
        field(73209578; "BLRTenant Id"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant Id';
            TableRelation = "BLRPaymentSchedule"."BLRContract ID";
            Editable = false;
        }
        field(73209579; "BLRApproval Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Pending","Approved","On-Hold","Rejected";
            trigger OnValidate()
            var
                paymentGridRec: Record "BLRPaymentMode2";
                paymentSeriesRec: Record "BLRPaymentMode2";
                PdcTransRec: Record "BLRPDCTransaction";
                sendRejectionToLeaseTeam: Codeunit 73209618;
                approvalPending: Boolean;
                Isrejected: Boolean;
            begin
                if Rec."BLRApproval Status" = Rec."BLRApproval Status"::Approved then begin
                    paymentGridRec.SetRange("BLRContract ID", Rec."BLRContract ID");
                    if paymentGridRec.FindSet() then
                        repeat
                            paymentGridRec."BLRApproval Status" := paymentGridRec."BLRApproval Status"::Approved;
                            paymentGridRec.Modify();
                            pdcTransRec.SetRange("BLRpayment Series", paymentGridRec."BLRPayment Series");
                            pdcTransRec.SetRange("BLRContract ID", Rec."BLRContract ID");
                            if pdcTransRec.FindSet() then
                                repeat
                                    pdcTransRec."BLRApproval Status" := pdcTransRec."BLRApproval Status"::Approved;
                                    pdcTransRec.Modify();
                                until pdcTransRec.Next() = 0;
                        until paymentGridRec.Next() = 0;
                    Rec."BLROn-hold" := Rec."BLROn-hold"::"False";
                end;
                if Rec."BLRApproval Status" = Rec."BLRApproval Status"::Rejected then begin
                    paymentGridRec.SetRange("BLRContract ID", Rec."BLRContract ID");
                    if paymentGridRec.FindSet() then
                        repeat
                            paymentGridRec."BLRApproval Status" := paymentGridRec."BLRApproval Status"::Rejected;
                            paymentGridRec.Modify();
                        until paymentGridRec.Next() = 0;
                    Rec."BLROn-hold" := Rec."BLROn-hold"::"True";
                end;
                if Rec."BLROn-hold" = Rec."BLROn-hold"::"True" then begin
                    approvalPending := false;
                    Isrejected := false;
                    paymentSeriesRec.SetRange("BLRContract ID", Rec."BLRContract ID");
                    paymentSeriesRec.SetRange("BLRTenant Id", Rec."BLRTenant Id");
                    if paymentSeriesRec.FindSet() then
                        repeat
                            if paymentSeriesRec."BLRApproval Status" = paymentSeriesRec."BLRApproval Status"::Pending then begin
                                approvalPending := true;
                                break;
                            end
                            else
                                if paymentSeriesRec."BLRApproval Status" = paymentSeriesRec."BLRApproval Status"::Rejected then
                                    Isrejected := true;
                        until paymentSeriesRec.Next() = 0;
                    if ApprovalPending then
                        exit;
                    if approvalPending = false and Isrejected = true then
                        sendRejectionToLeaseTeam.SendPaymentRejectionToLeaseManager(paymentSeriesRec."BLRContract ID", paymentSeriesRec."BLRTenant Id", paymentSeriesRec."BLRContract ID");
                end;
            end;
        }
        field(73209580; "BLROn-hold"; Option)
        {
            OptionMembers = " ","True","False";
            DataClassification = CustomerContent;
        }
        field(73209581; "BLRIsupdated"; Option)
        {
            OptionMembers = " ","True","False";
            DataClassification = CustomerContent;
        }
        field(73209582; "BLRTenant Name"; Text[100])
        {
            Caption = 'Tenant Name';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(73209583; "BLRTenant Email"; Text[100])
        {
            Caption = 'Tenant Email';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(73209584; "BLRCombine Payment Series"; Text[150])
        {
            DataClassification = CustomerContent;
        }
        field(73209585; "BLRCombine Due Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209586; "BLRCombine Payment Mode"; Text[150])
        {
            DataClassification = CustomerContent;
            TableRelation = "BLRPaymentType"."BLRPayment Method";
        }
        field(73209587; "BLRCombine Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209588; "BLRCombine VAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209589; "BLRCombineAmtInclVAT"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209590; "BLRChange Payment Mode"; Text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "BLRPaymentType"."BLRPayment Method";
        }
        field(73209591; "BLRChange Payment Series"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209592; "BLRPayment Reminder"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Reminder';
            Editable = false;
        }
        field(73209593; "BLRC_Cheque_Number"; Text[20])
        {
            DataClassification = AccountData;
            Caption = 'Cheque Number';
        }
        field(73209594; "BLRC_Deposit_Bank"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Deposit Bank';
            TableRelation = "Bank Account";

            trigger OnValidate()
            var
                BankAccountRec: Record "Bank Account";
            begin
                if "BLRC_Deposit_Bank" <> '' then
                    // Attempt to find the Bank Account using the No. from the Deposit Bank
                    if BankAccountRec.Get("BLRC_Deposit_Bank") then
                        "BLRC_Deposit_Bank" := BankAccountRec."Name";
            end;
        }
        field(73209595; "BLRCP_Cheque_Number"; Text[20])
        {
            DataClassification = AccountData;
            Caption = 'Cheque Number';
        }
        field(73209596; "BLRCP_Deposit_Bank"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Deposit Bank';
            TableRelation = "Bank Account";

            trigger OnValidate()
            var
                BankAccountRec: Record "Bank Account";
            begin
                if "BLRCP_Deposit_Bank" <> '' then
                    if BankAccountRec.Get("BLRCP_Deposit_Bank") then
                        "BLRCP_Deposit_Bank" := BankAccountRec."Name";
            end;
        }
    }
    keys
    {
        key(PK;"BLRContract ID")
        {
            Clustered = true;
        }
    }
    procedure EvaluatePaymentSchedule()
    var
        PaymentScheduleRec: Record "BLRPaymentSchedule2";
        PaymentScheduleRec2: Record "BLRPaymentSchedule2";
        MergedRecord: Record "BLRPaymentMode2";
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
        PaymentScheduleRec.SetRange("BLRTenant ID", Rec."BLRTenant Id");
        PaymentScheduleRec.SetRange("BLRContract ID", Rec."BLRContract ID");
        if PaymentScheduleRec.FindSet() then
            repeat
                MinDueDate := PaymentScheduleRec."BLRDue Date";
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
            PaymentScheduleRec2.SetRange("BLRDue Date", MinDueDate);
            PaymentScheduleRec2.SetRange("BLRTenant ID", Rec."BLRTenant Id");
            PaymentScheduleRec2.SetRange("BLRContract ID", Rec."BLRContract ID");
            if PaymentScheduleRec2.FindSet() then
                repeat
                    TotalAmount += PaymentScheduleRec2."BLRAmount";
                    TotalVAT += PaymentScheduleRec2."BLRVAT Amount";
                    GrandTotal += PaymentScheduleRec2."BLRAmount Including VAT";
                until PaymentScheduleRec2.Next() = 0;
            SequenceNo := GetNextSequenceNo();
            NewPaymentCode := GeneratePaymentCode(SequenceNo);
            MergedRecord.Reset();
            MergedRecord.SetRange("BLRTenant Id", Rec."BLRTenant Id");
            MergedRecord.SetRange("BLRContract ID", Rec."BLRContract ID");
            MergedRecord.SetRange("BLRDue Date", MinDueDate);
            if not MergedRecord.FindFirst() then begin
                MergedRecord.Init();
                MergedRecord."BLRTenant Id" := Rec."BLRTenant Id";
                MergedRecord."BLRContract ID" := Rec."BLRContract ID";
                MergedRecord."BLRTenant Email" := Rec."BLRTenant Email";
                MergedRecord."BLRTenant Name" := Rec."BLRTenant Name";
                MergedRecord."BLRPayment Series" := NewPaymentCode;
                MergedRecord."BLRAmount" := TotalAmount;
                MergedRecord."BLRVAT Amount" := TotalVAT;
                MergedRecord."BLRAmount Including VAT" := GrandTotal;
                MergedRecord."BLRDue Date" := MinDueDate;
                MergedRecord."BLRPayment Status" := PaymentStatus::Scheduled;
                MergedRecord."BLRPayment Reminder" := Rec."BLRPayment Reminder";
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
        MergedRecord: Record "BLRPaymentMode2";
        MaxSequence: Integer;
        LastSequence: Text[10];
    begin
        MergedRecord.Reset();
        MergedRecord.SetRange("BLRContract ID", Rec."BLRContract ID");
        if MergedRecord.FindSet() then
            repeat
                LastSequence := CopyStr(MergedRecord."BLRPayment Series", 4, StrLen(MergedRecord."BLRPayment Series"));
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
        Paymentmodesubpage: Record "BLRPaymentMode2";
    begin
        Paymentmodesubpage.SetRange("BLRContract ID", Rec."BLRContract ID");
        if Paymentmodesubpage.FindSet() then
            repeat
                Paymentmodesubpage.DeleteAll();
            until Paymentmodesubpage.Next() = 0;
    end;
}
