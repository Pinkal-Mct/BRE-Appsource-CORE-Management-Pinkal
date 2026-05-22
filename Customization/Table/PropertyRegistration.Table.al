table 73209661 "BLRPropertyRegistration"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "BLRProperty ID";
    fields
    {
        field(73209575; "BLRProperty ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Property ID';
        }
        field(73209576; "BLRCompany ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Company ID';
            TableRelation = "BLRCompanyData"."BLRCompany ID";
        }
        field(73209577; "BLRDescription"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(73209578; "BLRProperty Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Name';
        }
        field(73209579; "BLRBlocked"; Enum "Vendor Blocked")
        {
            DataClassification = CustomerContent;
            Caption = 'Blocked';
        }
        field(73209580; "BLRType"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Type';
            OptionMembers = Inventory,"Non Inventory";
        }
        field(73209581; "BLRBase Unit of Measure"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Base Unit of Measure';
            TableRelation = "Unit of Measure"."Code";
        }
        field(73209582; "BLRMarket Rate per Sq. Ft."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Market Rate per Sq. Ft.';
        }
        field(73209583; "BLREmirate Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Emirate';
            TableRelation = "BLREmirate"."BLRID" where("BLRCountry Code" = field("BLRCountry"));
            trigger OnValidate()
            var
                emirate: Record "BLREmirate";
                emirateID: Integer;
            begin
                Evaluate(emirateID, "BLREmirate Name");
                emirate.SetRange("BLRID", emirateID);
                if emirate.FindFirst() then begin
                    "BLREmirate Name" := Format(emirate."BLREmirate Name");
                    "BLRCommunity" := '';
                end else
                    Error('Invalid "BLREmirate Name": %1', "BLREmirate Name");
            end;
        }
        field(73209584; "BLRCommunity"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Community';
            TableRelation = "BLRCommunity" where("BLREmirate Name" = field("BLREmirate Name"));

            trigger OnValidate()
            var
                communityRec: Record "BLRCommunity";
            begin
                if communityRec.Get("BLRCommunity") then
                    "BLRCommunity" := communityRec."BLRCommunity Name";
            end;
        }
        field(73209585; "BLRNumber of Units"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Number Of Units';
        }
        field(73209586; "BLRProperty Classification"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Classification';
            TableRelation = "BLRPrimaryClassification"."BLRClassification Name";
            trigger OnValidate()
            begin
                "BLRProperty Type" := '';
            end;
        }
        field(73209587; "BLRProperty Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Type';
            TableRelation = "BLRPropertyType"."BLRProperty Type" where("BLRClassification Name" = field("BLRProperty Classification"));
        }
        field(73209588; "BLRRegistration Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Registration Date';
        }
        field(73209589; "BLRGTIN"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'GTIN';
        }
        field(73209590; "BLROwner ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Owner ID';
            TableRelation = "BLROwnerProfile"."BLROwner ID";
        }
        field(73209591; "BLROwnership Documents"; Text[250])
        {
            Caption = 'Ownership Documents';
            DataClassification = CustomerContent;
        }
        field(73209592; "BLRCompliance Certificates"; Text[250])
        {
            Caption = 'Compliance Certificates';
            DataClassification = CustomerContent;
        }
        field(73209593; "BLRLegal Documents"; Text[250])
        {
            Caption = 'Legal Documents';
            DataClassification = CustomerContent;
        }
        field(73209594; "BLRProperty Size"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Size';
        }
        field(73209595; "BLRAddress"; Text[250])
        {
            Caption = 'Address';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(73209596; "BLRBuilt-up Area"; Decimal)
        {
            Caption = 'Built-up Area (sq. ft)';
            DataClassification = CustomerContent;
        }
        field(73209597; "BLRMakani Number"; Text[50])
        {
            Caption = 'Makani Number';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(73209598; "BLRMunicipality Number"; Text[50])
        {
            Caption = 'Municipality Number';
            DataClassification = CustomerContent;
        }
        field(73209599; "BLRDEWA Number"; Text[50])
        {
            Caption = 'DEWA Number';
            DataClassification = CustomerContent;
        }
        field(73209600; "BLRNumber of Floors"; Integer)
        {
            Caption = 'Number of Floors';
            DataClassification = CustomerContent;
        }
        field(73209601; "BLRNumber of Lifts"; Integer)
        {
            Caption = 'Number of Lifts';
            DataClassification = CustomerContent;
        }
        field(73209602; "BLRBusiness Unit Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Business Unit Code';
            TableRelation = "Business Unit".Code;
        }
        field(73209603; "BLRCountry"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Country';
            TableRelation = "BLRCountry";
            trigger OnValidate()
            var
                country: Record "BLRCountry";
            begin
                if country.Get(Rec."BLRCountry") then
                    Rec."BLRCountry" := country."BLRCountry Code";
            end;
        }
    }
    keys
    {
        key(PK;"BLRProperty ID", "BLRProperty Classification", "BLRProperty Type", "BLRProperty Size")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown;"BLRProperty ID", "BLRProperty Name", "BLRProperty Classification", "BLRProperty Type")
        {
        }
    }
    trigger OnInsert()
    var
        CompanyRec: Record "BLRCompanyData";
        NoSeriesMgt: Codeunit "No. Series";
    begin
        if "BLRProperty ID" = '' then
            "BLRProperty ID" := NoSeriesMgt.GetNextNo('PROPERTYID', Today(), true);
        if CompanyRec.FindFirst() then
            "BLRCompany ID" := CompanyRec."BLRCompany ID";
    end;

    trigger OnDelete()
    var
    begin
        deleteWorkflowFrequencyPR();
    end;

    procedure deleteWorkflowFrequencyPR()
    var
        WorkflowFrequencyPR: Record "BLRWorkflowFrequencyPR";
    begin
        WorkflowFrequencyPR.SetRange("BLRCompany ID", Rec."BLRCompany ID");
        WorkflowFrequencyPR.SetRange("BLRProperty ID", Rec."BLRProperty ID");
        if WorkflowFrequencyPR.FindSet() then
            WorkflowFrequencyPR.DeleteAll();
    end;
}
