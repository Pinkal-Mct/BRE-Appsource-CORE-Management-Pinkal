page 73209656 "BLRRevenueAllocaApprovalList"
{
    PageType = List;
    SourceTable = "BLRRevenueAllocationApproval";
    ApplicationArea = All;
    Caption = 'Revenue Allocation Approval List';
    UsageCategory = Lists;
    InsertAllowed = false;
    ModifyAllowed = false;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Status"; Rec."BLRStatus")
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    Editable = false;
                    ToolTip = 'Specifies the current status of the revenue allocation approval.';
                }
                field("RA_ID"; Rec."BLRRA_ID")
                {
                    ApplicationArea = All;
                    Caption = 'RA_ID';
                    Editable = false;
                    ToolTip = 'Specifies the unique identifier for the revenue allocation approval.';
                }
                field("ID"; Rec."BLRID")
                {
                    ApplicationArea = All;
                    Caption = 'ID';
                    Editable = false;
                    DrillDown = true;
                    ToolTip = 'Specifies the unique identifier for the revenue allocation approval record.';

                    trigger OnDrillDown()
                    var
                        revenueallocation: Record "BLRRevenueAllocationDetails";
                    begin
                        revenueallocation.SetRange("BLRNo.", Rec."BLRID");
                        if revenueallocation.FindSet() then
                            PAGE.RunModal(PAGE::"Revenue Allocation Card", revenueallocation)
                        else
                            Message('No Revenue Allocation found using FindFirst either.');
                    end;
                }
                field("Financial Year"; Rec."BLRFinancial Year")
                {
                    ApplicationArea = All;
                    Caption = 'Financial Year';
                    Editable = false;
                    ToolTip = 'Specifies the financial year for which the revenue allocation approval is applicable.';
                }
                field("Month"; Rec."BLRMonth")
                {
                    ApplicationArea = All;
                    Caption = 'Month';
                    Editable = false;
                    ToolTip = 'Specifies the month for which the revenue allocation approval is applicable.';
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Preview)
            {
                ApplicationArea = All;
                Caption = 'Preview';
                Image = View;
                ToolTip = 'Preview the entries before approval or rejection.';

                trigger OnAction()
                var
                    revenueallocation: Record "BLRRevenueAllocationDetails";
                    Fetchmonth: Codeunit "BLRFetch Month";
                    RevenueAllocationPosting: Codeunit "BLRRevenue Allocation Posting";
                    Previewcheck: Boolean;
                    GetMonthNo: Integer;
                begin
                    Previewcheck := true;
                    GetMonthNo := Fetchmonth.GetMonthNo(Format(Rec."BLRMonth"));
                    if GetMonthNo <> 0 then
                        LastDateOfMonth := GetLastDateOfMonth(GetMonthNo, Rec."BLRFinancial Year");

                    if revenueallocation.Get(Rec."BLRID") then
                        RevenueAllocationPosting.PostRevenueAllocation(revenueallocation, Previewcheck, LastDateOfMonth);
                end;

            }
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Image = Approve;
                Visible = IsFinanceManager;
                ToolTip = 'Approve the current request after verification.';


                trigger OnAction()
                var
                    revenueallocation: Record "BLRRevenueAllocationDetails";
                    RevenueAllocationPosting: Codeunit "BLRRevenue Allocation Posting";
                    approvalRevenuerequest: Codeunit "BLRApproval Revenue Allocation";
                    Fetchmonth: Codeunit "BLRFetch Month";
                    GetMonthNo: Integer;
                    previewcheck: Boolean;
                begin
                    if Rec."BLRStatus" = Rec."BLRStatus"::Approved then
                        Error('This entry is already approved');

                    if Confirm('Do you want to approve this entry?') then begin
                        // Update entry status
                        GetMonthNo := Fetchmonth.GetMonthNo(Format(Rec."BLRMonth"));
                        if GetMonthNo <> 0 then
                            LastDateOfMonth := GetLastDateOfMonth(GetMonthNo, Rec."BLRFinancial Year");


                        if revenueallocation.Get(Rec."BLRID") then begin
                            previewcheck := false;
                            RevenueAllocationPosting.PostRevenueAllocation(revenueallocation, previewcheck, LastDateOfMonth);

                            revenueallocation."BLRStatus" := revenueallocation."BLRStatus"::Approve;
                            approvalRevenuerequest.ApprovalRevenuerequest(Rec);
                            revenueallocation.Modify();
                            Rec."BLRStatus" := Rec."BLRStatus"::Approved;
                            Rec.Modify();

                        end;

                        Message('Entry has been approved successfully!');
                    end;
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Image = Cancel;
                Visible = IsFinanceManager;
                ToolTip = 'Reject the current request as per your review.';

                trigger OnAction()
                var
                    revenueallocation: Record "BLRRevenueAllocationDetails";
                    approvalRevenuerequest: Codeunit "BLRApproval Revenue Allocation";
                begin
                    if Rec."BLRStatus" = Rec."BLRStatus"::Reject then
                        Error('This entry is already rejected');
                    // Update current record


                    // Update Credit Note record
                    if revenueallocation.Get(Rec."BLRID") then begin
                        revenueallocation."BLRStatus" := revenueallocation."BLRStatus"::Reject;
                        approvalRevenuerequest.RejectRevenuerequest(Rec);
                        revenueallocation.Modify();
                        Rec."BLRStatus" := Rec."BLRStatus"::Reject;
                        // Rec."Reason for Rejection" := ReasonForRejection;
                        Rec.Modify();
                    end;

                    Message('Entry has been rejected successfully!');
                end;


            }
        }

        area(Promoted)
        {
            actionref(Approve_; Approve) { }
            actionref(Reject_; Reject) { }
        }
    }

    trigger OnOpenPage()
    begin
        IsFinanceManager := VisibleApproveAction();
    end;

    procedure VisibleApproveAction(): Boolean
    var
        UserPersonalization: Record "User Personalization";
    begin

        if UserPersonalization.Get(UserSecurityId()) then
            case UserPersonalization."Profile ID" of
                'PROPERTY MANAGER':
                    exit(false);
                'LEASE MANAGER':
                    exit(false);
                'FINANCE MANAGER':
                    exit(true);
            end;


        exit(false);
    end;

    procedure GetLastDateOfMonth(MonthNo: Integer; Year: Integer): Date
    var
        MonthStartDate: Date;
    begin
        if MonthNo = 0 then
            exit(0D);

        MonthStartDate := DMY2DATE(1, MonthNo, Year);
        exit(CALCDATE('<CM>', MonthStartDate));
    end;

    var
        IsFinanceManager: Boolean;

        LastDateOfMonth: Date;
}
