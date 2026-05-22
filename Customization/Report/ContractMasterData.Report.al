namespace PropertyManagement.PropertyManagement;
using System.Utilities;
report 73209575 ContractMasterData
{
    ApplicationArea = All;
    Caption = 'ContractMasterData';
    UsageCategory = ReportsAndAnalysis;
    ExcelLayout = 'Contract MasterData.xlsx';
    DefaultLayout = Excel;
    dataset
    {
        dataitem(TenancyContract; "BLRTenancyContract")
        {
            column(Report_Period; CustomDateRangeText)
            {
            }
            column(Contract_ID; "BLRContract ID")
            {
            }
            column(Owner_s_Name; "BLROwner's Name")
            {
            }
            column(Customer_Name; "BLRCustomer Name")
            {
            }
            column(Contract_Start_Date; ContractStartDateText)
            {
            }
            column(Contract_End_Date; ContractEndDateText)
            {
            }
            column(Contract_Type; ContractTypeFormatted)
            {
            }
            column(Proposal_ID; ProposalInfoText)
            {
            }
            column(Contract_Tenor; "BLRContract Tenor")
            {
            }
            column(Tenant_Contract_Status; TenantStatusFormatted)
            {
            }
            column(Contract_Amount; "BLRAnnual Rent Amount")
            {
            }
            column(Annual_Rent_Amount; "BLRRent Amount")
            {
            }
            column(Security_Deposit_Amount; "BLRSecurity Deposit Amount")
            {
            }
            column(Property_Name; "BLRProperty Name")
            {
            }
            column(Unit_Name; "BLRUnit Name")
            {
            }
            column(UnitID; UnitIDFormatted)
            {
            }
            column(Unit_Number; "BLRUnit Number")
            {
            }
            column(UnitArea_Sq_Feet; "BLRUnit Sq. Feet")
            {
            }
            column(Unit_Usage_Type; "BLRUsage Type")
            {
            }
            column(Suspension_Date; SuspensionDateText)
            {
            }
            column(Suspended_Reason_list; SuspensionReasonText)
            {
            }
            column(Termination_Date; TerminationDateText)
            {
            }
            column(Grace_Start_Date; GraceStartDateText)
            {
            }
            column(Grace_End_Date; GraceEndDateText)
            {
            }
            column(Grace_Period; "BLRGrace Period")
            {
            }
            dataitem("Final Calculation"; "BLRFinalCalculation")
            {
                DataItemLink = "BLRContract ID" = field("BLRContract ID");
                trigger OnAfterGetRecord()
                begin
                    if "BLRTermination Date" = 0D then
                        TerminationDateText := '-'
                    else
                        TerminationDateText := Format("BLRTermination Date", 0, '<Day,2>/<Month,2>/<Year4>');
                end;

                trigger OnPreDataItem()
                begin
                    if IsEmpty then
                        TerminationDateText := '-';
                end;
            }
            trigger OnAfterGetRecord()
            var
                SuspensionReasonRec: Record "BLRSuspendReasonTable";
                FinalCalc: Record "BLRFinalCalculation";
                StartDateIsInRange: Boolean;
                EndDateIsInRange: Boolean;
            begin
                TerminationDateText := '-';
                CustomDateRangeText :=
                    Format(CustomStartDatevar, 0, '<Day,2>/<Month,2>/<Year4>') + ' - ' +
                    Format(CustomEndDatevar, 0, '<Day,2>/<Month,2>/<Year4>');
                StartDateIsInRange := ("BLRContract Start Date" >= CustomStartDatevar) and ("BLRContract Start Date" <= CustomEndDatevar);
                EndDateIsInRange := ("BLRContract End Date" >= CustomStartDatevar) and ("BLRContract End Date" <= CustomEndDatevar);
                if not (StartDateIsInRange or EndDateIsInRange) then
                    CurrReport.SKIP();
                FinalCalc.Reset();
                FinalCalc.SetRange("BLRContract ID", "BLRContract ID");
                if FinalCalc.FindFirst() then
                    if FinalCalc."BLRTermination Date" = 0D then
                        TerminationDateText := '-'
                    else
                        TerminationDateText := Format(FinalCalc."BLRTermination Date", 0, '<Day,2>/<Month,2>/<Year4>');
                SuspensionStartDate := 0D;
                SuspensionReasonText := '';
                SuspensionReasonRec.Reset();
                SuspensionReasonRec.SetRange("BLRContract ID", "BLRContract ID");
                if SuspensionReasonRec.FindFirst() then begin
                    SuspensionStartDate := SuspensionReasonRec."BLRDateEffective";
                    SuspensionReasonText := Format(SuspensionReasonRec."BLRReason");
                end;
                case "BLRContract Type" of
                    "BLRContract Type"::"New Contract":
                        ProposalInfoText := '"BLRProposal ID": ' + Format("BLRProposal ID");
                    "BLRContract Type"::"Renewal Contract":
                        ProposalInfoText := 'ContractRenewal ID: ' + Format("BLRRenewal Proposal ID");
                    else
                        ProposalInfoText := '-';
                end;
                if Format("BLRContract ID") = '' then
                    "BLRContract ID" := '-';
                if Format("BLROwner's Name") = '' then
                    "BLROwner's Name" := '-';
                if Format("BLRCustomer Name") = '' then
                    "BLRCustomer Name" := '-';
                if "BLRContract Start Date" = 0D then
                    ContractStartDateText := '-'
                else
                    ContractStartDateText := Format("BLRContract Start Date", 0, '<Day,2>/<Month,2>/<Year4>');
                if "BLRContract End Date" = 0D then
                    ContractEndDateText := '-'
                else
                    ContractEndDateText := Format("BLRContract End Date", 0, '<Day,2>/<Month,2>/<Year4>');
                if "BLRContract Type" = "BLRContract Type"::" " then
                    ContractTypeFormatted := '-'
                else
                    ContractTypeFormatted := Format("BLRContract Type");
                if Format("BLRContract Tenor") = '' then
                    "BLRContract Tenor" := '-';
                if "BLRTenant Contract Status" = "BLRTenant Contract Status"::" " then
                    TenantStatusFormatted := '-'
                else
                    TenantStatusFormatted := Format("BLRTenant Contract Status");
                if "BLRAnnual Rent Amount" = 0 then
                    "BLRAnnual Rent Amount" := 0;
                if "BLRRent Amount" = 0 then
                    "BLRRent Amount" := 0;
                if "BLRSecurity Deposit Amount" = 0 then
                    "BLRSecurity Deposit Amount" := 0;
                if Format("BLRProperty Name") = '' then
                    "BLRProperty Name" := '-';
                if Format("BLRUnit Name") = '' then
                    "BLRUnit Name" := '-';
                if "BLRUnit ID" = '' then
                    UnitIDFormatted := '-'
                else
                    UnitIDFormatted := "BLRUnit ID";
                if Format("BLRUnit Number") = '' then
                    "BLRUnit Number" := '-';
                if Format("BLRUnit Sq. Feet") = '' then
                    "BLRUnit Sq. Feet" := '-';
                if Format("BLRUsage Type") = '' then
                    "BLRUsage Type" := '-';
                if SuspensionStartDate = 0D then
                    SuspensionDateText := '-'
                else
                    SuspensionDateText := Format(SuspensionStartDate, 0, '<Day,2>/<Month,2>/<Year4>');
                if SuspensionReasonText = '' then
                    SuspensionReasonText := '-';
                if "BLRGrace Start Date" = 0D then
                    GraceStartDateText := '-'
                else
                    GraceStartDateText := Format("BLRGrace Start Date", 0, '<Day,2>/<Month,2>/<Year4>');
                if "BLRGrace End Date" = 0D then
                    GraceEndDateText := '-'
                else
                    GraceEndDateText := Format("BLRGrace End Date", 0, '<Day,2>/<Month,2>/<Year4>');
                if "BLRGrace Period" = 0 then
                    "BLRGrace Period" := 0;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(DateFilter)
                {
                    field(CustomStartDate; CustomStartDatevar)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ToolTip = 'Start Date';
                    }
                    field(CustomEndDate; CustomEndDatevar)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ToolTip = 'End Date';
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        CustomStartDatevar: Date;
        CustomEndDatevar: Date;
        CustomDateRangeText: Text;
        ProposalInfoText: Text;
        SuspensionStartDate: Date;
        ContractTypeFormatted: Text;
        TenantStatusFormatted: Text;
        UnitIDFormatted: Text;
        ContractStartDateText: Text;
        ContractEndDateText: Text;
        GraceStartDateText: Text;
        GraceEndDateText: Text;
        SuspensionDateText: Text;
        SuspensionReasonText: Text;
        TerminationDateText: Text;
}
