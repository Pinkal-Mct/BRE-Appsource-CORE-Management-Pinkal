namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 73209590 finalcalculationrefundapproval
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'finalcalculationRefundapprova';
    DelayedInsert = true;
    EntityName = 'fcRefundApproval';
    EntitySetName = 'fcRefundApprovals';
    PageType = API;
    SourceTable = "BLRFinalCalcRefundApproval";
    ODataKeyFields = SystemId;
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(accountHolderName; Rec."BLRAccount Holder Name")
                {
                    Caption = 'Account Holder Name';
                }
                field(accountNumber; Rec."BLRAccount Number")
                {
                    Caption = 'Account Number';
                }
                field(bankName; Rec."BLRBank Name")
                {
                    Caption = 'Bank Name';
                }
                field(branchAddress; Rec."BLRBranch Address")
                {
                    Caption = 'Branch Name';
                }
                field(contractID; Rec."BLRContract ID")
                {
                    Caption = 'Contract ID';
                }
                field(description; Rec."BLRDescription")
                {
                    Caption = 'Description';
                }
                field(dueDate; Rec."BLRDue Date")
                {
                    Caption = 'Due Date';
                }
                field(ibanNumber; Rec."BLRIBAN number")
                {
                    Caption = 'IBAN number';
                }
                field(id; Rec."BLRID")
                {
                    Caption = 'ID';
                }
                field(status; Rec."BLRStatus")
                {
                    Caption = 'Status';
                }
                field(swiftCode; Rec."BLRSwift Code")
                {
                    Caption = 'Swift Code';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
                field(tenantID; Rec."BLRTenant ID")
                {
                    Caption = 'Tenant ID';
                }
                field(tenantName; Rec."BLRTenant Name")
                {
                    Caption = 'Tenant Name';
                }
                field(totalAmount; Rec."BLRTotal Amount")
                {
                    Caption = 'Total Amount';
                }
                field("requestDate"; Rec."BLRRequest Date")
                {
                    Caption = 'Request Date';
                }
                field(fcID; Rec."BLRfcID")
                {
                    Caption = 'fcID';
                }
            }
        }
    }
}
