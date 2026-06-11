codeunit 73209589 "BLRCredit Memo Generate"
{
    Subtype = Normal;
    procedure GenerateCreditMemo(RequestCreditnoteGrid: Record "BLRRequestCreditNoteGrid")
    var
        RequestGrid: Record "BLRRequestCreditNoteGrid";
        Customer: Record Customer;
        customercard: Record Customer;
        NewSalesHeader: Record "Sales Header";
        GridPerSeries: Record "BLRRequestCreditNoteGrid";
        SalesPost: Codeunit "Sales-Post";
        PaymentSeriesList: List of [Code[20]];
        CurrentSeries: Code[20];
    begin
        Customer.SetRange("No.", RequestCreditnoteGrid."BLRTenant No.");
        if Customer.IsEmpty() then
            Error('Customer not found for the given Sales Credit Memo.');
        RequestGrid.SetRange("BLRRequest No.", RequestCreditnoteGrid."BLRRequest No.");
        RequestGrid.SetRange("BLRContract ID", RequestCreditnoteGrid."BLRContract ID");
        if not RequestGrid.FindSet() then
            Error('No credit note lines found for the request.');
        repeat
            if not PaymentSeriesList.Contains(RequestGrid."BLRPayment Series") then
                PaymentSeriesList.Add(RequestGrid."BLRPayment Series");
        until RequestGrid.Next() = 0;
        foreach CurrentSeries in PaymentSeriesList do begin
            GridPerSeries.Reset();
            GridPerSeries.SetRange("BLRRequest No.", RequestCreditnoteGrid."BLRRequest No.");
            GridPerSeries.SetRange("BLRContract ID", RequestCreditnoteGrid."BLRContract ID");
            GridPerSeries.SetRange("BLRPayment Series", CurrentSeries);
            GridPerSeries.SetFilter("BLRCredit Memo Generated", '=false');
            GridPerSeries.SetFilter("BLRInvoiced", '=true');
            if GridPerSeries.FindFirst() then begin
                NewSalesHeader := CreateSalesHeader(GridPerSeries."BLRContract ID", GridPerSeries."BLRTenant No.", GridPerSeries."BLRProperty Classification", GridPerSeries."BLRInvoice ID");
                customercard.SetRange("No.", NewSalesHeader."Sell-to Customer No.");
                if customercard.FindFirst() then
                    if NewSalesHeader."BLRProperty Classification" <> '' then begin
                        customercard.Validate("Gen. Bus. Posting Group", NewSalesHeader."BLRProperty Classification");
                        customercard.Validate("Customer Posting Group", NewSalesHeader."BLRProperty Classification");
                        customercard.Modify();
                    end;
                if NewSalesHeader."BLRProperty Classification" <> '' then begin
                    NewSalesHeader.Validate("Gen. Bus. Posting Group", NewSalesHeader."BLRProperty Classification");
                    NewSalesHeader.Validate("Customer Posting Group", NewSalesHeader."BLRProperty Classification");
                    NewSalesHeader.Modify();
                end;
                createSalesLines(NewSalesHeader, RequestCreditnoteGrid, CurrentSeries);
                Createdocument(NewSalesHeader);
                SalesPost.Run(NewSalesHeader);
                Message('✅ Sales Credit Memo created for Payment Series %1 with No. %2', CurrentSeries, NewSalesHeader."No.");
            end;
        end;
    end;

    procedure CreateSalesHeader(pContractID: Integer; pTenantID: Code[50]; pUnitType: Text[50]; pInvoiceID: Code[50]): Record "Sales Header"
    var
        SalesHeader: Record "Sales Header";
        salesReciveable: Record "Sales & Receivables Setup";
        noseries: Codeunit "No. Series";
    begin
        salesHeader.Init();
        if salesReciveable.FindFirst() then
            salesHeader."No." := noseries.GetNextNo(salesReciveable."Credit Memo Nos.", Today, true);
        salesHeader."Document Type" := SalesHeader."Document Type"::"Credit Memo";
        salesHeader.Validate("Sell-to Customer No.", pTenantID);
        salesHeader.Validate("BLRContract ID", pContractID);
        salesHeader."Document Date" := Today;
        salesHeader."Posting Date" := Today;
        salesHeader."Due Date" := Today;
        salesHeader."BLRProperty Classification" := pUnitType;
        salesHeader."Posting No. Series" := salesReciveable."Posted Credit Memo Nos.";
        salesHeader."BLRApproval Status for CreditNote" := SalesHeader."BLRApproval Status for CreditNote"::Approved;
        SalesHeader.Validate("Applies-to Doc. Type", SalesHeader."Applies-to Doc. Type"::Invoice);
        SalesHeader.Validate("Applies-to Doc. No.", pInvoiceID);
        salesHeader.Insert();
        exit(salesHeader);
    end;

    procedure createSalesLines(
        var salesheader1: Record "Sales Header";
        RequestCreditnoteGrid: Record "BLRRequestCreditNoteGrid";
        paymentSeries: Code[20]
    )
    var
        saleline: Record "Sales Line";
        newSaleslines: Record "Sales Line";
        item: Record Item;
        requestcreditnotegridRec: Record "BLRRequestCreditNoteGrid";
    begin
        requestcreditnotegridRec.SetRange("BLRRequest No.", RequestCreditnoteGrid."BLRRequest No.");
        requestcreditnotegridRec.SetRange("BLRContract ID", RequestCreditnoteGrid."BLRContract ID");
        requestcreditnotegridRec.SetRange("BLRPayment Series", paymentSeries);
        requestcreditnotegridRec.SetFilter("BLRCredit Memo Generated", '=false');
        RequestCreditnoteGrid.SetFilter("BLRInvoiced", '=true');
        if requestcreditnotegridRec.FindSet() then
            repeat
                saleline.Init();
                saleline."Document Type" := saleline."Document Type"::"Credit Memo";
                saleline.Validate("Document No.", salesheader1."No.");
                newSaleslines.SetRange("Document No.", salesheader1."No.");
                newSaleslines.SetRange("Document Type", Enum::"Sales Document Type"::"Credit Memo");
                newSaleslines.SetRange("BLRContract ID", salesheader1."BLRContract ID");
                newSaleslines.SetCurrentKey("Line No.");
                if newSaleslines.FindLast() then
                    saleline."Line No." := newSaleslines."Line No." + 1000
                else
                    saleline."Line No." := 1000;
                saleline.Validate("BLRContract ID", salesheader1."BLRContract ID");
                saleline.Type := saleline.Type::Item;
                saleline.Validate("Sell-to Customer No.", salesheader1."Sell-to Customer No.");
                item.SetRange(Description, requestcreditnotegridRec."BLRCharges");
                if item.FindFirst() then
                    saleline.Validate("No.", item."No.")
                else
                    Error('No item found with description "%1"', requestcreditnotegridRec."BLRCharges");
                saleline.Validate("Quantity (Base)", 1);
                saleline.Validate(Quantity, 1);
                saleline.Validate("Unit Price", Abs(requestcreditnotegridRec."BLRTotal Reduction"));
                saleline."BLRContract ID" := requestcreditnotegridRec."BLRContract ID";
                saleline.Insert();
                requestcreditnotegridRec.Validate("BLRCredit Memo Generated", true);
                requestcreditnotegridRec."BLRCredit Note No." := salesheader1."No.";
                requestcreditnotegridRec.Modify();
            until requestcreditnotegridRec.Next() = 0;
    end;

    procedure Createdocument(var SalesheaderRec: Record "Sales Header")
    var
        ConfigRecord: Record "BLRAzureConfiguration";
        SalesHeader1: Record "Sales Header";
        azureBlobUploader: Codeunit "BLRAzure AD Blob Storage";
        TempBlob: Codeunit "Temp Blob";
        RecRef: RecordRef;
        InStream: InStream;
        FileName: Text;
        SASUrlBase: Text;
        UploadResult: Text;
        ValidFormats: List of [Text];
        FileExtension: Text[10];
        ReportID: Integer;
        OutStream: OutStream;
        folderName: Text;
    begin
        if SalesheaderRec."BLRApproval Status for CreditNote" <> SalesheaderRec."BLRApproval Status for CreditNote"::Approved then
            Error('The Sales Credit Memo cannot be posted because the approval status is not "Approved".');
        if not ConfigRecord.FindFirst() then
            Error('Azure configuration is missing. Please set up the SAS URL in the Azure Configuration table.');
        ValidFormats.Add('.png');
        ValidFormats.Add('.jpg');
        ValidFormats.Add('.jpeg');
        SASUrlBase := ConfigRecord."BLRSAS URL";
        FileExtension := '.pdf';
        ReportID := 73209580;
        SalesHeader1.Reset();
        SalesHeader1.SetRange("No.", SalesheaderRec."No.");
        SalesHeader1.SetRange("Document Type", SalesheaderRec."Document Type"::"Credit Memo");
        if not SalesHeader1.FindFirst() then
            Error('Sales Credit memo record not found.');
        RecRef.GetTable(SalesHeader1);
        TempBlob.CreateOutStream(OutStream);
        Report.SaveAs(ReportID, '', ReportFormat::Pdf, OutStream, RecRef);
        TempBlob.CreateInStream(InStream);
        FileName := 'CreditNote' + SalesheaderRec."No." + FileExtension;
        folderName := 'SalesCreditMemoDocuments';
        UploadResult := azureBlobUploader.UploadDocumentToBlob(InStream, FileName, folderName);
        SalesheaderRec."BLRCredit Memo Document" := CopyStr(FileName, 1, StrLen(FileName));
        SalesheaderRec."BLRCredit Memo URL" := CopyStr(UploadResult, 1, StrLen(UploadResult));
        SalesheaderRec.Modify();
    end;
}
