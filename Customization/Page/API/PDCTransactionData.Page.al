page 73209606 "PDC Transaction Data"
{
    PageType = API;
    APIGroup = 'finance';
    APIPublisher = 'realeststeDev';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'PDC Transaction API';
    DelayedInsert = true;
    EntityName = 'pdcTransaction';
    EntitySetName = 'pdcTransactions';
    ODataKeyFields = SystemId;
    SourceTable = "BLRPDCTransaction";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("pdcID"; Rec."BLRPDC ID") { }
                field(systemId; Rec.SystemId) { }
                field("tenantId"; Rec."BLRTenant Id") { }
                field("contractID"; Rec."BLRContract ID") { }
                field("bankName"; Rec."BLRBank Name") { }
                field("chequeNumber"; Rec."BLRCheque Number") { }
                field("chequeDate"; Rec."BLRCheque Date") { }
                field(amount; Rec."BLRAmount") { }
                field("chequeStatus"; Rec."BLRCheque Status") { }
                field("approvalStatus"; Rec."BLRApproval Status") { }
                field(view; Rec."BLRView") { }

            }
        }
    }

}