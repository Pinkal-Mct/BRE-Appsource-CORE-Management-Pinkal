table 73209669 "Request Credit Note Grid"
{
    DataClassification = CustomerContent;
    Caption = 'Request Credit Note Grid';
    fields
    {
        field(73209575; "Request No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Request No.';
        }
        field(73209576; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209577; "Property Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Name';
        }
        field(73209578; "Tenant No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant No.';
        }
        field(73209579; "Customer Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Customer Name';
        }
        field(73209580; "Payment Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Series';
        }
        field(73209581; "Current Charges Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Current Rent Amount';
        }
        field(73209582; "Total Reduction"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Reduction';
        }
        field(73209583; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
            AutoIncrement = true;
        }
        field(73209584; "Credit Note No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note No.';
        }
        field(73209585; "Total Pay Rent Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Pay Rent Amount';
        }
        field(73209586; "Property Classification"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Classification';
        }
        field(73209587; "Credit Memo Generated"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Memo Generated';
            trigger OnValidate()
            var
                requestCreditNote: Record "Request Credit Note";
                requestCreditNoteGrid: Record "Request Credit Note Grid";
            begin
                if Rec."Credit Memo Generated" then begin
                    requestCreditNoteGrid.SetRange("Request No.", Rec."Request No.");
                    requestCreditNoteGrid.SetRange("Credit Memo Generated", false);
                    requestCreditNoteGrid.SetFilter("Line No.", '<>%1', Rec."Line No.");
                    if requestCreditNoteGrid.IsEmpty() then
                        if requestCreditNote.Get(Rec."Request No.") then begin
                            requestCreditNote."Adjust with Invoice" := requestCreditNote."Adjust with Invoice"::Adjusted;
                            requestCreditNote.Modify();
                        end;
                end;
            end;
        }
        field(73209588; "Secondary Item Type"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Secondary Item Type';
        }
        field(73209589; Charges; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Charges';
        }
        field(73209590; Invoiced; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(73209591; "Invoice ID"; Code[50])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Line No.", "Request No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        requestcreditnote: Record "Request Credit Note";
    begin
        requestcreditnote.SetRange("Contract ID", Rec."Contract ID");
        if requestcreditnote.FindFirst() then begin
            Rec."Customer Name" := requestcreditnote."Customer Name";
            Rec."Tenant No." := requestcreditnote."Tenant No.";
            Rec."Property Classification" := requestcreditnote."Property Classification";
        end else
            Error('No Request Credit Note found for the specified Request No.');
    end;
}
