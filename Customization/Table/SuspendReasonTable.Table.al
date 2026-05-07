table 73209695 SuspendReasonTable
{
    DataClassification = CustomerContent;
    DataCaptionFields = ID;

    fields
    {
        field(73209575; ID; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            AutoIncrement = true;
        }
        field(73209576; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
            TableRelation = "Tenancy Contract"."Contract ID";

            trigger OnValidate()
            var
                TenancyContractRec: Record "Tenancy Contract";
            begin
                TenancyContractRec.SetRange("Contract ID", Rec."Contract ID");
                if TenancyContractRec.FindFirst() then begin
                    Rec.TenantID := TenancyContractRec."Tenant ID";
                    Rec.TenantName := TenancyContractRec."Customer Name";
                    Rec.EmiratesID := TenancyContractRec."Emirates ID";
                    Rec.ContactNumber := TenancyContractRec."Contact Number";
                    Rec.EmailAddress := TenancyContractRec."Email Address";
                    Rec.TradeLicenseNo := TenancyContractRec."Tenant_License No.";
                    Rec.LicensingAuthority := TenancyContractRec."Licensing Authority";
                end else begin
                    Rec.TenantID := '';
                    Rec.TenantName := '';
                    Rec.EmiratesID := '';
                    Rec.ContactNumber := '';
                    Rec.EmailAddress := '';
                    Rec.TradeLicenseNo := '';
                    Rec.LicensingAuthority := '';
                end;
            end;
        }
        field(73209577; TenantID; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
        }
        field(73209578; TenantName; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant Name';
        }
        field(73209579; EmiratesID; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Emirates ID';
        }
        field(73209580; ContactNumber; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact Number';
        }
        field(73209581; EmailAddress; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Email Address';
        }
        field(73209582; TradeLicenseNo; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant Trade License No.';
        }
        field(73209583; LicensingAuthority; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant Licensing Authority';
        }
        field(73209584; DateEffective; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Suspension Start Date';
        }
        field(73209585; Reason; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Reason';
            OptionMembers = " ","Legal Reason","Business Reason";
        }
        field(73209586; Description; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(73209587; ReleaseUnit; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Release Unit';
        }
        field(73209588; ReleaseDate; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Release Date';
        }
        field(73209589; SuspensionEffectiveDate; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Effective Date of Suspension to Active';
        }
        field(73209590; IssueResolutionDescription; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Issue Resolution Description';
        }
        field(73209591; "Tenant Contract Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant Contract Status';
            OptionMembers = " ",Suspended,Active,Terminate;

            trigger OnValidate()
            var
                TenancyContract: Record "Tenancy Contract";
                PropertyManagerApproval: Codeunit "Property Manager Approval";
            begin
                if "Contract ID" = 0 then
                    Error('Contract ID must be specified.');

                if TenancyContract.Get("Contract ID") then begin
                    case "Tenant Contract Status" of
                        "Tenant Contract Status"::Suspended:
                            TenancyContract."Update Contract Status" :=
                                TenancyContract."Update Contract Status"::"Initiate Suspension Process";

                        "Tenant Contract Status"::Active:
                            begin
                                TenancyContract."Update Contract Status" :=
                                    TenancyContract."Update Contract Status"::"Initiate Activation Process";
                                "SuspensionEndDate" := Today;
                            end;

                        "Tenant Contract Status"::Terminate:
                            TenancyContract."Update Contract Status" :=
                                TenancyContract."Update Contract Status"::"Initiate Termination Process";
                    end;

                    TenancyContract.Modify(true);
                    PropertyManagerApproval.HandleContractStatusUpdate(TenancyContract);
                end else
                    Error('Tenancy Contract with Contract ID %1 not found.', "Contract ID");
            end;

        }
        field(73209592; "Proposal ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Proposal ID';
            TableRelation = "Tenancy Contract";
            trigger OnValidate()
            var
                TenancyContractRec: Record "Tenancy Contract";
            begin
                Rec."Contract ID" := Rec."Proposal ID";
                TenancyContractRec.SetRange("Contract ID", Rec."Proposal ID");
                if TenancyContractRec.FindFirst() then begin
                    Rec."Proposal ID" := TenancyContractRec."Proposal ID";
                    Rec.TenantID := TenancyContractRec."Tenant ID";
                    Rec.TenantName := TenancyContractRec."Customer Name";
                    Rec.EmiratesID := TenancyContractRec."Emirates ID";
                    Rec.ContactNumber := TenancyContractRec."Contact Number";
                    Rec.EmailAddress := TenancyContractRec."Email Address";
                    Rec.TradeLicenseNo := TenancyContractRec."Tenant_License No.";
                    Rec.LicensingAuthority := TenancyContractRec."Licensing Authority";
                end else begin
                    // Clear fields if no record is found
                    Rec."Contract ID" := 0;
                    Rec.TenantID := '';
                    Rec.TenantName := '';
                    Rec.EmiratesID := '';
                    Rec.ContactNumber := '';
                    Rec.EmailAddress := '';
                    Rec.TradeLicenseNo := '';
                    Rec.LicensingAuthority := '';
                end;
            end;
        }
        field(73209593; "Renewal Proposal ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Renewal ID';
            TableRelation = "Tenancy Contract"."Contract ID";

            trigger OnValidate()
            var
                TenancyContractRec: Record "Tenancy Contract";
            begin
                Rec."Contract ID" := Rec."Renewal Proposal ID";
                TenancyContractRec.SetRange("Contract ID", Rec."Renewal Proposal ID");
                if TenancyContractRec.FindFirst() then begin
                    Rec."Contract ID" := TenancyContractRec."Contract ID";
                    Rec.TenantID := TenancyContractRec."Tenant ID";
                    Rec.TenantName := TenancyContractRec."Customer Name";
                    Rec.EmiratesID := TenancyContractRec."Emirates ID";
                    Rec.ContactNumber := TenancyContractRec."Contact Number";
                    Rec.EmailAddress := TenancyContractRec."Email Address";
                    Rec.TradeLicenseNo := TenancyContractRec."Tenant_License No.";
                    Rec.LicensingAuthority := TenancyContractRec."Licensing Authority";
                end else begin
                    Rec."Contract ID" := 0;
                    Rec.TenantID := '';
                    Rec.TenantName := '';
                    Rec.EmiratesID := '';
                    Rec.ContactNumber := '';
                    Rec.EmailAddress := '';
                    Rec.TradeLicenseNo := '';
                    Rec.LicensingAuthority := '';
                end;
            end;
        }
        field(73209594; ReleaseUnits; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Release Units';
            OptionMembers = " ","Yes";
            trigger OnValidate()
            var
                TenancyContract: Record "Tenancy Contract";
            begin
                if ReleaseUnits = ReleaseUnits::"Yes" then begin
                    if ("Proposal ID" = 0) or ("Contract ID" = 0) then
                        Error('Proposal ID and Contract ID must be specified.');
                    if TenancyContract.Get("Contract ID") then begin
                        TenancyContract."Update Contract Status" := TenancyContract."Update Contract Status"::"Initiate Under Suspension-Unit Released";
                        TenancyContract.Modify();
                    end else
                        Error('Tenancy Contract with Proposal ID %1 and Contract ID %2 not found.', "Proposal ID", "Contract ID");
                end;
            end;
        }

        field(73209595; SuspensionEndDate; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Suspension End Date';
        }

        field(73209596; "Contract Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Type';
            OptionMembers = " ","New Contract","Renewal Contract";
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; TenantID, TenantName, "Contract ID", EmailAddress)
        {

        }
    }
}
