table 73209630 "BLRManagementFeeCalcLine"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209576; "BLRHeader No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Header No.';
        }
        field(73209577; "BLRVendor ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209578; "BLRCompany/Owner Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
        }

        field(73209579; "BLRProperty Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }

        // 3. "BLRProperty Type"
        field(73209580; "BLRProperty Type"; Text[100])
        {
            DataClassification = CustomerContent;
        }

        // 4. "BLRCalculation Method"
        field(73209581; "BLRCalculation Method"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers =
                " ","Percentage of Monthly Revenue","Percentage of Annual Rent","Percentage of Collections","Per Unit Fee",Hybrid;
        }

        // 5. "BLRCalculation Sub-Type"
        field(73209582; "BLRCalculation Sub-Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Percentage Based","Fixed Amount";
        }

        field(73209583; "BLRPercentage Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "",Fixed,Variable;
        }

        field(73209584; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(73209585; "BLRBase Amount Source"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Revenue,Collections,"Annual Rent","Number of Units";
        }
        field(73209586; "BLRBase Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(73209587; "BLRValid From"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(73209588; "BLRValid To"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(73209589; "BLRContract Status"; Option)
        {
            OptionMembers = Active,Expired;
            DataClassification = CustomerContent;

        }

        field(73209590; "BLRManagement Fee"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209591; "BLRValidity Period"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(73209592; "BLRProperty Management Company"; Text[100])
        {
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(73209593; "BLRPercentage"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209594; "BLROwner ID"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209595; "BLRTotal Mgt. Fee"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("BLRManagementFeeCalcLine"."BLRManagement Fee" where("BLRHeader No." = field("BLRHeader No.")));
        }
        field(73209596; "BLRBase Amount Details"; Text[12])
        {
            DataClassification = CustomerContent;
            InitValue = 'View Details';
        }
    }

    keys
    {
        key(Key1;"BLREntry No.", "BLRHeader No.")
        {
            Clustered = true;
        }
    }
    trigger OnDelete()
    var
        baseAmountHeader: Record "BLRBaseAmountDataHeader";
    begin
        baseAmountHeader.SetRange("BLRHeader No.", Rec."BLRHeader No.");
        baseAmountHeader.SetRange("BLRLine No.", Rec."BLREntry No.");
        if baseAmountHeader.FindSet() then
            baseAmountHeader.DeleteAll(true);
    end;

}
