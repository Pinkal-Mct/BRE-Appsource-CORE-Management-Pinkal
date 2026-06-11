codeunit 73209603 "BLRRevenue Allocation Posting"
{
    Subtype = Normal;

    procedure PostRevenueAllocation(RevenueAllocationRec: Record "BLRRevenueAllocationDetails"; preview: Boolean; LastDateOfMonth: Date)
    var
        RevenueAllocationGrid: Record "BLRRevenueAllocationSubGrid";
        COASetup: Record "BLRCOASetup";
        COASetupLine: Record "BLRCOASetupLine";
        OtherChargesAllocationGrid: Record "BLRRevenueRecognitionDetails";
        GenJournalLineRec: Record "Gen. Journal Line";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        LineNumber: Integer;
        ErrorMessage: Text;

    begin


        COASetup.Get();

        if COASetup."BLRCommercial Unearned Rent" = '' then
            ErrorMessage := 'Commercial Unearned Rent account is not setup. Please setup and try again.' + '\n';

        if COASetup."BLRResidential Unearned Rent" = '' then
            ErrorMessage := ErrorMessage + 'Residential Unearned Rent account is not setup. Please setup and try again.' + '\n';

        if ErrorMessage <> '' then
            Error(ErrorMessage);

        //Load journal template and batch
        // if not GenJournalTemplate.Get('GENERAL') then
        //     Error('General Journal Template not found.');

        // JournalBatchName := 'DEFAULT';
        // if not GenJournalBatch.Get(GenJournalTemplate.Name, JournalBatchName) then
        //     Error('General Journal Batch %1 not found.', JournalBatchName);

        // Clear existing lines (optional, based on use case)

        GenJournalLineRec.DeleteAll();

        // Loop through the Revenue Allocation records

        RevenueAllocationGrid.SetRange("BLRHeader No.", RevenueAllocationRec."BLRNo.");
        RevenueAllocationGrid.SetFilter("BLRTotal Value", '<>0');
        if RevenueAllocationGrid.FindSet() then begin
            LineNumber := 0;
            repeat

                LineNumber := GenJournalLineRec."Line No." + 10000;
                GenJournalLineRec.Init();
                GenJournalLineRec."Journal Template Name" := 'GENERAL';
                GenJournalLineRec."Journal Batch Name" := 'DEFAULT';
                GenJournalLineRec."Line No." := LineNumber;
                GenJournalLineRec."Account Type" := GenJournalLineRec."Account Type"::"G/L Account";
                GenJournalLineRec."Document No." := RevenueAllocationGrid."BLRDescription";
                GenJournalLineRec."Posting Date" := LastDateOfMonth;
                GenJournalLineRec."BLRContract ID" := RevenueAllocationGrid."BLRContract Id";
                GenJournalLineRec.Description := 'Rent - ' + RevenueAllocationGrid."BLRPosting Period";
                // GenJournalLineRec.Amount := RevenueAllocationGrid."BLRTotal Value";
                GenJournalLineRec.Validate(Amount, RevenueAllocationGrid."BLRTotal Value");
                GenJournalLineRec."Bal. Account Type" := GenJournalLineRec."Bal. Account Type"::"G/L Account";
                if (RevenueAllocationGrid."BLRUnit Type" = 'COMMERCIAL') or (RevenueAllocationGrid."BLRUnit Type" = 'Commercial') then begin
                    GenJournalLineRec."Account No." := COASetup."BLRCommercial Unearned Rent";
                    GenJournalLineRec."Bal. Account No." := COASetup."BLRCommercial Rent";
                end
                else
                    if (RevenueAllocationGrid."BLRUnit Type" = 'RESIDENTIAL') or (RevenueAllocationGrid."BLRUnit Type" = 'Residential') then begin
                        GenJournalLineRec."Account No." := COASetup."BLRResidential Unearned Rent";
                        GenJournalLineRec."Bal. Account No." := COASetup."BLRResidential Rent";
                    end;

                GenJournalLineRec.Insert();

            until RevenueAllocationGrid.Next() = 0;

        end
        else
            Error('No Revenue Allocation records found to post.');

        OtherChargesAllocationGrid.SetRange("BLRRR_No.", RevenueAllocationRec."BLRNo.");
        OtherChargesAllocationGrid.SetFilter("BLRTotal Value", '<>0');

        if OtherChargesAllocationGrid.FindSet() then begin
            LineNumber := GenJournalLineRec."Line No." + 10000;
            repeat
                COASetupLine.SetRange("BLRSecondary Item", OtherChargesAllocationGrid."BLRItem Type");
                COASetupLine.FindFirst();

                LineNumber := GenJournalLineRec."Line No." + 10000;
                GenJournalLineRec.Init();
                GenJournalLineRec."Journal Template Name" := 'GENERAL';
                GenJournalLineRec."Journal Batch Name" := 'DEFAULT';
                GenJournalLineRec."Line No." := LineNumber;
                GenJournalLineRec."Account Type" := GenJournalLineRec."Account Type"::"G/L Account";
                GenJournalLineRec."Document No." := OtherChargesAllocationGrid."BLRDescription";
                GenJournalLineRec."Posting Date" := LastDateOfMonth;
                GenJournalLineRec."BLRContract ID" := OtherChargesAllocationGrid."BLRContract Id";
                GenJournalLineRec.Description := OtherChargesAllocationGrid."BLRItem Type" + ' - ' + OtherChargesAllocationGrid."BLRPosting Period";
                // GenJournalLineRec.Amount := OtherChargesAllocationGrid.Amount;
                GenJournalLineRec.Validate(Amount, OtherChargesAllocationGrid."BLRTotal Value");
                GenJournalLineRec."Bal. Account Type" := GenJournalLineRec."Bal. Account Type"::"G/L Account";
                if (OtherChargesAllocationGrid."BLRUnit Type" = 'COMMERCIAL') or (OtherChargesAllocationGrid."BLRUnit Type" = 'Commercial') then begin
                    GenJournalLineRec."Account No." := COASetupLine."BLRCommercial-Unearned";
                    GenJournalLineRec."Bal. Account No." := COASetupLine."BLRCommercial";
                end
                else
                    if (OtherChargesAllocationGrid."BLRUnit Type" = 'RESIDENTIAL') or (OtherChargesAllocationGrid."BLRUnit Type" = 'Residential') then begin
                        GenJournalLineRec."Account No." := COASetupLine."BLRResidential-Unearned";
                        GenJournalLineRec."Bal. Account No." := COASetupLine."BLRResidential";

                    end;

                GenJournalLineRec.Insert();


            until OtherChargesAllocationGrid.Next() = 0;
        end else
            Error('No Other Charges Allocation records found to post.');

        if not preview then begin
            GenJnlPost.Run(GenJournalLineRec);
            Message('Revenue Allocation has been posted successfully.');
        end
        else begin

            Commit();
            GenJnlPost.Preview(GenJournalLineRec);
        end;
    end;
}