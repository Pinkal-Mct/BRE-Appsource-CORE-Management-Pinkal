page 73209603 "BLRPayment Series Data"
{
    PageType = API;
    APIGroup = 'finance';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'Payment Series API';
    DelayedInsert = true;
    EntityName = 'paymentSeriesdata';
    EntitySetName = 'paymentSeriesdatas';
    ODataKeyFields = SystemId; // Ensure the SystemId is exposed in the API
    SourceTable = "BLRPaymentSeriesDetails";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("paymentSeries"; Rec."BLRpayment Series") { }
                field(systemId; Rec.SystemId) { }
                field(amount; Rec."BLRAmount") { }
                field("dueDate"; Rec."BLRDue Date") { }
                field("paymentMode"; Rec."BLRPayment Mode") { }
                field("chequeNumber"; Rec."BLRCheque Number") { }
                field("depositeBank"; Rec."BLRDeposite Bank") { }
                field("depositeStatus"; Rec."BLRDeposite Status") { }
                field("paymentStatus"; Rec."BLRPayment Status") { }
                field("chequeStatus"; Rec."BLRCheque Status") { }
                field("oldCheque"; Rec."BLROld Cheque") { }
                field(view; Rec."BLRView") { }
                field("viewDocumentURL"; Rec."BLRView Document URL") { }
                field("approvalStatus"; Rec."BLRApproval Status") { }
                field("paymentTransactionId"; Rec."BLRPayment Transaction Id") { }
                field("contractId"; Rec."BLRContract Id") { }
                field("tenantId"; Rec."BLRTenant Id") { }


            }
        }
    }

}