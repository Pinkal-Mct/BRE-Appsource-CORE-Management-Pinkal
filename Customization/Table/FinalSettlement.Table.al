table 73209622 "FinalSettlement"
{
    DataClassification = CustomerContent;

    fields
    {

        field(73209575; "FC ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Receivable FC ID';
        }
        field(73209576; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Receivable Contract ID';
        }

        field(73209577; "Receivable from the Tenant"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Receivable from the Tenant';
        }

        field(73209578; "Payment Processed"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Processed';
        }
        field(73209579; "Balance Receivable"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Balance Receivable';
        }

        field(73209580; "PaymentStatus"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Pending","Received";
            Caption = 'Payment Status';
        }


        field(73209581; "Receivable Total Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Amount';
        }
        field(73209582; "Receivable Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date';
        }
        field(73209583; "Receivable Payment mode"; Text[300])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment mode';
            TableRelation = "Payment Type"."Payment Method";
        }
        field(73209584; "Receivable Payment Status"; Enum "Payment Status")
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Status';

            trigger OnValidate()
            var
                paymentmode2Grid: Record FinalSettlement;
                TempBlob: Codeunit "Temp Blob";
                Email: Codeunit "FS_Receivable Payment Receipt";
                FinalSettlementPosting: Codeunit "Final Settlement Posting Mgt.";
                azureBlobUploader: Codeunit "Azure AD Blob Storage";
                RecRef: RecordRef;
                fileName: Text[250];
                uploadResult: Text;
                folderName: Text[250];
                inStream: InStream;
                ReportID: Integer;
                OutStream: OutStream;
            begin
                if Rec."Receivable Payment Status" = Enum::"Payment Status"::Received then
                    if (Rec."Receivable Due Date" = 0D) or (Rec."Receivable Due Date" > Today()) then begin
                        Rec."Receivable Payment Status" := xRec."Receivable Payment Status";
                        Error('Receivable Due Date is required. It must be today or in the past to mark payment status as Received.');
                    end;

                case Rec."Receivable Payment mode" of
                    'Cheque':
                        if (Rec."Receivable Cheque No." = '-') or (Rec."Deposit Bank" = '') then begin
                            Rec."Receivable Payment Status" := xRec."Receivable Payment Status";
                            Error('Cheque details are incomplete. Please fill Cheque Number and Deposit Bank');
                        end;

                    'Bank Transfer', 'Credit Card', 'Mobile Wallet':
                        if Rec."Deposit Bank" = '' then begin
                            Rec."Receivable Payment Status" := xRec."Receivable Payment Status";
                            Error('Deposit Bank must be entered for %1 payments.', Rec."Receivable Payment mode");
                        end;
                end;


                if Confirm('Do you want to post journal lines?', true) then begin
                    FinalSettlementPosting.PostFinalSettlementAmount(Rec);
                    Email.SendEmail(Rec);
                    ReportID := 73209581;
                    paymentmode2Grid.Reset();
                    paymentmode2Grid.SetRange("Tenant ID", Rec."Tenant ID");
                    paymentmode2Grid.SetRange("Contract ID", Rec."Contract ID");
                    if not paymentmode2Grid.FindFirst() then
                        Error('Not avavilable');
                    RecRef.GetTable(paymentmode2Grid);
                    RecRef.GetTable(Rec);
                    TempBlob.CreateOutStream(OutStream);
                    Report.SaveAs(ReportID, '', ReportFormat::Pdf, OutStream, RecRef);
                    TempBlob.CreateInStream(inStream);
                    fileName := 'Receipt_' + Format(Rec."Contract ID") + Format(Rec."FC ID") + '.pdf';
                    folderName := 'Payment Receipt';
                    uploadResult := azureBlobUploader.UploadDocumentToBlob(inStream, fileName, folderName);
                    if fileName <> '' then begin
                        Rec."Payment Receipt" := fileName;
                        Rec."Payment Receipt document URL" := CopyStr(uploadResult, 1, StrLen(uploadResult));
                        Rec.Modify();
                        Message('File uploaded successfully: %1', fileName);
                    end;
                    Rec.Modify();
                end
                else
                    exit;
            end;
        }

        field(73209585; "Receivable Cheque No."; Text[300])
        {
            DataClassification = AccountData;
            Caption = 'Cheque No.';
        }

        field(73209586; "Deposit Bank"; Text[300])
        {
            DataClassification = AccountData;
            Caption = 'Deposit Bank';
            TableRelation = "Bank Account";

            trigger OnValidate()
            var
                BankAccountRec: Record "Bank Account";
            begin

                if "Deposit Bank" <> '' then
                    if BankAccountRec.Get("Deposit Bank") then
                        "Deposit Bank" := BankAccountRec."Name";
            end;
        }

        field(73209587; "Deposit Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Deposit Status';
            OptionMembers = "-","N","Y";
        }

        field(73209588; "Payment Receipt"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Receipt';
            Editable = false;

        }
        field(73209589; "Payment Receipt document URL"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Receipt Document URL';
        }
        field(73209590; "Tenant ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Receivable Tenant ID';
        }
        field(73209591; "Tenant Email"; Text[50])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Email';
        }
        field(73209592; "Tenant Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Name';
        }
        field(73209593; "Invoiced"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoiced';
        }
        field(73209594; "Invoice ID"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice ID';
        }
        field(73209595; "View Reciept document URL"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice ID';
        }
        field(73209596; "receivablePaymentStatuss"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'receivablePaymentStatus';
        }
    }
    keys
    {
        key(PK; "FC ID")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if Rec."Receivable Payment Mode" = 'Cheque' then
            if DelChr(Rec."Receivable Cheque No.", '=', ' ') = '' then
                Error('Cheque Number cannot be blank when Payment Mode is Cheque.');
    end;

}

