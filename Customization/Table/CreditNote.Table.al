table 73209603 "BLRCreditNote"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLRID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            Editable = false;
            AutoIncrement = true;
        }
        field(73209576; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209577; "BLRTenant ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
        }
        field(73209578; "BLRContract Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start Date';
        }
        field(73209579; "BLRContract End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract End Date';
        }
        field(73209580; "BLRUnit Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Type';
        }
        field(73209581; "BLRContract Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Amount';
        }
        field(73209582; "BLRTenant Email"; Text[250])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Email';
        }
        field(73209583; "BLRTenant Name"; Text[250])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Name';
        }
        field(73209584; "BLRCredit Note Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note Type';
            OptionMembers = "Termination Credit Note";
        }
        field(73209585; "BLRStatus"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionMembers = "Pending","Approved","Reject";
        }
        field(73209586; "BLRFC ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'FC ID';
        }
        field(73209587; "BLRReason for Rejection"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Reason for Rejection';
        }
        field(73209588; "BLRCredit Note No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note No.';
            Editable = false;
        }
        field(73209589; "BLRCredit Note Document"; Text[1000])
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note Document';
            InitValue = 'Credit Note Document';
        }
        field(73209590; "BLRCredit Note URL"; Text[1000])
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note View';
            InitValue = 'Credit Note View';
        }
    }

    keys
    {
        key(PK;"BLRID")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        creditNote: Record "BLRCreditNote";
        NextID: Integer;
    begin
        if "BLRID" = 0 then begin
            if creditNote.FindLast() then
                NextID := creditNote."BLRID" + 1
            else
                NextID := 1;

            "BLRCredit Note No." := 'CN_' + CopyStr('00000' + Format(NextID), StrLen('00000' + Format(NextID)) - 4, 5);
        end;
    end;
}
