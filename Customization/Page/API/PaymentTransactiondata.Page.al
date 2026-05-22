page 73209604 "Payment Transaction Data"
{
    PageType = API;
    APIGroup = 'finance';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'Payment Transaction API';
    DelayedInsert = true;
    EntityName = 'paymentTransaction';
    EntitySetName = 'paymentTransactions';
    ODataKeyFields = SystemId; // Ensure the SystemId is exposed in the API
    SourceTable = "BLRPaymentTransaction";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("ptId"; Rec."BLRPT Id") { }
                field(systemId; Rec.SystemId) { }
                field("tenantId"; Rec."BLRTenant Id") { }
                field("contractId"; Rec."BLRContract Id") { }
                field("approvalStatus"; Rec."BLRApproval Status") { }
            }
        }
    }


}