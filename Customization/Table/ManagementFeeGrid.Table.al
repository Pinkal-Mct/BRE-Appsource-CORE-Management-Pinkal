table 73209631 "BLRManagementFeeGrid"
{

    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209576; "BLRManagement Fee Number"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209577; "BLRVendor ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209578; "BLRCompany/Owner Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("BLROwnerProfile"."BLRFull Name" where("BLROwner ID" = field("BLROwner ID")));

        }

        field(73209579; "BLRProperty Name"; Text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "BLRPropertyRegistration"."BLRProperty Name" where("BLROwner ID" = field("BLROwner ID"));
            ValidateTableRelation = false;


            trigger OnValidate()
            var
                PropertyRec: Record "BLRPropertyRegistration";
            begin
                PropertyRec.SetRange("BLRProperty Name", Rec."BLRProperty Name");
                if PropertyRec.FindFirst() then
                    Rec."BLRProperty Type" := PropertyRec."BLRProperty Classification";
            end;
        }

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
            trigger OnValidate()
            begin
                if Rec."BLRCalculation Method" = Rec."BLRCalculation Method"::"Per Unit Fee" then
                    Rec."BLRBase Amount Source" := Rec."BLRBase Amount Source"::"Number of Units";
            end;
        }

        // 5. "BLRCalculation Sub-Type"
        field(73209582; "BLRCalculation Sub-Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Percentage Based","Fixed Amount";
        }

        // 6. "BLRPercentage Type"
        field(73209583; "BLRPercentage Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "",Fixed,Variable;
        }

        // 7. Percentage / Amount
        field(73209584; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        // 8. "BLRBase Amount Source"
        field(73209585; "BLRBase Amount Source"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Revenue,Collections,"Annual Rent","Number of Units";

            trigger OnValidate()
            begin
                if Rec."BLRBase Amount Source" = Rec."BLRBase Amount Source"::"Number of Units" then
                    if Rec."BLRCalculation Method" <> Rec."BLRCalculation Method"::"Per Unit Fee" then begin
                        Message('Base Amount Source should be "Number of Units" only when "BLRCalculation Method" is "Per Unit Fee".');
                        Rec."BLRBase Amount Source" := Rec."BLRBase Amount Source"::Revenue;
                    end;
            end;
        }

        // 9. "BLRPayment Frequency"
        field(73209586; "BLRPayment Frequency"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Monthly,Quarterly,"Half-Yearly",Yearly;
        }

        // 10. "BLRValidity Period"
        field(73209587; "BLRValid From"; Date)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if (Rec."BLRValid From" <= Today()) and (Rec."BLRValid To" >= Today()) then
                    if Rec."BLRContract Status" <> Rec."BLRContract Status"::Active then
                        Rec."BLRContract Status" := Rec."BLRContract Status"::Active;
            end;
        }

        field(73209588; "BLRValid To"; Date)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if (Rec."BLRValid From" <= Today()) and (Rec."BLRValid To" >= Today()) then
                    if Rec."BLRContract Status" <> Rec."BLRContract Status"::Active then
                        Rec."BLRContract Status" := Rec."BLRContract Status"::Active;
            end;
        }

        field(73209589; "BLRContract Status"; Option)
        {
            OptionMembers = Active,Expired;
            DataClassification = CustomerContent;

        }

        // Document
        field(73209590; "BLRContract Document"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(73209591; "BLRView Document"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(73209592; "BLRURL Document"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(73209593; "BLRPercentage"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209594; "BLROwner ID"; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = "BLROwnerProfile"."BLROwner ID";

            trigger OnValidate()
            begin
                CalcFields("BLRCompany/Owner Name");
            end;
        }
        field(73209595; "BLRValidity Period"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(73209596; "BLRProperty Management Company"; Text[100])
        {
            DataClassification = OrganizationIdentifiableInformation;
        }
    }
    keys
    {
        key(PK;"BLREntry No.", "BLRManagement Fee Number")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    var
        ManagementFeeMaster: Record "BLRManagementFeeMasterData";
    begin
        ManagementFeeMaster.SetRange("BLRManagement Fee Number", Rec."BLRManagement Fee Number");
        if ManagementFeeMaster.FindFirst() then
            Rec."BLRVendor ID" := ManagementFeeMaster."BLRVendor ID";
    end;
}
