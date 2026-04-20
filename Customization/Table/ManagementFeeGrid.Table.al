table 53764 "Management Fee Grid"
{

    DataClassification = ToBeClassified;
    fields
    {
        field(53700; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(53701; "Management Fee Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53702; "Vendor ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53703; "Company/Owner Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Owner Profile"."Full Name" where("Owner ID" = field("Owner ID")));

        }

        field(53704; "Property Name"; Text[100])
        {
            DataClassification = ToBeClassified;
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

        field(53705; "Property Type"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        // 4. Calculation Method
        field(53706; "Calculation Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers =
                " ","Percentage of Monthly Revenue","Percentage of Annual Rent","Percentage of Collections","Per Unit Fee",Hybrid;
            trigger OnValidate()
            begin
                if Rec."Calculation Method" = Rec."Calculation Method"::"Per Unit Fee" then
                    Rec."Base Amount Source" := Rec."Base Amount Source"::"Number of Units";
            end;
        }

        // 5. Calculation Sub-Type
        field(53707; "Calculation Sub-Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Percentage Based","Fixed Amount";
        }

        // 6. Percentage Type
        field(53708; "Percentage Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "",Fixed,Variable;
        }

        // 7. Percentage / Amount
        field(53709; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        // 8. Base Amount Source
        field(53710; "Base Amount Source"; Option)
        {
            DataClassification = ToBeClassified;
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
        field(53711; "Payment Frequency"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Monthly,Quarterly,"Half-Yearly",Yearly;
        }

        // 10. Validity Period
        field(53712; "Valid From"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if (Rec."Valid From" <= Today()) and (Rec."Valid To" >= Today()) then
                    if Rec."Contract Status" <> Rec."Contract Status"::Active then
                        Rec."Contract Status" := Rec."Contract Status"::Active;
            end;
        }

        field(53713; "Valid To"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if (Rec."Valid From" <= Today()) and (Rec."Valid To" >= Today()) then
                    if Rec."Contract Status" <> Rec."Contract Status"::Active then
                        Rec."Contract Status" := Rec."Contract Status"::Active;
            end;
        }

        field(53714; "Contract Status"; Option)
        {
            OptionMembers = Active,Expired;
            DataClassification = ToBeClassified;

        }

        // Document
        field(53715; "Contract Document"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(53716; "View Document"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(53717; "URL Document"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(53718; Percentage; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53719; "Owner ID"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Owner Profile"."Owner ID";

            trigger OnValidate()
            begin
                CalcFields("Company/Owner Name");
            end;
        }
        field(53720; "Validity Period"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(53721; "Property Management Company"; Text[100])
        {
            DataClassification = ToBeClassified;
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