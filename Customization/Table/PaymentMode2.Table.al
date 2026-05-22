table 73209646 "BLRPaymentMode2"
{
    DataClassification = CustomerContent;

    fields
    {

        field(73209575; "BLRPayment Series"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Series';

        }

        field(73209576; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';

        }

        field(73209577; "BLRVAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Amount';

        }

        field(73209578; "BLRAmount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount Including VAT';

        }

        field(73209579; "BLRDue Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date';



            // trigger OnValidate()
            // begin
            //     if Rec."BLRDue Date" <> xRec."BLRDue Date" then begin
            //         if Rec."BLRDue Date" = Today() then
            //             Rec."BLRPayment Status" := Rec."BLRPayment Status"::"Due"
            //         else if Rec."BLRDue Date" < Today() then
            //             Rec."BLRPayment Status" := Rec."BLRPayment Status"::"Overdue"
            //         else
            //             Rec."BLRPayment Status" := Rec."BLRPayment Status";

            //         Modify();
            //     end;
            // end;


            // trigger OnValidate()
            // begin
            //     // Check if the "BLRDue Date" matches today's date
            //     if Rec."BLRDue Date" = Today() then begin
            //         Rec."BLRPayment Status" := Rec."BLRPayment Status"::"Due"; // Update "BLRPayment Status" to "Due"
            //                                                              //  else 
            //                                                              //     // Reset the "BLRPayment Status" if "BLRDue Date" does not match
            //                                                              //     Rec."BLRPayment Status" := Rec."BLRPayment Status"::" "; // Or any default status
            //     end;

            //     // // Ensure the changes are saved

            //     if Rec."BLRDue Date" <= Today() then begin
            //         if Rec."BLRDue Date" = Today() then
            //             Rec."BLRPayment Status" := Rec."BLRPayment Status"::"Due" // Update "BLRPayment Status" to "Due"
            //         else
            //             Rec."BLRPayment Status" := Rec."BLRPayment Status"::"Overdue"; // Update "BLRPayment Status" to "Overdue"
            //     end;
            //     Modify();
            // end;

        }



        field(73209580; "BLRPayment Mode"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Mode';
            TableRelation = "BLRPaymentType"."BLRPayment Method";

            trigger OnValidate()
            var
                paymentschedule: Record "BLRPaymentSchedule2";
            begin
                paymentschedule.SetRange("BLRPayment Series", Rec."BLRPayment Series");
                paymentschedule.SetRange("BLRContract ID", Rec."BLRContract ID");
                if paymentschedule.FindSet() then
                    repeat
                        paymentschedule."BLRPayment Mode" := Rec."BLRPayment Mode";
                        paymentschedule.Modify();
                    until paymentschedule.Next() = 0;

            end;
        }

        field(73209581; "BLRCheque Number"; Text[20])
        {
            DataClassification = AccountData;
            Caption = 'Cheque Number';

            trigger OnValidate()
            var
                pdcTransRec: Record "BLRPDCTransaction";
                paymentGridRec: Record "BLRPaymentMode2";
                paymentschedule: Record "BLRPaymentSchedule2";
            begin
                paymentGridRec.SetRange("BLRCheque Number", Rec."BLRCheque Number");
                paymentGridRec.SetFilter("BLREntry No.", '<>%1', Rec."BLREntry No.");
                if not paymentGridRec.IsEmpty() then
                    Error('This cheque number has already been used.');


                pdcTransRec.SetRange("BLRpayment Series", Rec."BLRPayment Series");
                pdcTransRec.SetRange("BLRContract ID", Rec."BLRContract ID");
                if pdcTransRec.FindSet() then begin
                    pdcTransRec."BLRCheque Number" := Rec."BLRCheque Number";
                    pdcTransRec.Modify();
                end;

                paymentschedule.SetRange("BLRPayment Series", Rec."BLRPayment Series");
                paymentschedule.SetRange("BLRContract ID", Rec."BLRContract ID");
                if paymentschedule.FindSet() then
                    repeat
                        paymentschedule."BLRCheque Number" := Rec."BLRCheque Number";
                        paymentschedule.Modify();
                    until paymentschedule.Next() = 0;
            end;
        }

        field(73209582; "BLRDeposit Bank"; Code[100])
        {
            DataClassification = AccountData;
            Caption = 'Deposit Bank';
            TableRelation = "Bank Account"; // You can add a TableRelation here if required

            trigger OnValidate()
            var
                BankAccountRec: Record "Bank Account";
                pdcTransRec: Record "BLRPDCTransaction";
            begin
                // When a "BLRDeposit Bank" is selected (i.e., a Bank Account No. is provided)
                if "BLRDeposit Bank" <> '' then
                    // Attempt to find the Bank Account using the No. from the "BLRDeposit Bank"
                    if BankAccountRec.Get("BLRDeposit Bank") then
                        "BLRDeposit Bank" := BankAccountRec."Name"; // Populating the Name field from the Bank Account table

                pdcTransRec.SetRange("BLRpayment Series", Rec."BLRPayment Series");
                pdcTransRec.SetRange("BLRContract ID", Rec."BLRContract ID");
                if pdcTransRec.FindSet() then begin
                    pdcTransRec."BLRBank Name" := Rec."BLRDeposit Bank";
                    pdcTransRec.Modify();
                end;
            end;
        }

        field(73209583; "BLRDeposit Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "-","N","Y";
            Caption = 'Deposit Status';
        }

        field(73209584; "BLRPayment Status"; Enum "Payment Status")
        {
            DataClassification = CustomerContent;
            //OptionMembers = "Scheduled","Due","Received","Overdue","Cancelled";
            Caption = 'Payment Status';

            trigger OnValidate()
            var
                paymentmode2Grid: Record "BLRPaymentMode2";
                paymentschedule2: Record "BLRPaymentSchedule2";
                PDCTransRec: Record "BLRPDCTransaction";
                CashReceiptJournalCodeunit: Codeunit 73209580;
                Email: Codeunit "Send Payment Receipt";
                emailrec: Codeunit "Send PaymentMode Email";
                azureBlobUploader: Codeunit "Azure AD Blob Storage";
                TempBlob: Codeunit "Temp Blob";
                selectDate: Page "Select Date";
                RecRef: RecordRef;
                fileName: Text[250];
                uploadResult: Text[250];
                folderName: Text;
                ReportID: Integer; // Your report ID
                OutStream: OutStream;
                inStream: InStream;
            begin
                if (Rec."BLRPayment Mode" = 'Pending') or (Rec."BLRApproval Status" = Rec."BLRApproval Status"::Pending) then
                    Error('Please ensure the payment mode is selected and approved before updating the payment status.');

                case Rec."BLRPayment Status" of
                    Rec."BLRPayment Status"::Received:
                        begin
                            GenerateReceiptNumber();
                            Commit();
                            selectDate.Caption := 'Select "BLRReceipt Date" for ' + Rec."BLRReceipt #";
                            if selectDate.RunModal() = Action::OK then
                                Rec."BLRReceipt Date" := selectDate.GetDate()
                            else
                                Error('Receipt Date selection is mandatory to proceed.');

                            Rec.Modify();

                            if (Rec."BLRPayment Mode" = 'Cheque') and (Rec."BLRCheque Status" <> Rec."BLRCheque Status"::Cleared) then
                                Rec."BLRCheque Status" := Rec."BLRCheque Status"::Cleared;

                            if Rec."BLRPayment Mode" = 'Cheque' then begin
                                PDCTransRec.SetRange("BLRContract ID", Rec."BLRContract ID");
                                PDCTransRec.SetRange("BLRpayment Series", Rec."BLRPayment Series");
                                if PDCTransRec.FindFirst() then
                                    CashReceiptJournalCodeunit.CreateCashReceiptJournal(PDCTransRec, Rec."BLRReceipt Date");
                            end
                            else
                                CashReceiptJournalCodeunit.PaymentReceivedTransaction(Rec, Rec."BLRReceipt Date");

                            Email.SendEmail(Rec);
                            emailrec.SendEmail(Rec);

                            ReportID := 73209586;
                            paymentmode2Grid.Reset();
                            paymentmode2Grid.SetRange("BLRTenant Id", Rec."BLRTenant Id");
                            paymentmode2Grid.SetRange("BLRContract ID", Rec."BLRContract ID"); // Ensure filtering on unique ID
                            paymentmode2Grid.SetRange("BLRPayment Series", Rec."BLRPayment Series"); // Add this line to filter by "BLRPayment Series"

                            if not paymentmode2Grid.FindFirst() then
                                Error('Not avavilable');
                            RecRef.GetTable(paymentmode2Grid);
                            // RecRef.GetTable(Rec);
                            TempBlob.CreateOutStream(OutStream);
                            Report.SaveAs(ReportID, '', ReportFormat::Pdf, OutStream, RecRef);
                            TempBlob.CreateInStream(inStream);

                            // TempBlob.CreateInStream(InStream);
                            fileName := Rec."BLRReceipt #" + '.pdf';

                            folderName := 'Payment Receipt';
                            uploadResult := CopyStr(azureBlobUploader.UploadDocumentToBlob(inStream, fileName, folderName), 1, 250);
                            if fileName <> '' then begin
                                Rec."BLRView Invoice" := fileName;
                                Rec."BLRView Reciept document URL" := uploadResult;
                                Rec.Modify();
                                Message('File uploaded successfully: %1', fileName);
                            end;
                            Rec.Modify();
                            paymentschedule2.SetRange("BLRPayment Series", Rec."BLRPayment Series");
                            paymentschedule2.SetRange("BLRContract ID", Rec."BLRContract ID");
                            if paymentschedule2.FindSet() then
                                repeat
                                    paymentschedule2.Validate("BLRPayment Status", Format(Rec."BLRPayment Status"));
                                    paymentschedule2.Modify();
                                until paymentschedule2.Next() = 0
                        end;
                    Rec."BLRPayment Status"::Cancelled:

                        emailrec.SendEmailCancelled(Rec); // Call for Cancelled status
                                                          // Rec.Validate("BLRCheque Status", Rec."BLRCheque Status"::Retrieved);




                end;
            end;

        }

        field(73209585; "BLRCheque Status"; Enum "PDC Status Type Enum")
        {
            DataClassification = AccountData;
            // OptionMembers = "-","Cheque Received","Cleared","Deposited","Due & cheque not deposited","Retrieved","Returned","Replaced & Received","Deferred";
            Caption = 'Cheque Status';

            trigger OnValidate()
            var
                pdcTransRec: Record "BLRPDCTransaction";
            begin
                PDCTransRec.SetRange("BLRPayment Series", Rec."BLRPayment Series");
                PDCTransRec.SetRange("BLRContract ID", Rec."BLRContract ID");
                if PDCTransRec.FindFirst() then begin

                    PDCTransRec."BLRCheque Status" := PDCTransRec."BLRCheque Status"::Cancelled;
                    PDCTransRec.Modify();

                end;
            end;


        }

        field(73209586; "BLRInvoice #"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice #';
        }

        field(73209587; "BLRReceipt #"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Receipt #';
        }

        field(73209588; "BLROld Cheque #"; Text[100])
        {
            DataClassification = AccountData;
            Caption = 'Old Cheque #';
        }

        field(73209589; "BLRUpload Cheque"; Text[2048])
        {
            DataClassification = AccountData;
            Caption = 'Upload Cheque';
            InitValue = 'Upload Cheque';
        }


        field(73209590; "BLRDownload"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Download';
            InitValue = 'Download';
        }

        field(73209591; "BLRView"; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'View';
            InitValue = 'View';
        }

        field(73209592; "BLRView Revenue Details"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'View Revenue Details';
            InitValue = 'View Revenue Details';
        }
        field(73209593; "BLRView Document URL"; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'View Document URL';
            trigger OnValidate()
            var
                pdcTransRec: Record "BLRPDCTransaction";
            begin
                pdcTransRec.SetRange("BLRpayment Series", Rec."BLRPayment Series");
                pdcTransRec.SetRange("BLRContract ID", Rec."BLRContract ID");
                if pdcTransRec.FindSet() then begin
                    pdcTransRec."BLRView Document URL" := Rec."BLRView Document URL";
                    pdcTransRec.Modify();
                end;
            end;
        }


        field(73209594; "BLRTotal Amount"; Decimal)
        {
            Caption = 'Total Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("BLRPaymentMode2"."BLRAmount"
        where(
            "BLRContract ID" = field("BLRContract ID"),
            "BLRTenant Id" = field("BLRTenant Id"),
            "BLRPayment Status" = filter(<> 'Cancelled')
        ));
            // CalcFormula = sum("BLRPaymentMode2"."BLRAmount" where("BLRContract ID" = field("BLRContract ID"), "Tenant ID" = field("Tenant ID")));
        }

        field(73209595; "BLRTotal VAT Amount"; Decimal)
        {
            Caption = 'Total VAT Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("BLRPaymentMode2"."BLRVAT Amount" where("BLRContract ID" = field("BLRContract ID"), "BLRTenant Id" = field("BLRTenant Id"), "BLRPayment Status" = filter(<> 'Cancelled')));
        }
        field(73209596; "BLRTotal Amount Including VAT"; Decimal)
        {
            Caption = 'Total Amount Including VAT';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("BLRPaymentMode2"."BLRAmount Including VAT" where("BLRContract ID" = field("BLRContract ID"), "BLRTenant Id" = field("BLRTenant Id"), "BLRPayment Status" = filter(<> 'Cancelled')));
        }

        field(73209597; "BLRTenant Id"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant Id';
        }


        field(73209598; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }

        field(73209599; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }

        field(73209600; "BLRId"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(73209601; "BLRApproval Status"; Enum "Approval Status Enum")
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                paymentModeRec: Record "BLRPaymentMode";
                paymentGridRec: Record "BLRPaymentMode2";
                pdcTransRec: Record "BLRPDCTransaction";
                sendRejectionToLeaseTeam: Codeunit 73209618;
                approvalflow: Codeunit 73209605;
                AllApproved: Boolean;
                AnyPending: Boolean;
                AnyRejected: Boolean;
                CurrApproved: Boolean;
                CurrRejected: Boolean;
                CurrAnyPending: Boolean;
            begin
                pdcTransRec.SetRange("BLRpayment Series", Rec."BLRPayment Series");
                pdcTransRec.SetRange("BLRContract ID", Rec."BLRContract ID");
                if pdcTransRec.FindSet() then
                    repeat
                        pdcTransRec."BLRApproval Status" := Rec."BLRApproval Status";
                        pdcTransRec.Modify();
                    until pdcTransRec.Next() = 0;

                // Fetch the Parent Record (Main "BLRPayment Mode" Card)
                if paymentModeRec.Get(Rec."BLRContract ID") then begin

                    AllApproved := false;
                    AnyPending := false;
                    CurrApproved := false;
                    CurrAnyPending := false;
                    AnyRejected := false;
                    CurrRejected := false;

                    // Check if all grid records have "Approved" status
                    paymentGridRec.SetRange("BLRContract ID", Rec."BLRContract ID");
                    paymentGridRec.SetFilter("BLREntry No.", '<>%1', Rec."BLREntry No.");


                    if paymentGridRec.FindSet() then begin
                        // paymentGridRec.Init();
                        repeat
                            if (paymentGridRec."BLRApproval Status" = paymentGridRec."BLRApproval Status"::Approved) then
                                // AnyPending := false;
                                AllApproved := true
                            // AnyRejected := false;
                            else
                                if paymentGridRec."BLRApproval Status" = paymentGridRec."BLRApproval Status"::Pending then
                                    AnyPending := true
                                // AllApproved := false;
                                // AnyRejected := false;
                                else
                                    if paymentGridRec."BLRApproval Status" = paymentGridRec."BLRApproval Status"::Rejected then
                                        // AnyPending := false;
                                        // AllApproved := false;
                                        AnyRejected := true


                        until paymentGridRec.Next() = 0;

                        if (Rec."BLRApproval Status" = Rec."BLRApproval Status"::Approved) then begin
                            CurrAnyPending := false;
                            CurrApproved := true;
                            CurrRejected := false;
                        end
                        else
                            if Rec."BLRApproval Status" = Rec."BLRApproval Status"::Pending then begin
                                CurrAnyPending := true;
                                CurrApproved := false;
                                CurrRejected := false;
                            end
                            else
                                if Rec."BLRApproval Status" = Rec."BLRApproval Status"::Rejected then begin
                                    CurrAnyPending := false;
                                    CurrApproved := false;
                                    CurrRejected := true;
                                end;

                    end;

                    if AllApproved and CurrApproved and (not CurrRejected and not AnyRejected) and (not CurrAnyPending and not AnyPending) then begin
                        paymentModeRec."BLRApproval Status" := paymentModeRec."BLRApproval Status"::Approved;
                        paymentModeRec."BLROn-hold" := paymentModeRec."BLROn-hold"::"False";
                        paymentModeRec.Modify();
                        approvalflow.SendPaymentModeApprovalToFinanceManger(Format(paymentModeRec."BLRContract ID"), paymentModeRec."BLRTenant Id", paymentModeRec."BLRContract ID", false);
                    end
                    else
                        if AnyPending or CurrAnyPending then begin
                            paymentModeRec."BLROn-hold" := paymentModeRec."BLROn-hold"::"True";
                            paymentModeRec."BLRApproval Status" := paymentModeRec."BLRApproval Status"::Pending;
                            paymentModeRec.Modify();
                        end
                        else
                            if AnyRejected and CurrRejected and (not AllApproved and not CurrApproved) and (not AnyPending and not CurrAnyPending) then begin
                                paymentModeRec."BLRApproval Status" := paymentModeRec."BLRApproval Status"::Rejected;
                                paymentModeRec."BLROn-hold" := paymentModeRec."BLROn-hold"::"True";
                                paymentModeRec.Modify();
                                sendRejectionToLeaseTeam.SendPaymentRejectionToLeaseManager(paymentModeRec."BLRContract ID", paymentModeRec."BLRTenant Id", paymentModeRec."BLRContract ID");
                            end
                            else
                                if (AllApproved or CurrApproved) and (AnyRejected or CurrRejected) and (not AnyPending and not CurrAnyPending) then begin
                                    paymentModeRec."BLRApproval Status" := paymentModeRec."BLRApproval Status"::"On-Hold";
                                    paymentModeRec."BLROn-hold" := paymentModeRec."BLROn-hold"::"True";
                                    paymentModeRec.Modify();
                                    sendRejectionToLeaseTeam.SendPaymentRejectionToLeaseManager(paymentModeRec."BLRContract ID", paymentModeRec."BLRTenant Id", paymentModeRec."BLRContract ID");
                                end;
                    paymentModeRec.Modify();
                    if Rec."BLRApproval Status" = Rec."BLRApproval Status"::Approved then
                        Rec."BLRDeposit Status" := Rec."BLRDeposit Status"::"N"   // Ã¢Å“â€¦ Force N when approved
                end;
            end;
        }

        field(73209602; "BLRReason"; Text[150])
        {
            DataClassification = CustomerContent;
        }
        field(73209603; "BLRIsUpdated"; Option)
        {
            DataClassification = CustomerContent;
            // DataClassification = ToBeClassified;
            OptionMembers = " ","Yes","No";
        }

        field(73209604; "BLRApprove/Decline Status"; Text[50])
        {
            DataClassification = CustomerContent;
        }

        field(73209605; "BLRTenant Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Name';
        }

        field(73209606; "BLRTenant Email"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Email';
        }

        field(73209607; "BLRPayment Received Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209608; "BLRView Invoice"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'View Invoice';
        }
        field(73209609; "BLRView Reciept document URL"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'View Document URL';
        }

        field(73209610; "BLRPayment Reminder"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Reminder';
            Editable = false;

        }
        field(73209611; "BLRCredit Note No."; Code[100])
        {
            //OptionMembers = "0%","5%";
            DataClassification = CustomerContent;
            Caption = 'Credit Note No.';
        }

        field(73209612; "BLRCredit Note Amount"; Decimal)
        {
            //OptionMembers = "0%","5%";
            DataClassification = CustomerContent;
            Caption = 'Credit Note Amount';
        }
        field(73209613; "BLRFinal Rent Amount"; Decimal)
        {
            //OptionMembers = "0%","5%";
            DataClassification = CustomerContent;
            Caption = 'Final Rent Amount';
        }
        field(73209614; "BLRFinalRentAmountIncludingVAT"; Decimal)
        {
            //OptionMembers = "0%","5%";    
            DataClassification = CustomerContent;
            Caption = 'Final Rent Amount Including VAT';
        }
        field(73209615; "BLRPortalSidePaymentProcessing"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Portal Side Payment Processing';
        }
        field(73209616; "BLRReceipt Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Receipt Date';
        }


    }

    keys
    {
        key(Key1;"BLREntry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"BLRPayment Series", "BLRAmount")
        {
            Caption = 'Dropdown';

        }

    }

    trigger OnModify()
    var
        emailrec: Codeunit "Send PaymentMode Email";
    begin
        // Ã¢Å“â€¦ Check if "BLRPayment Status" has changed
        if Rec."BLRPayment Status" <> xRec."BLRPayment Status" then
            case Rec."BLRPayment Status" of
                Rec."BLRPayment Status"::Received:
                    emailrec.SendEmail(Rec);
                Rec."BLRPayment Status"::Cancelled:
                    emailrec.SendEmailCancelled(Rec);
            // Rec."BLRPayment Status"::Overdue:
            //     emailrec.SendEmailOverdue(Rec);
            end;
    end;

    procedure GenerateReceiptNumber()
    var
        noSeriesSetup: Record "BLRNoSeriesSetup";
        noseries: Codeunit "No. Series";
    begin
        if noSeriesSetup.Get() then
            Rec."BLRReceipt #" := noseries.GetNextNo(noSeriesSetup."BLRPayment Receipt ID Nos.")
        else
            Error('No. Series Setup not found for Construction Project Nos.');
    end;
}
