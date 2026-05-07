table 73209631 "Management Fee Grid"
{

    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209576; "Management Fee Number"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209577; "Vendor ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209578; "Company/Owner Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Owner Profile"."Full Name" where("Owner ID" = field("Owner ID")));

        }

        field(73209579; "Property Name"; Text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "Property Registration"."Property Name" where("Owner ID" = field("Owner ID"));
            ValidateTableRelation = false;


            trigger OnValidate()
            var
                PropertyRec: Record "Property Registration";
            begin
                PropertyRec.SetRange("Property Name", Rec."Property Name");
                if PropertyRec.FindFirst() then
                    Rec."Property Type" := PropertyRec."Property Classification";
            end;
        }

        field(73209580; "Property Type"; Text[100])
        {
            DataClassification = CustomerContent;
        }

        // 4. Calculation Method
        field(73209581; "Calculation Method"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers =
                " ","Percentage of Monthly Revenue","Percentage of Annual Rent","Percentage of Collections","Per Unit Fee",Hybrid;
            trigger OnValidate()
            begin
                if Rec."Calculation Method" = Rec."Calculation Method"::"Per Unit Fee" then
                    Rec."Base Amount Source" := Rec."Base Amount Source"::"Number of Units";
            end;
        }

        // 5. Calculation Sub-Type
        field(73209582; "Calculation Sub-Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Percentage Based","Fixed Amount";
        }

        // 6. Percentage Type
        field(73209583; "Percentage Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "",Fixed,Variable;
        }

        // 7. Percentage / Amount
        field(73209584; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        // 8. Base Amount Source
        field(73209585; "Base Amount Source"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Revenue,Collections,"Annual Rent","Number of Units";

            trigger OnValidate()
            begin
                if Rec."Base Amount Source" = Rec."Base Amount Source"::"Number of Units" then
                    if Rec."Calculation Method" <> Rec."Calculation Method"::"Per Unit Fee" then begin
                        Message('Base Amount Source should be "Number of Units" only when Calculation Method is "Per Unit Fee".');
                        Rec."Base Amount Source" := Rec."Base Amount Source"::Revenue;
                    end;
            end;
        }

        // 9. Payment Frequency
        field(73209586; "Payment Frequency"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Monthly,Quarterly,"Half-Yearly",Yearly;
        }

        // 10. Validity Period
        field(73209587; "Valid From"; Date)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if (Rec."Valid From" <= Today()) and (Rec."Valid To" >= Today()) then
                    if Rec."Contract Status" <> Rec."Contract Status"::Active then
                        Rec."Contract Status" := Rec."Contract Status"::Active;
            end;
        }

        field(73209588; "Valid To"; Date)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if (Rec."Valid From" <= Today()) and (Rec."Valid To" >= Today()) then
                    if Rec."Contract Status" <> Rec."Contract Status"::Active then
                        Rec."Contract Status" := Rec."Contract Status"::Active;
            end;
        }

        field(73209589; "Contract Status"; Option)
        {
            OptionMembers = Active,Expired;
            DataClassification = CustomerContent;

        }

        // Document
        field(73209590; "Contract Document"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(73209591; "View Document"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(73209592; "URL Document"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(73209593; Percentage; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209594; "Owner ID"; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = "Owner Profile"."Owner ID";

            trigger OnValidate()
            begin
                CalcFields("Company/Owner Name");
            end;
        }
        field(73209595; "Validity Period"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(73209596; "Property Management Company"; Text[100])
        {
            DataClassification = OrganizationIdentifiableInformation;
        }
    }
    keys
    {
        key(PK; "Entry No.", "Management Fee Number")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    var
        ManagementFeeMaster: Record "Management Fee MasterData";
    begin
        ManagementFeeMaster.SetRange("Management Fee Number", Rec."Management Fee Number");
        if ManagementFeeMaster.FindFirst() then
            Rec."Vendor ID" := ManagementFeeMaster."Vendor ID";
    end;
}
