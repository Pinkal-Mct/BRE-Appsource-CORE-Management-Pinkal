table 73209603 "Credit Note"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            Editable = false;
            AutoIncrement = true;
        }
        field(73209576; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209577; "Tenant ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
        }
        field(73209578; "Contract Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start Date';
        }
        field(73209579; "Contract End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract End Date';
        }
        field(73209580; "Unit Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Type';
        }
        field(73209581; "Contract Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Amount';
        }
        field(73209582; "Tenant Email"; Text[250])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Email';
        }
        field(73209583; "Tenant Name"; Text[250])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Name';
        }
        field(73209584; "Credit Note Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note Type';
            OptionMembers = "Termination Credit Note";
        }
        field(73209585; "Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionMembers = "Pending","Approved","Reject";
        }
        field(73209586; "FC ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'FC ID';
        }
        field(73209587; "Reason for Rejection"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Reason for Rejection';
        }
        field(73209588; "Credit Note No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note No.';
            Editable = false;
        }
        field(73209589; "Credit Note Document"; Text[1000])
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note Document';
            InitValue = 'Credit Note Document';
        }
        field(73209590; "Credit Note URL"; Text[1000])
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note View';
            InitValue = 'Credit Note View';
        }
    }

    keys
    {
        key(PK; "ID")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        creditNote: Record "Credit Note";
        NextID: Integer;
    begin
        if ID = 0 then begin
            if creditNote.FindLast() then
                NextID := creditNote.ID + 1
            else
                NextID := 1;

            "Credit Note No." := 'CN_' + CopyStr('00000' + Format(NextID), StrLen('00000' + Format(NextID)) - 4, 5);
        end;
    end;
}
