table 50925 "Payment Mode2"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(50100; "Payment Series"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Series';

        }

        field(50101; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';

        }

        field(50102; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Amount';

        }

        field(50103; "Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount Including VAT';

        }

        field(50104; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Due Date';



            // trigger OnValidate()
            // begin
            //     if Rec."Due Date" <> xRec."Due Date" then begin
            //         if Rec."Due Date" = Today() then
            //             Rec."Payment Status" := Rec."Payment Status"::"Due"
            //         else if Rec."Due Date" < Today() then
            //             Rec."Payment Status" := Rec."Payment Status"::"Overdue"
            //         else
            //             Rec."Payment Status" := Rec."Payment Status";

            //         Modify();
            //     end;
            // end;


            // trigger OnValidate()
            // begin
            //     // Check if the Due Date matches today's date
            //     if Rec."Due Date" = Today() then begin
            //         Rec."Payment Status" := Rec."Payment Status"::"Due"; // Update Payment Status to "Due"
            //                                                              //  else 
            //                                                              //     // Reset the Payment Status if Due Date does not match
            //                                                              //     Rec."Payment Status" := Rec."Payment Status"::" "; // Or any default status
            //     end;

            //     // // Ensure the changes are saved

            //     if Rec."Due Date" <= Today() then begin
            //         if Rec."Due Date" = Today() then
            //             Rec."Payment Status" := Rec."Payment Status"::"Due" // Update Payment Status to "Due"
            //         else
            //             Rec."Payment Status" := Rec."Payment Status"::"Overdue"; // Update Payment Status to "Overdue"
            //     end;
            //     Modify();
            // end;

        }



        field(50105; "Payment Mode"; Text[100])
        {
            Caption = 'Payment Mode';
            TableRelation = "Payment Type"."Payment Method";

            trigger OnValidate()
            var
                paymentschedule: Record "Payment Schedule2";
            begin
                paymentschedule.SetRange("payment Series", Rec."Payment Series");
                paymentschedule.SetRange("Contract ID", Rec."Contract ID");
                if paymentschedule.FindSet() then
                    repeat
                        paymentschedule."Payment Mode" := Rec."Payment Mode";
                        paymentschedule.Modify();
                    until paymentschedule.Next() = 0;

            end;
        }

        field(50106; "Cheque Number"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cheque Number';

            trigger OnValidate()
            var
                pdcTransRec: Record "PDC Transaction";
                paymentGridRec: Record "Payment Mode2";
                paymentschedule: Record "Payment Schedule2";
            begin
                paymentGridRec.SetRange("Cheque Number", Rec."Cheque Number");
                paymentGridRec.SetFilter("Entry No.", '<>%1', Rec."Entry No.");
                if not paymentGridRec.IsEmpty() then
                    Error('This cheque number has already been used.');


                pdcTransRec.SetRange("payment Series", Rec."Payment Series");
                pdcTransRec.SetRange("Contract ID", Rec."Contract ID");
                if pdcTransRec.FindSet() then begin
                    pdcTransRec."Cheque Number" := Rec."Cheque Number";
                    pdcTransRec.Modify();
                end;

                paymentschedule.SetRange("payment Series", Rec."Payment Series");
                paymentschedule.SetRange("Contract ID", Rec."Contract ID");
                if paymentschedule.FindSet() then
                    repeat
                        paymentschedule."Cheque Number" := Rec."Cheque Number";
                        paymentschedule.Modify();
                    until paymentschedule.Next() = 0;
            end;
        }

        field(50107; "Deposit Bank"; Code[100])
        {
            Caption = 'Deposit Bank';
            TableRelation = "Bank Account"; // You can add a TableRelation here if required

            trigger OnValidate()
            var
                BankAccountRec: Record "Bank Account";
                pdcTransRec: Record "PDC Transaction";
            begin
                // When a Deposit Bank is selected (i.e., a Bank Account No. is provided)
                if "Deposit Bank" <> '' then
                    // Attempt to find the Bank Account using the No. from the Deposit Bank
                    if BankAccountRec.Get("Deposit Bank") then
                        "Deposit Bank" := BankAccountRec."Name"; // Populating the Name field from the Bank Account table

                pdcTransRec.SetRange("payment Series", Rec."Payment Series");
                pdcTransRec.SetRange("Contract ID", Rec."Contract ID");
                if pdcTransRec.FindSet() then begin
                    pdcTransRec."Bank Name" := Rec."Deposit Bank";
                    pdcTransRec.Modify();
                end;
            end;
        }

        field(50108; "Deposit Status"; Option)
        {
            OptionMembers = "-","N","Y";
            Caption = 'Deposit Status';
        }

        field(50112; "Payment Status"; Enum "Payment Status")
        {
            //OptionMembers = "Scheduled","Due","Received","Overdue","Cancelled";
            Caption = 'Payment Status';

            trigger OnValidate()
            var
                paymentmode2Grid: Record "Payment Mode2";
                paymentschedule2: Record "Payment Schedule2";
                PDCTransRec: Record "PDC Transaction";
                CashReceiptJournalCodeunit: Codeunit 50514;
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
                if (Rec."Payment Mode" = 'Pending') or (Rec."Approval Status" = Rec."Approval Status"::Pending) then
                    Error('Please ensure the payment mode is selected and approved before updating the payment status.');

                case Rec."Payment Status" of
                    Rec."Payment Status"::Received:
                        begin
                            GenerateReceiptNumber();
                            Commit();
                            selectDate.Caption := 'Select Receipt Date for ' + Rec."Receipt #";
                            if selectDate.RunModal() = Action::OK then
                                Rec."Receipt Date" := selectDate.GetDate()
                            else
                                Error('Receipt Date selection is mandatory to proceed.');

                            Rec.Modify();

                            if (Rec."Payment Mode" = 'Cheque') and (Rec."Cheque Status" <> Rec."Cheque Status"::Cleared) then
                                Rec."Cheque Status" := Rec."Cheque Status"::Cleared;

                            if Rec."Payment Mode" = 'Cheque' then begin
                                PDCTransRec.SetRange("Contract ID", Rec."Contract ID");
                                PDCTransRec.SetRange("payment Series", Rec."Payment Series");
                                if PDCTransRec.FindFirst() then
                                    CashReceiptJournalCodeunit.CreateCashReceiptJournal(PDCTransRec, Rec."Receipt Date");
                            end
                            else
                                CashReceiptJournalCodeunit.PaymentReceivedTransaction(Rec, Rec."Receipt Date");

                            Email.SendEmail(Rec);
                            emailrec.SendEmail(Rec);

                            ReportID := 50112;
                            paymentmode2Grid.Reset();
                            paymentmode2Grid.SetRange("Tenant ID", Rec."Tenant ID");
                            paymentmode2Grid.SetRange("Contract ID", Rec."Contract ID"); // Ensure filtering on unique ID
                            paymentmode2Grid.SetRange("Payment Series", Rec."Payment Series"); // Add this line to filter by Payment Series

                            if not paymentmode2Grid.FindFirst() then
                                Error('Not avavilable');
                            RecRef.GetTable(paymentmode2Grid);
                            // RecRef.GetTable(Rec);
                            TempBlob.CreateOutStream(OutStream);
                            Report.SaveAs(ReportID, '', ReportFormat::Pdf, OutStream, RecRef);
                            TempBlob.CreateInStream(inStream);

                            // TempBlob.CreateInStream(InStream);
                            fileName := Rec."Receipt #" + '.pdf';

                            folderName := 'Payment Receipt';
                            uploadResult := CopyStr(azureBlobUploader.UploadDocumentToBlob(inStream, fileName, folderName), 1, 250);
                            if fileName <> '' then begin
                                Rec."View Invoice" := fileName;
                                Rec."View Reciept document URL" := uploadResult;
                                Rec.Modify();
                                Message('File uploaded successfully: %1', fileName);
                            end;
                            Rec.Modify();
                            paymentschedule2.SetRange("payment Series", Rec."Payment Series");
                            paymentschedule2.SetRange("Contract ID", Rec."Contract ID");
                            if paymentschedule2.FindSet() then
                                repeat
                                    paymentschedule2.Validate("Payment Status", Format(Rec."Payment Status"));
                                    paymentschedule2.Modify();
                                until paymentschedule2.Next() = 0
                        end;
                    Rec."Payment Status"::Cancelled:

                        emailrec.SendEmailCancelled(Rec); // Call for Cancelled status
                                                          // Rec.Validate("Cheque Status", Rec."Cheque Status"::Retrieved);




                end;
            end;

        }

        field(50113; "Cheque Status"; Enum "PDC Status Type Enum")
        {
            // OptionMembers = "-","Cheque Received","Cleared","Deposited","Due & cheque not deposited","Retrieved","Returned","Replaced & Received","Deferred";
            Caption = 'Cheque Status';

            trigger OnValidate()
            var
                pdcTransRec: Record "PDC Transaction";
            begin
                PDCTransRec.SetRange("Payment Series", Rec."payment Series");
                PDCTransRec.SetRange("Contract ID", Rec."Contract ID");
                if PDCTransRec.FindFirst() then begin

                    PDCTransRec."Cheque Status" := PDCTransRec."Cheque Status"::Cancelled;
                    PDCTransRec.Modify();

                end;
            end;


        }

        field(50114; "Invoice #"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Invoice #';
        }

        field(50115; "Receipt #"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Receipt #';
        }

        field(50116; "Old Cheque #"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Old Cheque #';
        }

        field(50117; "Upload Cheque"; Text[2048])
        {
            DataClassification = ToBeClassified;
            Caption = 'Upload Cheque';
            InitValue = 'Upload Cheque';
        }


        field(50118; "Download"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Download';
            InitValue = 'Download';
        }

        field(50120; "View"; Text[2048])
        {
            DataClassification = ToBeClassified;
            Caption = 'View';
            InitValue = 'View';
        }

        field(50119; "View Revenue Details"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'View Revenue Details';
            InitValue = 'View Revenue Details';
        }
        field(50121; "View Document URL"; Text[2048])
        {
            DataClassification = ToBeClassified;
            Caption = 'View Document URL';
            trigger OnValidate()
            var
                pdcTransRec: Record "PDC Transaction";
            begin
                pdcTransRec.SetRange("payment Series", Rec."Payment Series");
                pdcTransRec.SetRange("Contract ID", Rec."Contract ID");
                if pdcTransRec.FindSet() then begin
                    pdcTransRec."View Document URL" := Rec."View Document URL";
                    pdcTransRec.Modify();
                end;
            end;
        }


        field(50123; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Mode2".Amount
        where(
            "Contract ID" = field("Contract ID"),
            "Tenant ID" = field("Tenant ID"),
            "Payment Status" = filter(<> 'Cancelled')
        ));
            // CalcFormula = sum("Payment Mode2".Amount where("Contract ID" = field("Contract ID"), "Tenant ID" = field("Tenant ID")));
        }

        field(50912; "Total VAT Amount"; Decimal)
        {
            Caption = 'Total VAT Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Mode2"."VAT Amount" where("Contract ID" = field("Contract ID"), "Tenant ID" = field("Tenant ID"), "Payment Status" = filter(<> 'Cancelled')));
        }
        field(50913; "Total Amount Including VAT"; Decimal)
        {
            Caption = 'Total Amount Including VAT';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Mode2"."Amount Including VAT" where("Contract ID" = field("Contract ID"), "Tenant ID" = field("Tenant ID"), "Payment Status" = filter(<> 'Cancelled')));
        }

        field(50110; "Tenant Id"; Code[20])
        {
            Caption = 'Tenant Id';
        }


        field(50111; "Contract ID"; Integer)
        {
            Caption = 'Contract ID';
        }

        field(50122; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(50124; "Id"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50125; "Approval Status"; Enum "Approval Status Enum")
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                paymentModeRec: Record "Payment Mode";
                paymentGridRec: Record "Payment Mode2";
                pdcTransRec: Record "PDC Transaction";
                sendRejectionToLeaseTeam: Codeunit 50511;
                approvalflow: Codeunit 50510;
                AllApproved: Boolean;
                AnyPending: Boolean;
                AnyRejected: Boolean;
                CurrApproved: Boolean;
                CurrRejected: Boolean;
                CurrAnyPending: Boolean;
            begin
                pdcTransRec.SetRange("payment Series", Rec."Payment Series");
                pdcTransRec.SetRange("Contract ID", Rec."Contract ID");
                if pdcTransRec.FindSet() then
                    repeat
                        pdcTransRec."Approval Status" := Rec."Approval Status";
                        pdcTransRec.Modify();
                    until pdcTransRec.Next() = 0;

                // Fetch the Parent Record (Main Payment Mode Card)
                if paymentModeRec.Get(Rec."Contract ID") then begin

                    AllApproved := false;
                    AnyPending := false;
                    CurrApproved := false;
                    CurrAnyPending := false;
                    AnyRejected := false;
                    CurrRejected := false;

                    // Check if all grid records have "Approved" status
                    paymentGridRec.SetRange("Contract ID", Rec."Contract ID");
                    paymentGridRec.SetFilter("Entry No.", '<>%1', Rec."Entry No.");


                    if paymentGridRec.FindSet() then begin
                        // paymentGridRec.Init();
                        repeat
                            if (paymentGridRec."Approval Status" = paymentGridRec."Approval Status"::Approved) then
                                // AnyPending := false;
                                AllApproved := true
                            // AnyRejected := false;
                            else
                                if paymentGridRec."Approval Status" = paymentGridRec."Approval Status"::Pending then
                                    AnyPending := true
                                // AllApproved := false;
                                // AnyRejected := false;
                                else
                                    if paymentGridRec."Approval Status" = paymentGridRec."Approval Status"::Rejected then
                                        // AnyPending := false;
                                        // AllApproved := false;
                                        AnyRejected := true


                        until paymentGridRec.Next() = 0;

                        if (Rec."Approval Status" = Rec."Approval Status"::Approved) then begin
                            CurrAnyPending := false;
                            CurrApproved := true;
                            CurrRejected := false;
                        end
                        else
                            if Rec."Approval Status" = Rec."Approval Status"::Pending then begin
                                CurrAnyPending := true;
                                CurrApproved := false;
                                CurrRejected := false;
                            end
                            else
                                if Rec."Approval Status" = Rec."Approval Status"::Rejected then begin
                                    CurrAnyPending := false;
                                    CurrApproved := false;
                                    CurrRejected := true;
                                end;

                    end;

                    if AllApproved and CurrApproved and (not CurrRejected and not AnyRejected) and (not CurrAnyPending and not AnyPending) then begin
                        paymentModeRec."Approval Status" := paymentModeRec."Approval Status"::Approved;
                        paymentModeRec."On-hold" := paymentModeRec."On-hold"::"False";
                        paymentModeRec.Modify();
                        approvalflow.SendPaymentModeApprovalToFinanceManger(Format(paymentModeRec."Contract ID"), paymentModeRec."Tenant Id", paymentModeRec."Contract ID", false);
                    end
                    else
                        if AnyPending or CurrAnyPending then begin
                            paymentModeRec."On-hold" := paymentModeRec."On-hold"::"True";
                            paymentModeRec."Approval Status" := paymentModeRec."Approval Status"::Pending;
                            paymentModeRec.Modify();
                        end
                        else
                            if AnyRejected and CurrRejected and (not AllApproved and not CurrApproved) and (not AnyPending and not CurrAnyPending) then begin
                                paymentModeRec."Approval Status" := paymentModeRec."Approval Status"::Rejected;
                                paymentModeRec."On-hold" := paymentModeRec."On-hold"::"True";
                                paymentModeRec.Modify();
                                sendRejectionToLeaseTeam.SendPaymentRejectionToLeaseManager(paymentModeRec."Contract ID", paymentModeRec."Tenant Id", paymentModeRec."Contract ID");
                            end
                            else
                                if (AllApproved or CurrApproved) and (AnyRejected or CurrRejected) and (not AnyPending and not CurrAnyPending) then begin
                                    paymentModeRec."Approval Status" := paymentModeRec."Approval Status"::"On-Hold";
                                    paymentModeRec."On-hold" := paymentModeRec."On-hold"::"True";
                                    paymentModeRec.Modify();
                                    sendRejectionToLeaseTeam.SendPaymentRejectionToLeaseManager(paymentModeRec."Contract ID", paymentModeRec."Tenant Id", paymentModeRec."Contract ID");
                                end;
                    paymentModeRec.Modify();
                    if Rec."Approval Status" = Rec."Approval Status"::Approved then
                        Rec."Deposit Status" := Rec."Deposit Status"::"N"   // ✅ Force N when approved
                end;
            end;
        }

        field(50126; "Reason"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50127; "IsUpdated"; Option)
        {
            // DataClassification = ToBeClassified;
            OptionMembers = " ","Yes","No";
        }

        field(50128; "Approve/Decline Status"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50129; "Tenant Name"; Text[100])
        {
            Caption = 'Tenant Name';
        }

        field(50130; "Tenant Email"; Text[100])
        {
            Caption = 'Tenant Email';
        }

        field(50131; "Payment Received Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50132; "View Invoice"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'View Invoice';
        }
        field(50133; "View Reciept document URL"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'View Document URL';
        }

        field(50134; "Payment Reminder"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Reminder';
            Editable = false;

        }
        field(50929; "Credit Note No."; Code[100])
        {
            //OptionMembers = "0%","5%";
            DataClassification = ToBeClassified;
            Caption = 'Credit Note No.';
        }

        field(50935; "Credit Note Amount"; Decimal)
        {
            //OptionMembers = "0%","5%";
            DataClassification = ToBeClassified;
            Caption = 'Credit Note Amount';
        }
        field(50936; "Final Rent Amount"; Decimal)
        {
            //OptionMembers = "0%","5%";
            DataClassification = ToBeClassified;
            Caption = 'Final Rent Amount';
        }
        field(50937; "FinalRentAmountIncludingVAT"; Decimal)
        {
            //OptionMembers = "0%","5%";    
            DataClassification = ToBeClassified;
            Caption = 'Final Rent Amount Including VAT';
        }
        field(50938; "PortalSidePaymentProcessing"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Portal Side Payment Processing';
        }
        field(50939; "Receipt Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Receipt Date';
        }


    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Payment Series", "Amount")
        {
            Caption = 'Dropdown';

        }

    }

    trigger OnModify()
    var
        emailrec: Codeunit "Send PaymentMode Email";
    begin
        // ✅ Check if Payment Status has changed
        if Rec."Payment Status" <> xRec."Payment Status" then
            case Rec."Payment Status" of
                Rec."Payment Status"::Received:
                    emailrec.SendEmail(Rec);
                Rec."Payment Status"::Cancelled:
                    emailrec.SendEmailCancelled(Rec);
            // Rec."Payment Status"::Overdue:
            //     emailrec.SendEmailOverdue(Rec);
            end;
    end;

    procedure GenerateReceiptNumber()
    var
        noSeriesSetup: Record "No. Series Setup";
        noseries: Codeunit "No. Series";
    begin
        if noSeriesSetup.Get() then
            Rec."Receipt #" := noseries.GetNextNo(noSeriesSetup."Payment Receipt ID Nos.")
        else
            Error('No. Series Setup not found for Construction Project Nos.');
    end;
}
