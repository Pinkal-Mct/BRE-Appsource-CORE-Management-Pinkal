table 73209661 "Property Registration"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "Property ID";
    fields
    {
        field(73209575; "Property ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Property ID';
        }
        field(73209576; "Company ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Company ID';
            TableRelation = "Company Data"."Company ID";
        }
        field(73209577; "Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(73209578; "Property Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Name';
        }
        field(73209579; "Blocked"; Enum "Vendor Blocked")
        {
            DataClassification = CustomerContent;
            Caption = 'Blocked';
        }
        field(73209580; "Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Type';
            OptionMembers = Inventory,"Non Inventory";
        }
        field(73209581; "Base Unit of Measure"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Base Unit of Measure';
            TableRelation = "Unit of Measure"."Code";
        }
        field(73209582; "Market Rate per Sq. Ft."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Market Rate per Sq. Ft.';
        }
        field(73209583; "Emirate Name"; Text[50])
        {
            DataClassification = CustomerContent;
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
        field(73209584; "Community"; Text[100])
        {
            DataClassification = CustomerContent;
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
        field(73209585; "Number of Units"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Number Of Units';
        }
        field(73209586; "Property Classification"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Classification';
            TableRelation = "Primary Classification"."Classification Name";
            trigger OnValidate()
            begin
                "Property Type" := '';
            end;
        }
        field(73209587; "Property Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Type';
            TableRelation = "Property Type"."Property Type" where("Classification Name" = field("Property Classification"));
        }
        field(73209588; "Registration Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Registration Date';
        }
        field(73209589; "GTIN"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'GTIN';
        }
        field(73209590; "Owner ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Owner ID';
            TableRelation = "Owner Profile"."Owner ID";
        }
        field(73209591; "Ownership Documents"; Text[250])
        {
            Caption = 'Ownership Documents';
            DataClassification = CustomerContent;
        }
        field(73209592; "Compliance Certificates"; Text[250])
        {
            Caption = 'Compliance Certificates';
            DataClassification = CustomerContent;
        }
        field(73209593; "Legal Documents"; Text[250])
        {
            Caption = 'Legal Documents';
            DataClassification = CustomerContent;
        }
        field(73209594; "Property Size"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Size';
        }
        field(73209595; "Address"; Text[250])
        {
            Caption = 'Address';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(73209596; "Built-up Area"; Decimal)
        {
            Caption = 'Built-up Area (sq. ft)';
            DataClassification = CustomerContent;
        }
        field(73209597; "Makani Number"; Text[50])
        {
            Caption = 'Makani Number';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(73209598; "Municipality Number"; Text[50])
        {
            Caption = 'Municipality Number';
            DataClassification = CustomerContent;
        }
        field(73209599; "DEWA Number"; Text[50])
        {
            Caption = 'DEWA Number';
            DataClassification = CustomerContent;
        }
        field(73209600; "Number of Floors"; Integer)
        {
            Caption = 'Number of Floors';
            DataClassification = CustomerContent;
        }
        field(73209601; "Number of Lifts"; Integer)
        {
            Caption = 'Number of Lifts';
            DataClassification = CustomerContent;
        }
        field(73209602; "Business Unit Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Business Unit Code';
            TableRelation = "Business Unit".Code;
        }
        field(73209603; "Country"; Text[100])
        {
            DataClassification = CustomerContent;
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
        key(PK; "Property ID", "Property Classification", "Property Type", "Property Size")
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
