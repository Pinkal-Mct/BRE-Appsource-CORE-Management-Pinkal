table 50303 "Property Registration"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "Property ID";
    fields
    {
        field(50100; "Property ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property ID';
        }
        field(50127; "Company ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Company ID';
            TableRelation = "Company Data"."Company ID";
        }
        field(50101; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(50102; "Property Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Name';
        }
        field(50103; "Blocked"; Enum "Vendor Blocked")
        {
            DataClassification = ToBeClassified;
            Caption = 'Blocked';
        }
        field(50104; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Type';
            OptionMembers = Inventory,"Non Inventory";
        }
        field(50105; "Base Unit of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Base Unit of Measure';
            TableRelation = "Unit of Measure"."Code";
        }
        field(50106; "Market Rate per Sq. Ft."; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Market Rate per Sq.(Dirham)';
        }
        field(50107; "Emirate Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Emirate';
            TableRelation = Emirate.ID where("Country Code" = field(Country));
            trigger OnValidate()
            var
                emirate: Record "Emirate";
                emirateID: Integer;
            begin
                Evaluate(emirateID, "Emirate Name");
                emirate.SetRange(ID, emirateID);
                if emirate.FindFirst() then begin
                    "Emirate Name" := Format(emirate."Emirate Name");
                    Community := '';
                end else
                    Error('Invalid Emirate Name: %1', "Emirate Name");
            end;
        }
        field(50108; "Community"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Community';
            TableRelation = Community where("Emirate Name" = field("Emirate Name"));

            trigger OnValidate()
            var
                communityRec: Record Community;
            begin
                if communityRec.Get(Community) then
                    Community := communityRec."Community Name";
            end;
        }
        field(50109; "Number of Units"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Number Of Units';
        }
        field(50110; "Property Classification"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Classification';
            TableRelation = "Primary Classification"."Classification Name";
            trigger OnValidate()
            begin
                "Property Type" := '';
            end;
        }
        field(50111; "Property Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Type';
            TableRelation = "Property Type"."Property Type" where("Classification Name" = field("Property Classification"));
        }
        field(50112; "Registration Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Registration Date';
        }
        field(50113; "GTIN"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'GTIN';
        }
        field(50114; "Owner ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Owner ID';
            TableRelation = "Owner Profile"."Owner ID";
        }
        field(50115; "Ownership Documents"; Text[250])
        {
            Caption = 'Ownership Documents';
            DataClassification = ToBeClassified;
        }
        field(50116; "Compliance Certificates"; Text[250])
        {
            Caption = 'Compliance Certificates';
            DataClassification = ToBeClassified;
        }
        field(50117; "Legal Documents"; Text[250])
        {
            Caption = 'Legal Documents';
            DataClassification = ToBeClassified;
        }
        field(50118; "Property Size"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Size';
        }
        field(50119; "Address"; Text[250])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
        }
        field(50120; "Built-up Area"; Decimal)
        {
            Caption = 'Built-up Area (sq. ft)';
            DataClassification = ToBeClassified;
        }
        field(50121; "Makani Number"; Text[50])
        {
            Caption = 'Makani Number';
            DataClassification = ToBeClassified;
        }
        field(50122; "Municipality Number"; Text[50])
        {
            Caption = 'Municipality Number';
            DataClassification = ToBeClassified;
        }
        field(50123; "DEWA Number"; Text[50])
        {
            Caption = 'DEWA Number';
            DataClassification = ToBeClassified;
        }
        field(50124; "Number of Floors"; Integer)
        {
            Caption = 'Number of Floors';
            DataClassification = ToBeClassified;
        }
        field(50125; "Number of Lifts"; Integer)
        {
            Caption = 'Number of Lifts';
            DataClassification = ToBeClassified;
        }
        field(50126; "Business Unit Code"; Code[20])
        {
            Caption = 'Business Unit Code';
            TableRelation = "Business Unit".Code;
        }
        field(50158; "Country"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Country';
            TableRelation = Country;
            trigger OnValidate()
            var
                country: Record Country;
            begin
                if country.Get(Rec.Country) then
                    Rec.Country := country."Country Code";
            end;
        }
    }
    keys
    {
        key(PK; "Property ID", "Property Classification", "Property Type", "Property Size", "Property Name")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Property ID", "Property Name", "Property Classification", "Property Type")
        {
        }
    }
    trigger OnInsert()
    var
        CompanyRec: Record "Company Data";
        NoSeriesMgt: Codeunit "No. Series";
    begin
        if "Property ID" = '' then
            "Property ID" := NoSeriesMgt.GetNextNo('PROPERTYID', Today(), true);
        if CompanyRec.FindFirst() then
            "Company ID" := CompanyRec."Company ID";
    end;

    trigger OnDelete()
    var
    begin
        deleteWorkflowFrequencyPR();
    end;

    procedure deleteWorkflowFrequencyPR()
    var
        WorkflowFrequencyPR: Record "Workflow Frequency PR";
    begin
        WorkflowFrequencyPR.SetRange("Company Id", Rec."Company ID");
        WorkflowFrequencyPR.SetRange("Property ID", Rec."Property ID");
        if WorkflowFrequencyPR.FindSet() then
            WorkflowFrequencyPR.DeleteAll();
    end;
}
