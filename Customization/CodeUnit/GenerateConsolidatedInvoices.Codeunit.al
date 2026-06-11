codeunit 73209593 BLRGenerateConsolidatedInvoice
{
    trigger OnRun()
    var
        paymentScheudle2: Record "BLRPaymentSchedule2";
        SalesHeader: Record "Sales Header";
        newsalesheader: Record "Sales Header";
        paymentschedul1: Record "BLRPaymentSchedule";
        paymentScheudle3: Record "BLRPaymentSchedule2";
        newsalesheader1: Record "Sales Header";
        SalesHeader1: Record "Sales Header";
        paymentschedule2grid: Record "BLRPaymentSchedule2";
        customercard: Record Customer;
        salesheader1card: Record "Sales Header";
        salesheader1card1: Record "Sales Header";
        paymentschedulecardpage: Record "BLRPaymentSchedule";
        paymentscheduleRecord: Record "BLRPaymentSchedule";
        todaydate: Date;
        currentdate: Date;
    begin
        todaydate := Today();
        currentdate := Today();
        paymentScheudle3.SetFilter("BLRDue Date", '<%1', todaydate);
        paymentScheudle3.SetFilter("BLRPayment Series", '<>%1', 'PAY01');
        paymentScheudle3.SetRange("BLRContract Status", 'Active');
        if paymentScheudle3.FindSet() then
            repeat
                if paymentScheudle3."BLRContract Status" = 'Terminated' then
                    exit
                else begin
                    paymentscheduleRecord.SetRange("BLRContract ID", paymentScheudle3."BLRContract ID");
                    paymentscheduleRecord.SetFilter("BLRContract Status", 'Suspended');
                    if paymentscheduleRecord.FindFirst() then begin
                        paymentScheudle3."BLRContract Status" := paymentscheduleRecord."BLRContract Status";
                        paymentScheudle3.Modify();
                    end else
                        if paymentScheudle3."BLRInvoiced" = false then begin
                            SalesHeader1.SetRange("BLRContract ID", paymentScheudle3."BLRContract ID");
                            SalesHeader1.SetRange("BLROverdue Invoice", 'Reactive');
                            SalesHeader1.SetRange("Due Date", currentdate);
                            SalesHeader1.SetRange("Document Type", Enum::"Sales Document Type"::Invoice);
                            if SalesHeader1.FindSet() then
                                createSalesLines(SalesHeader1, paymentScheudle3)
                            else begin
                                newsalesheader1 := CreateSalesInvoice(paymentScheudle3."BLRTenant ID", currentdate, paymentScheudle3."BLRContract ID", paymentScheudle3."BLRTenant Name", paymentScheudle3."BLRProperty Classification");
                                customercard.SetRange("No.", newsalesheader1."Sell-to Customer No.");
                                if customercard.FindSet() then
                                    if newsalesheader1."BLRProperty Classification" <> '' then begin
                                        customercard.Validate("Gen. Bus. Posting Group", newsalesheader1."BLRProperty Classification");
                                        customercard.Validate("Customer Posting Group", newsalesheader1."BLRProperty Classification");
                                        customercard.Modify();
                                    end;

                                if newsalesheader1."BLRProperty Classification" <> '' then begin
                                    newsalesheader1.Validate("Gen. Bus. Posting Group", newsalesheader1."BLRProperty Classification");
                                    newsalesheader1.Validate("Customer Posting Group", newsalesheader1."BLRProperty Classification");
                                    newsalesheader1.Modify();
                                end;
                                createSalesLines(newsalesheader1, paymentScheudle3);
                            end;

                            newsalesheader1."BLROverdue Invoice" := 'Reactive';
                            newsalesheader1.Modify();

                            paymentScheudle3."BLRInvoice ID" := newsalesheader1."No.";
                            paymentScheudle3."BLRInvoiced" := true;
                            paymentScheudle3."BLROverdue Invoice" := newsalesheader1."BLROverdue Invoice";
                            paymentScheudle3.Modify();
                        end;
                end;
            until paymentScheudle3.Next() = 0;
        paymentScheudle2.SetRange("BLRContract start date", todaydate);
        paymentScheudle2.SetRange("BLRDue Date", todaydate);
        if paymentScheudle2.FindSet() then
            repeat
                if paymentScheudle2."BLRContract Status" = 'Terminated' then
                    exit
                else begin
                    paymentschedul1.SetRange("BLRContract ID", paymentScheudle2."BLRContract ID");
                    paymentschedul1.SetFilter("BLRContract Status", 'Suspended');
                    if paymentschedul1.FindFirst() then begin
                        paymentScheudle2."BLRContract Status" := paymentschedul1."BLRContract Status";
                        paymentScheudle2.Modify();
                    end else
                        if paymentScheudle2."BLRInvoiced" = false then begin
                            SalesHeader.SetRange("BLRContract ID", paymentScheudle2."BLRContract ID");
                            SalesHeader.SetRange("Due Date", paymentScheudle2."BLRDue Date");
                            SalesHeader.SetRange("Document Type", Enum::"Sales Document Type"::Invoice);
                            if SalesHeader.FindSet() then
                                createSalesLines(SalesHeader, paymentScheudle2)
                            else begin
                                newsalesheader := CreateSalesInvoice(paymentScheudle2."BLRTenant ID", paymentScheudle2."BLRDue Date", paymentScheudle2."BLRContract ID", paymentScheudle2."BLRTenant Name", paymentScheudle2."BLRProperty Classification");
                                customercard.SetRange("No.", newsalesheader."Sell-to Customer No.");
                                if customercard.FindSet() then
                                    if newsalesheader."BLRProperty Classification" <> '' then begin
                                        customercard.Validate("Gen. Bus. Posting Group", newsalesheader."BLRProperty Classification");
                                        customercard.Validate("Customer Posting Group", newsalesheader."BLRProperty Classification");
                                        customercard.Modify();
                                    end;
                                if newsalesheader."BLRProperty Classification" <> '' then begin
                                    newsalesheader.Validate("Gen. Bus. Posting Group", newsalesheader."BLRProperty Classification");
                                    newsalesheader.Validate("Customer Posting Group", newsalesheader."BLRProperty Classification");
                                    newsalesheader.Modify();
                                end;
                                createSalesLines(newsalesheader, paymentScheudle2);
                            end;
                            paymentScheudle2."BLRInvoiced" := true;
                            paymentScheudle2."BLRInvoice ID" := newsalesheader."No.";
                            paymentScheudle2.Modify();
                        end;
                end;
            until paymentScheudle2.Next() = 0 else begin
            paymentschedule2grid.SetRange("BLRWorkflow frequency date", todaydate);
            if paymentschedule2grid.FindSet() then
                repeat
                    if paymentschedule2grid."BLRContract Status" = 'Terminated' then
                        exit
                    else begin
                        paymentschedulecardpage.SetRange("BLRContract ID", paymentschedule2grid."BLRContract ID");
                        paymentschedulecardpage.SetFilter("BLRContract Status", 'Suspended');
                        if paymentschedulecardpage.FindFirst() then begin
                            paymentschedule2grid."BLRContract Status" := paymentschedulecardpage."BLRContract Status";
                            paymentschedule2grid.Modify();
                        end else
                            if paymentschedule2grid."BLRInvoiced" = false then begin
                                salesheader1card.SetRange("BLRContract ID", paymentschedule2grid."BLRContract ID");
                                salesheader1card.SetRange("Due Date", paymentschedule2grid."BLRDue Date");
                                salesheader1card.SetRange("Document Type", Enum::"Sales Document Type"::Invoice);
                                if salesheader1card.FindSet() then
                                    createSalesLines(salesheader1card, paymentschedule2grid)
                                else begin
                                    salesheader1card1 := CreateSalesInvoice(paymentschedule2grid."BLRTenant ID", paymentschedule2grid."BLRDue Date", paymentschedule2grid."BLRContract ID", paymentschedule2grid."BLRTenant Name", paymentschedule2grid."BLRProperty Classification");
                                    customercard.SetRange("No.", salesheader1card1."Sell-to Customer No.");
                                    if customercard.FindSet() then
                                        if salesheader1card1."BLRProperty Classification" <> '' then begin
                                            customercard.Validate("Gen. Bus. Posting Group", salesheader1card1."BLRProperty Classification");
                                            customercard.Validate("Customer Posting Group", salesheader1card1."BLRProperty Classification");
                                            customercard.Modify();
                                        end;
                                    if salesheader1card1."BLRProperty Classification" <> '' then begin
                                        salesheader1card1.Validate("Gen. Bus. Posting Group", salesheader1card1."BLRProperty Classification");
                                        salesheader1card1.Validate("Customer Posting Group", salesheader1card1."BLRProperty Classification");
                                        salesheader1card1.Modify();
                                    end;
                                    createSalesLines(salesheader1card1, paymentschedule2grid);
                                end;
                                paymentschedule2grid."BLRInvoiced" := true;
                                paymentschedule2grid."BLRInvoice ID" := salesheader1card1."No.";
                                paymentschedule2grid.Modify();
                            end;
                    end;
                until paymentschedule2grid.Next() = 0;
        end;
    end;

    procedure CreateSalesInvoice(TenantID: Code[20]; DueDate: Date; ContractID: Integer; TenantName: Text[100]; PropertyClassification: Text[100]): Record "Sales Header"
    var
        salesHeader: Record "Sales Header";
        salesReciveable: Record "Sales & Receivables Setup";
        noseries: Codeunit "No. Series";
    begin
        salesHeader.Init();
        if salesReciveable.FindSet() then
            salesHeader."No." := noseries.GetNextNo(salesReciveable."Invoice Nos.", Today(), true);
        salesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
        salesHeader.Validate("Sell-to Customer No.", TenantID);
        salesHeader."Bill-to Customer No." := TenantID;
        salesHeader."Bill-to Name" := TenantName;
        salesHeader."Sell-to Customer Name" := TenantName;
        salesHeader."Due Date" := DueDate;
        salesHeader."BLRContract ID" := ContractID;
        salesHeader."BLRTenant Name" := TenantName;
        salesHeader."Document Date" := Today();
        salesHeader."VAT Reporting Date" := Today();
        salesHeader."Posting Date" := Today();
        salesHeader."Shipment Date" := Today();
        salesHeader."Posting No. Series" := salesReciveable."Posted Invoice Nos.";
        salesHeader."BLRProperty Classification" := PropertyClassification;
        salesHeader.Insert();

        exit(salesHeader);

    end;

    procedure createSalesLines(salesheader1: Record "Sales Header"; newpaymentschedule2: Record "BLRPaymentSchedule2")
    var
        saleline: Record "Sales Line";
        newSaleslines: Record "Sales Line";
        item: Record Item;
        RoundDecimal: Decimal;
    begin
        saleline.Init();
        saleline."Document Type" := saleline."Document Type"::Invoice;
        newSaleslines.SetRange("Document No.", salesheader1."No.");
        newSaleslines.SetRange("Document Type", Enum::"Sales Document Type"::Invoice);
        newSaleslines.SetRange("BLRContract ID", salesheader1."BLRContract ID");
        newSaleslines.SetCurrentKey("Line No.");
        if newSaleslines.FindLast() then
            saleline."Line No." := newSaleslines."Line No." + 1000
        else
            saleline."Line No." := 1000;
        saleline.Validate("Document No.", salesheader1."No.");
        saleline.Validate("BLRContract ID", salesheader1."BLRContract ID");
        saleline.Validate("Type", saleline.Type::Item);
        saleline.Validate("Sell-to Customer No.", salesheader1."Sell-to Customer No.");
        item.SetRange(Description, newpaymentschedule2."BLRSecondary Item Type");
        item.SetFilter("BLRCharges Status", '<>%1', item."BLRCharges Status"::" ");
        if item.FindFirst() then begin
            saleline.Validate("No.", item."No.");
            saleline.Validate(Description, item.Description);
            saleline.Validate("Gen. Prod. Posting Group", item."Gen. Prod. Posting Group");
            saleline.Validate("VAT Prod. Posting Group", item."VAT Prod. Posting Group");
            saleline.Validate("Unit of Measure Code", item."Base Unit of Measure");
        end;
        saleline.Validate("Quantity (Base)", 1);
        saleline.Validate(Quantity, 1);
        RoundDecimal := Abs(Round(newpaymentschedule2."BLRAmount", 0.01));
        saleline.Validate("Unit Price", RoundDecimal);
        saleline.Validate("Qty. to Invoice", 1);
        saleline.Validate("Qty. to Ship", 1);
        saleline.Validate("Qty. to Invoice (Base)", 1);
        saleline.Validate("Outstanding Qty. (Base)", 1);
        saleline.Validate("Outstanding Quantity", 1);
        saleline.Validate("VAT Base Amount", newpaymentschedule2."BLRVAT Amount");
        saleline.Validate("Amount Including VAT", saleline."Line Amount" + newpaymentschedule2."BLRVAT Amount");
        saleline.Validate("Outstanding Amount", saleline.Quantity * saleline."Unit Price");
        saleline.Validate("Outstanding Amount (LCY)", saleline.Quantity * saleline."Unit Price");
        saleline.Insert();
        Clear(saleline);
    end;
}