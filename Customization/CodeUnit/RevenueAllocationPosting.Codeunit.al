codeunit 73209603 "Revenue Allocation Posting"
{
    Subtype = Normal;

    procedure PostRevenueAllocation(RevenueAllocationRec: Record "Revenue Allocation Details"; preview: Boolean)
    var
        RevenueAllocationGrid: Record "Revenue Allocation SubGrid";
        COASetup: Record "COA Setup";
        COASetupLine: Record "COA Setup Line";
        OtherChargesAllocationGrid: Record "Revenue Recognition Details";
        GenJournalLineRec: Record "Gen. Journal Line";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        LineNumber: Integer;
        ErrorMessage: Text;

    begin


        COASetup.Get();

        if COASetup."Commercial Unearned Rent" = '' then
            ErrorMessage := 'Commercial Unearned Rent account is not setup. Please setup and try again.' + '\n';

        if COASetup."Residential Unearned Rent" = '' then
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

        RevenueAllocationGrid.SetRange("Header No.", RevenueAllocationRec."No.");
        RevenueAllocationGrid.SetFilter("Total Value", '<>0');
        if RevenueAllocationGrid.FindSet() then begin
            LineNumber := 0;
            repeat

                LineNumber := GenJournalLineRec."Line No." + 10000;
                GenJournalLineRec.Init();
                GenJournalLineRec."Journal Template Name" := 'GENERAL';
                GenJournalLineRec."Journal Batch Name" := 'REVENUE';
                GenJournalLineRec."Line No." := LineNumber;
                GenJournalLineRec."Account Type" := GenJournalLineRec."Account Type"::"G/L Account";
                GenJournalLineRec."Document No." := RevenueAllocationGrid.Description;
                GenJournalLineRec."Posting Date" := Today;
                GenJournalLineRec."Contract ID" := RevenueAllocationGrid."Contract ID";
                GenJournalLineRec.Description := 'Rent - ' + RevenueAllocationGrid."Posting Period";
                // GenJournalLineRec.Amount := RevenueAllocationGrid."Total Value";
                GenJournalLineRec.Validate(Amount, RevenueAllocationGrid."Total Value");
                GenJournalLineRec."Bal. Account Type" := GenJournalLineRec."Bal. Account Type"::"G/L Account";
                if (RevenueAllocationGrid."Unit Type" = 'COMMERCIAL') or (RevenueAllocationGrid."Unit Type" = 'Commercial') then begin
                    GenJournalLineRec."Account No." := COASetup."Commercial Unearned Rent";
                    GenJournalLineRec."Bal. Account No." := COASetup."Commercial Rent";
                end
                else
                    if (RevenueAllocationGrid."Unit Type" = 'RESIDENTIAL') or (RevenueAllocationGrid."Unit Type" = 'Residential') then begin
                        GenJournalLineRec."Account No." := COASetup."Residential Unearned Rent";
                        GenJournalLineRec."Bal. Account No." := COASetup."Residential Rent";
                    end;

                GenJournalLineRec.Insert();

            until RevenueAllocationGrid.Next() = 0;

        end
        else
            Error('No Revenue Allocation records found to post.');

        OtherChargesAllocationGrid.SetRange("RR_No.", RevenueAllocationRec."No.");
        OtherChargesAllocationGrid.SetFilter("Total Value", '<>0');

        if OtherChargesAllocationGrid.FindSet() then begin
            LineNumber := GenJournalLineRec."Line No." + 10000;
            repeat
                COASetupLine.SetRange("Secondary Item", OtherChargesAllocationGrid."Item Type");
                COASetupLine.FindFirst();

                LineNumber := GenJournalLineRec."Line No." + 10000;
                GenJournalLineRec.Init();
                GenJournalLineRec."Journal Template Name" := 'GENERAL';
                GenJournalLineRec."Journal Batch Name" := 'REVENUE';
                GenJournalLineRec."Line No." := LineNumber;
                GenJournalLineRec."Account Type" := GenJournalLineRec."Account Type"::"G/L Account";
                GenJournalLineRec."Document No." := OtherChargesAllocationGrid.Description;
                GenJournalLineRec."Posting Date" := Today;
                GenJournalLineRec."Contract ID" := OtherChargesAllocationGrid."Contract ID";
                GenJournalLineRec.Description := OtherChargesAllocationGrid."Item Type" + ' - ' + OtherChargesAllocationGrid."Posting Period";
                // GenJournalLineRec.Amount := OtherChargesAllocationGrid.Amount;
                GenJournalLineRec.Validate(Amount, OtherChargesAllocationGrid."Total Value");
                GenJournalLineRec."Bal. Account Type" := GenJournalLineRec."Bal. Account Type"::"G/L Account";
                if (OtherChargesAllocationGrid."Unit Type" = 'COMMERCIAL') or (OtherChargesAllocationGrid."Unit Type" = 'Commercial') then begin
                    GenJournalLineRec."Account No." := COASetupLine."Commercial-Unearned";
                    GenJournalLineRec."Bal. Account No." := COASetupLine.Commercial;
                end
                else
                    if (OtherChargesAllocationGrid."Unit Type" = 'RESIDENTIAL') or (OtherChargesAllocationGrid."Unit Type" = 'Residential') then begin
                        GenJournalLineRec."Account No." := COASetupLine."Residential-Unearned";
                        GenJournalLineRec."Bal. Account No." := COASetupLine.Residential;

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