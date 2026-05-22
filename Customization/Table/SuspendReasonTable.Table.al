table 73209695 "BLRSuspendReasonTable"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "BLRID";

    fields
    {
        field(73209575; "BLRID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            AutoIncrement = true;
        }
        field(73209576; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
            TableRelation = "BLRTenancyContract"."BLRContract ID";

            trigger OnValidate()
            var
                TenancyContractRec: Record "BLRTenancyContract";
            begin
                TenancyContractRec.SetRange("BLRContract ID", Rec."BLRContract ID");
                if TenancyContractRec.FindFirst() then begin
                    Rec."BLRTenantID" := TenancyContractRec."BLRTenant ID";
                    Rec."BLRTenantName" := TenancyContractRec."BLRCustomer Name";
                    Rec."BLREmiratesID" := TenancyContractRec."BLREmirates ID";
                    Rec."BLRContactNumber" := TenancyContractRec."BLRContact Number";
                    Rec."BLREmailAddress" := TenancyContractRec."BLREmail Address";
                    Rec."BLRTradeLicenseNo" := TenancyContractRec."BLRTenant_License No.";
                    Rec."BLRLicensingAuthority" := TenancyContractRec."BLRLicensing Authority";
                end else begin
                    Rec."BLRTenantID" := '';
                    Rec."BLRTenantName" := '';
                    Rec."BLREmiratesID" := '';
                    Rec."BLRContactNumber" := '';
                    Rec."BLREmailAddress" := '';
                    Rec."BLRTradeLicenseNo" := '';
                    Rec."BLRLicensingAuthority" := '';
                end;
            end;
        }
        field(73209577; "BLRTenantID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
        }
        field(73209578; "BLRTenantName"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant Name';
        }
        field(73209579; "BLREmiratesID"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Emirates ID';
        }
        field(73209580; "BLRContactNumber"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact Number';
        }
        field(73209581; "BLREmailAddress"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Email Address';
        }
        field(73209582; "BLRTradeLicenseNo"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant Trade License No.';
        }
        field(73209583; "BLRLicensingAuthority"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant Licensing Authority';
        }
        field(73209584; "BLRDateEffective"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Suspension Start Date';
        }
        field(73209585; "BLRReason"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Reason';
            OptionMembers = " ","Legal Reason","Business Reason";
        }
        field(73209586; "BLRDescription"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(73209587; "BLRReleaseUnit"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Release Unit';
        }
        field(73209588; "BLRReleaseDate"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Release Date';
        }
        field(73209589; "BLRSuspensionEffectiveDate"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Effective Date of Suspension to Active';
        }
        field(73209590; "BLRIssueResolutionDescription"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Issue Resolution Description';
        }
        field(73209591; "BLRTenant Contract Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant Contract Status';
            OptionMembers = " ",Suspended,Active,Terminate;

            trigger OnValidate()
            var
                TenancyContract: Record "BLRTenancyContract";
                PropertyManagerApproval: Codeunit "Property Manager Approval";
            begin
                if "BLRContract ID" = 0 then
                    Error('Contract ID must be specified.');

                if TenancyContract.Get("BLRContract ID") then begin
                    case "BLRTenant Contract Status" of
                        "BLRTenant Contract Status"::Suspended:
                            TenancyContract."BLRUpdate Contract Status" :=
                                TenancyContract."BLRUpdate Contract Status"::"Initiate Suspension Process";

                        "BLRTenant Contract Status"::Active:
                            begin
                                TenancyContract."BLRUpdate Contract Status" :=
                                    TenancyContract."BLRUpdate Contract Status"::"Initiate Activation Process";
                                "BLRSuspensionEndDate" := Today;
                            end;

                        "BLRTenant Contract Status"::Terminate:
                            TenancyContract."BLRUpdate Contract Status" :=
                                TenancyContract."BLRUpdate Contract Status"::"Initiate Termination Process";
                    end;

                    TenancyContract.Modify(true);
                    PropertyManagerApproval.HandleContractStatusUpdate(TenancyContract);
                end else
                    Error('Tenancy Contract with "BLRContract ID" %1 not found.', "BLRContract ID");
            end;

        }
        field(73209592; "BLRProposal ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Proposal ID';
            TableRelation = "BLRTenancyContract";
            trigger OnValidate()
            var
                TenancyContractRec: Record "BLRTenancyContract";
            begin
                Rec."BLRContract ID" := Rec."BLRProposal ID";
                TenancyContractRec.SetRange("BLRContract ID", Rec."BLRProposal ID");
                if TenancyContractRec.FindFirst() then begin
                    Rec."BLRProposal ID" := TenancyContractRec."BLRProposal ID";
                    Rec."BLRTenantID" := TenancyContractRec."BLRTenant ID";
                    Rec."BLRTenantName" := TenancyContractRec."BLRCustomer Name";
                    Rec."BLREmiratesID" := TenancyContractRec."BLREmirates ID";
                    Rec."BLRContactNumber" := TenancyContractRec."BLRContact Number";
                    Rec."BLREmailAddress" := TenancyContractRec."BLREmail Address";
                    Rec."BLRTradeLicenseNo" := TenancyContractRec."BLRTenant_License No.";
                    Rec."BLRLicensingAuthority" := TenancyContractRec."BLRLicensing Authority";
                end else begin
                    // Clear fields if no record is found
                    Rec."BLRContract ID" := 0;
                    Rec."BLRTenantID" := '';
                    Rec."BLRTenantName" := '';
                    Rec."BLREmiratesID" := '';
                    Rec."BLRContactNumber" := '';
                    Rec."BLREmailAddress" := '';
                    Rec."BLRTradeLicenseNo" := '';
                    Rec."BLRLicensingAuthority" := '';
                end;
            end;
        }
        field(73209593; "BLRRenewal Proposal ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Renewal ID';
            TableRelation = "BLRTenancyContract"."BLRContract ID";

            trigger OnValidate()
            var
                TenancyContractRec: Record "BLRTenancyContract";
            begin
                Rec."BLRContract ID" := Rec."BLRRenewal Proposal ID";
                TenancyContractRec.SetRange("BLRContract ID", Rec."BLRRenewal Proposal ID");
                if TenancyContractRec.FindFirst() then begin
                    Rec."BLRContract ID" := TenancyContractRec."BLRContract ID";
                    Rec."BLRTenantID" := TenancyContractRec."BLRTenant ID";
                    Rec."BLRTenantName" := TenancyContractRec."BLRCustomer Name";
                    Rec."BLREmiratesID" := TenancyContractRec."BLREmirates ID";
                    Rec."BLRContactNumber" := TenancyContractRec."BLRContact Number";
                    Rec."BLREmailAddress" := TenancyContractRec."BLREmail Address";
                    Rec."BLRTradeLicenseNo" := TenancyContractRec."BLRTenant_License No.";
                    Rec."BLRLicensingAuthority" := TenancyContractRec."BLRLicensing Authority";
                end else begin
                    Rec."BLRContract ID" := 0;
                    Rec."BLRTenantID" := '';
                    Rec."BLRTenantName" := '';
                    Rec."BLREmiratesID" := '';
                    Rec."BLRContactNumber" := '';
                    Rec."BLREmailAddress" := '';
                    Rec."BLRTradeLicenseNo" := '';
                    Rec."BLRLicensingAuthority" := '';
                end;
            end;
        }
        field(73209594; "BLRReleaseUnits"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Release Units';
            OptionMembers = " ","Yes";
            trigger OnValidate()
            var
                TenancyContract: Record "BLRTenancyContract";
            begin
                if "BLRReleaseUnits" = "BLRReleaseUnits"::"Yes" then begin
                    if ("BLRProposal ID" = 0) or ("BLRContract ID" = 0) then
                        Error('Proposal ID and "BLRContract ID" must be specified.');
                    if TenancyContract.Get("BLRContract ID") then begin
                        TenancyContract."BLRUpdate Contract Status" := TenancyContract."BLRUpdate Contract Status"::"Initiate Under Suspension-Unit Released";
                        TenancyContract.Modify();
                    end else
                        Error('Tenancy Contract with "BLRProposal ID" %1 and "BLRContract ID" %2 not found.', "BLRProposal ID", "BLRContract ID");
                end;
            end;
        }

        field(73209595; "BLRSuspensionEndDate"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Suspension End Date';
        }

        field(73209596; "BLRContract Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Type';
            OptionMembers = " ","New Contract","Renewal Contract";
        }
    }
    keys
    {
        key(PK;"BLRID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"BLRTenantID", "BLRTenantName", "BLRContract ID", "BLREmailAddress")
        {

        }
    }
}
