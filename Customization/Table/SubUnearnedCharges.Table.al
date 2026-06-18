table 73209693 "BLRSubUnearnedCharges"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLRLine No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
            Editable = false;
        }
        field(73209576; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }

        field(73209577; "BLRCustomer Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Customer Name';
        }

        field(73209578; "BLRUnit Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Name';
        }

        field(73209579; "BLRProperty"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property';
        }

        field(73209580; "BLROwner Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Owner Name';
        }

        field(73209581; "BLRStart Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
        }

        field(73209582; "BLREnd Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
        }

        field(73209583; "BLRTermination Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Termination Date';
        }

        field(73209584; "BLRSuspension Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Suspension Date';
        }

        field(73209585; "BLROther Charges Value"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Other Charges Value';
        }

        field(73209586; "BLRContract Status"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Status';
        }

        field(73209587; "BLROpening Balance"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Opening Balance';
        }
        field(73209588; "BLRInvRaisedDurtheYear"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Raised During the Year';
        }
        field(73209589; "BLRRevAllocDurtheYear"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Revenue Allocated During the Year';
        }
        field(73209590; "BLRUnearned Revenue Balance"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unearned Revenue Balance';
        }
        field(73209591; "BLRG/L Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'G/L Balance';
        }
        field(73209592; "BLRShortfall/Excess"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Shortfall/Excess';
        }
        field(73209593; "BLRHeader No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Header No.';
            Editable = false;
        }
        field(73209594; "BLRReport Period"; Text[40])
        {
            DataClassification = CustomerContent;
            Caption = 'Report Period';
        }
    }
    keys
    {
        key(Key1; "BLRHeader No.", "BLRLine No.")
        {
            Clustered = true;
        }

    }
}
