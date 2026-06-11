table 73209622 "BLRFinalSettlement"
{
    DataClassification = CustomerContent;

    fields
    {

        field(73209575; "BLRFC ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Receivable FC ID';
        }
        field(73209576; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Receivable Contract ID';
        }

        field(73209577; "BLRReceivable from the Tenant"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Receivable from the Tenant';
        }

        field(73209578; "BLRPayment Processed"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Processed';
        }
        field(73209579; "BLRBalance Receivable"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Balance Receivable';
        }

        field(73209580; "BLRPaymentStatus"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Pending","Received";
            Caption = 'Payment Status';
        }


        field(73209581; "BLRReceivable Total Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Amount';
        }
        field(73209582; "BLRReceivable Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date';
        }
        field(73209583; "BLRReceivable Payment mode"; Text[300])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment mode';
            TableRelation = "BLRPaymentType"."BLRPayment Method";
        }
        field(73209584; "BLRReceivable Payment Status"; Enum "BLRPayment Status")
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Status';

            trigger OnValidate()
            var
                paymentmode2Grid: Record "BLRFinalSettlement";
                TempBlob: Codeunit "Temp Blob";
                Email: Codeunit "BLRFS_ReceivablePaymentReceipt";
                FinalSettlementPosting: Codeunit "BLRFinalSettlementPostingMgt.";
                azureBlobUploader: Codeunit "BLRAzure AD Blob Storage";
                RecRef: RecordRef;
                fileName: Text[250];
                uploadResult: Text;
                folderName: Text[250];
                inStream: InStream;
                ReportID: Integer;
                OutStream: OutStream;
            begin
                if Rec."BLRReceivable Payment Status" = Enum::"BLRPayment Status"::Received then
                    if (Rec."BLRReceivable Due Date" = 0D) or (Rec."BLRReceivable Due Date" > Today()) then begin
                        Rec."BLRReceivable Payment Status" := xRec."BLRReceivable Payment Status";
                        Error('Receivable Due Date is required. It must be today or in the past to mark payment status as Received.');
                    end;

                case Rec."BLRReceivable Payment mode" of
                    'Cheque':
                        if (Rec."BLRReceivable Cheque No." = '-') or (Rec."BLRDeposit Bank" = '') then begin
                            Rec."BLRReceivable Payment Status" := xRec."BLRReceivable Payment Status";
                            Error('Cheque details are incomplete. Please fill Cheque Number and Deposit Bank');
                        end;

                    'Bank Transfer', 'Credit Card', 'Mobile Wallet':
                        if Rec."BLRDeposit Bank" = '' then begin
                            Rec."BLRReceivable Payment Status" := xRec."BLRReceivable Payment Status";
                            Error('Deposit Bank must be entered for %1 payments.', Rec."BLRReceivable Payment mode");
                        end;
                end;


                if Confirm('Do you want to post journal lines?', true) then begin
                    FinalSettlementPosting.PostFinalSettlementAmount(Rec);
                    Rec."BLRPayment Receipt" := 'Receipt_' + Format(Rec."BLRContract ID") + Format(Rec."BLRFC ID");
                    Rec.Modify();
                    Email.SendEmail(Rec);
                    ReportID := 73209581;
                    paymentmode2Grid.Reset();
                    paymentmode2Grid.SetRange("BLRTenant ID", Rec."BLRTenant ID");
                    paymentmode2Grid.SetRange("BLRContract ID", Rec."BLRContract ID");
                    if not paymentmode2Grid.FindFirst() then
                        Error('Not avavilable');
                    RecRef.GetTable(paymentmode2Grid);
                    RecRef.GetTable(Rec);
                    TempBlob.CreateOutStream(OutStream);
                    Report.SaveAs(ReportID, '', ReportFormat::Pdf, OutStream, RecRef);
                    TempBlob.CreateInStream(inStream);
                    fileName := 'Receipt_' + Format(Rec."BLRContract ID") + Format(Rec."BLRFC ID") + '.pdf';
                    folderName := 'Payment Receipt';
                    uploadResult := azureBlobUploader.UploadDocumentToBlob(inStream, fileName, folderName);
                    if fileName <> '' then begin
                        Rec."BLRPmtRcptDocURL" := CopyStr(uploadResult, 1, StrLen(uploadResult));
                        Rec.Modify();
                        Message('File uploaded successfully: %1', fileName);
                    end;
                    Rec.Modify();
                end
                else
                    exit;
            end;
        }

        field(73209585; "BLRReceivable Cheque No."; Text[300])
        {
            DataClassification = AccountData;
            Caption = 'Cheque No.';
        }

        field(73209586; "BLRDeposit Bank"; Text[300])
        {
            DataClassification = AccountData;
            Caption = 'Deposit Bank';
            TableRelation = "Bank Account";

            trigger OnValidate()
            var
                BankAccountRec: Record "Bank Account";
            begin

                if "BLRDeposit Bank" <> '' then
                    if BankAccountRec.Get("BLRDeposit Bank") then
                        "BLRDeposit Bank" := BankAccountRec."Name";
            end;
        }

        field(73209587; "BLRDeposit Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Deposit Status';
            OptionMembers = "-","N","Y";
        }

        field(73209588; "BLRPayment Receipt"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Receipt';
            Editable = false;

        }
        field(73209589; "BLRPmtRcptDocURL"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Receipt Document URL';
        }
        field(73209590; "BLRTenant ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Receivable Tenant ID';
        }
        field(73209591; "BLRTenant Email"; Text[50])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Email';
        }
        field(73209592; "BLRTenant Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Name';
        }
        field(73209593; "BLRInvoiced"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoiced';
        }
        field(73209594; "BLRInvoice ID"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice ID';
        }
        field(73209595; "BLRView Reciept document URL"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice ID';
        }
        field(73209596; "BLRreceivablePaymentStatuss"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'receivablePaymentStatus';
        }
    }
    keys
    {
        key(PK; "BLRFC ID")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if Rec."BLRReceivable Payment mode" = 'Cheque' then
            if DelChr(Rec."BLRReceivable Cheque No.", '=', ' ') = '' then
                Error('Cheque Number cannot be blank when Payment Mode is Cheque.');
    end;

}

