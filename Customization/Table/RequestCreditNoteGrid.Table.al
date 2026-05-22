table 73209669 "BLRRequestCreditNoteGrid"
{
    DataClassification = CustomerContent;
    Caption = 'Request Credit Note Grid';
    fields
    {
        field(73209575; "BLRRequest No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Request No.';
        }
        field(73209576; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209577; "BLRProperty Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Name';
        }
        field(73209578; "BLRTenant No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant No.';
        }
        field(73209579; "BLRCustomer Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Customer Name';
        }
        field(73209580; "BLRPayment Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Series';
        }
        field(73209581; "BLRCurrent Charges Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Current Rent Amount';
        }
        field(73209582; "BLRTotal Reduction"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Reduction';
        }
        field(73209583; "BLRLine No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
            AutoIncrement = true;
        }
        field(73209584; "BLRCredit Note No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note No.';
        }
        field(73209585; "BLRTotal Pay Rent Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Pay Rent Amount';
        }
        field(73209586; "BLRProperty Classification"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Classification';
        }
        field(73209587; "BLRCredit Memo Generated"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Memo Generated';
            trigger OnValidate()
            var
                requestCreditNote: Record "BLRRequestCreditNote";
                requestCreditNoteGrid: Record "BLRRequestCreditNoteGrid";
            begin
                if Rec."BLRCredit Memo Generated" then begin
                    requestCreditNoteGrid.SetRange("BLRRequest No.", Rec."BLRRequest No.");
                    requestCreditNoteGrid.SetRange("BLRCredit Memo Generated", false);
                    requestCreditNoteGrid.SetFilter("BLRLine No.", '<>%1', Rec."BLRLine No.");
                    if requestCreditNoteGrid.IsEmpty() then
                        if requestCreditNote.Get(Rec."BLRRequest No.") then begin
                            requestCreditNote."BLRAdjust with Invoice" := requestCreditNote."BLRAdjust with Invoice"::Adjusted;
                            requestCreditNote.Modify();
                        end;
                end;
            end;
        }
        field(73209588; "BLRSecondary Item Type"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Secondary Item Type';
        }
        field(73209589; "BLRCharges"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Charges';
        }
        field(73209590; "BLRInvoiced"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(73209591; "BLRInvoice ID"; Code[50])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1;"BLRLine No.", "BLRRequest No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        requestcreditnote: Record "BLRRequestCreditNote";
    begin
        requestcreditnote.SetRange("BLRContract ID", Rec."BLRContract ID");
        if requestcreditnote.FindFirst() then begin
            Rec."BLRCustomer Name" := requestcreditnote."BLRCustomer Name";
            Rec."BLRTenant No." := requestcreditnote."BLRTenant No.";
            Rec."BLRProperty Classification" := requestcreditnote."BLRProperty Classification";
        end else
            Error('No Request Credit Note found for the specified Request No.');
    end;
}
