table 73209702 "BLRTenancyContract"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "BLRContract ID";

    fields
    {
        field(73209575; "BLROwner's Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Owner Name';
            TableRelation = "BLROwnerProfile";
            trigger OnValidate()
            var
                OwnerRec: Record "BLROwnerProfile";
                ownerID: Integer;
            begin
                Evaluate(ownerID, "BLROwner's Name");
                if "BLROwner's Name" <> '' then begin
                    OwnerRec.Reset();
                    OwnerRec.SetRange("BLROwner ID", ownerID);
                    if OwnerRec.FindFirst() then begin
                        "BLROwner's Name" := OwnerRec."BLRFull Name";
                        "BLROwner ID" := OwnerRec."BLROwner ID";
                    end;
                end;
            end;
        }
        field(73209576; "BLRLessor's Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Lessor Name';
        }
        field(73209577; "BLRLessor's Emirates ID"; Code[15])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Lessor Emirates ID';
        }
        field(73209578; "BLRLicense No."; Code[20])
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'License No.';
        }
        field(73209579; "BLRLicensing Authority"; Text[100])
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'Licensing Authority';
        }
        field(73209580; "BLRLessor's Email"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Lessor Email';
        }
        field(73209581; "BLRLessor's Phone"; Text[20])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Lessor Phone';
        }
        field(73209582; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
            AutoIncrement = true;
        }
        field(73209583; "BLRProposal ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Proposal ID';
            TableRelation = "BLRLeaseProposalDetails"."BLRProposal ID" WHERE("BLRProposal Status" = CONST(Approved));

            trigger OnValidate()
            var
                LeaseProposalRec: Record "BLRLeaseProposalDetails";
                TenantContractRec: Record "BLRTenancyContract";
                propertyRegistration: Record "BLRPropertyRegistration";
                OwnerRec: Record "BLROwnerProfile";
            begin
                TenantContractRec.Reset();
                TenantContractRec.SetRange("BLRProposal ID", "BLRProposal ID");

                if TenantContractRec.FindFirst() and (TenantContractRec."BLRContract ID" <> "BLRContract ID") then
                    Error('The selected "BLRProposal ID" is already used for another tenant contract.');

                LeaseProposalRec.SetRange("BLRProposal ID", "BLRProposal ID");
                if LeaseProposalRec.FindFirst() then begin
                    "BLRTenant ID" := LeaseProposalRec."BLRTenant ID";
                    "BLRTenant_License No." := LeaseProposalRec."BLRLicense No.";
                    "BLRTenant_Licensing Authority" := LeaseProposalRec."BLRLicensing Authority";
                    "BLRCustomer Name" := LeaseProposalRec."BLRTenant Full Name";
                    "BLREmail Address" := LeaseProposalRec."BLRTenant Contact Email";
                    "BLREmirates ID" := CopyStr(LeaseProposalRec."BLREmirates ID", 1, StrLen(LeaseProposalRec."BLREmirates ID"));
                    "BLRProperty ID" := LeaseProposalRec."BLRProperty ID";
                    "BLRPayment Frequency" := LeaseProposalRec."BLRPayment Frequency";
                    "BLRPayment Method" := LeaseProposalRec."BLRPayment Method";
                    "BLRBase Unit of Measure" := LeaseProposalRec."BLRBase Unit of Measure";
                    "BLRContact Number" := CopyStr(LeaseProposalRec."BLRTenant Contact Phone", 1, StrLen(LeaseProposalRec."BLRTenant Contact Phone"));
                    "BLRUnit ID" := LeaseProposalRec."BLRUnit ID";
                    "BLRMerge Unit ID" := LeaseProposalRec."BLRMerge Unit ID";
                    "BLRUnit Name" := LeaseProposalRec."BLRUnit Name";
                    "BLRUnit Sq. Feet" := LeaseProposalRec."BLRUnit Size";
                    "BLRAnnual Rent Amount" := LeaseProposalRec."BLRRent Amount";
                    "BLRUnitID" := LeaseProposalRec."BLRUnitID";
                    "BLRProperty Classification" := LeaseProposalRec."BLRUsage Type";
                    "BLRProperty Type" := LeaseProposalRec."BLRUnit Type";
                    "BLRProperty Name" := LeaseProposalRec."BLRProperty Name";
                    "BLRContract Start Date" := LeaseProposalRec."BLRLease Start Date";
                    "BLRContract End Date" := LeaseProposalRec."BLRLease End Date";
                    "BLRContract Tenor" := LeaseProposalRec."BLRLease Duration";
                    "BLRAnnual Rent Amount" := LeaseProposalRec."BLRAnnual Rent Amount";
                    "BLRRent Amount" := LeaseProposalRec."BLRRent Amount";
                    "BLRSecurity Deposit Amount" := LeaseProposalRec."BLRSecurity Deposit Amount";
                    "BLRSecurity Amount Pending" := LeaseProposalRec."BLRSecurity Deposit Amount";
                    "BLRUnit Number" := LeaseProposalRec."BLRUnit Number";
                    "BLRMakani Number" := LeaseProposalRec."BLRMakani Number";
                    "BLRMunicipality Number" := LeaseProposalRec."BLRMunicipality Number";
                    "BLREmirate" := LeaseProposalRec."BLREmirate";
                    "BLRCommunity" := LeaseProposalRec."BLRCommunity";
                    "BLRDEWA Number" := LeaseProposalRec."BLRDEWA Number";
                    "BLRProperty Size" := LeaseProposalRec."BLRProperty Size";
                    "BLRNo of Installments" := LeaseProposalRec."BLRNo of Installments";
                    "BLRPraposal Type Selected" := LeaseProposalRec."BLRPraposal Type Selected";
                    "BLRUnit Address" := LeaseProposalRec."BLRUnit Address";
                    "BLRUsage Type" := LeaseProposalRec."BLRUsage Type";
                    "BLRUnit Type" := LeaseProposalRec."BLRUnit Type";
                    "BLRSingle Unit Name" := LeaseProposalRec."BLRSingle Unit Name";
                    "BLRMarket Rate per Sq. Ft." := LeaseProposalRec."BLRMarket Rate per Sq. Ft.";
                    "BLRFacilities/Amenities" := LeaseProposalRec."BLRFacilities/Amenities";

                    "BLRUnit Number" := LeaseProposalRec."BLRUnit Number";
                    "BLRSingle Rent Calculation" := LeaseProposalRec."BLRSingle Rent Calculation";
                    "BLRMerge Rent Calculation" := LeaseProposalRec."BLRMerge Rent Calculation";
                    "BLRContract VAT %" := LeaseProposalRec."BLRRent Amount VAT %";
                    "BLRContract VAT Amount" := LeaseProposalRec."BLRRent VAT Amount";
                    "BLRContAmtInclVAT" := LeaseProposalRec."BLRRent Amount Including VAT";

                    propertyRegistration.SetRange("BLRProperty ID", LeaseProposalRec."BLRProperty ID");
                    if propertyRegistration.FindFirst() then begin
                        OwnerRec.SetRange("BLROwner ID", propertyRegistration."BLROwner ID");
                        if OwnerRec.FindFirst() then begin
                            "BLROwner ID" := OwnerRec."BLROwner ID";
                            "BLROwner's Name" := OwnerRec."BLRFull Name";
                        end;
                    end;
                    TenancyContractSubpage();
                    rentdatafetch();
                    brokerdata();
                    TCAdditionalTermFetch();

                end;
            end;
        }
        field(73209584; "BLRProperty Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Name';
        }
        field(73209585; "BLRCustomer Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Name';
            TableRelation = Customer.Name;
        }
        field(73209586; "BLRUnit Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Name';
        }
        field(73209587; "BLREjari Name"; Text[100])
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'Ejari Name';
        }
        field(73209588; "BLRProperty Classification"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Classification';
            TableRelation = "BLRPrimaryClassification"."BLRClassification Name";
            NotBlank = true;
        }
        field(73209589; "BLRProperty Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Type';
            TableRelation = "BLRSecondaryClassification" where("BLRClassification Name" = field("BLRProperty Classification"));

            trigger OnValidate()
            var
                secondaryClassification: Record "BLRSecondaryClassification";
            begin
                if secondaryClassification.Get(Rec."BLRProperty Type") then
                    Rec."BLRProperty Type" := secondaryClassification."BLRProperty Type";
            end;
        }
        field(73209590; "BLRAnnual Rent Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Amount ';
        }
        field(73209591; "BLRContract Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Date';
            trigger OnValidate()
            var
            begin
                TenancyContractSubpage();
                TenancyContractSubpage2();
            end;
        }
        field(73209592; "BLRContract Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start Date';
        }
        field(73209593; "BLRContract End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract End Date';
        }
        field(73209594; "BLRContract Tenor"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Period (Months)';
        }
        field(73209595; "BLRBase Unit of Measure"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Base Unit of Measure';
        }
        field(73209596; "BLRUnit Sq. Feet"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Size';
        }
        field(73209597; "BLRGrace Period"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Grace Period (Days)';
        }
        field(73209598; "BLRGrace Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Grace Start Date';
            trigger OnValidate()
            begin
                this.CalculateGracePeriod();
            end;
        }
        field(73209599; "BLRGrace End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Grace End Date';
            trigger OnValidate()
            begin
                CalculateGracePeriod();
            end;
        }
        field(73209600; "BLRTenant ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
            TableRelation = Customer."No.";
        }
        field(73209601; "BLRProperty ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Property ID';
            TableRelation = "BLRPropertyRegistration"."BLRProperty ID";
        }
        field(73209602; "BLRUnit ID"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Single Unit ID';
            TableRelation = "Item"."No." where("BLRProperty ID" = field("BLRProperty ID"));
        }
        field(73209603; "BLREmirates ID"; Code[25])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Emirates ID';
        }
        field(73209604; "BLRContact Number"; Text[20])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Contact Number';
        }
        field(73209605; "BLREmail Address"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Email Address';
        }
        field(73209606; "BLRPayment Frequency"; Option)
        {
            OptionMembers = " ",Monthly,Quarterly,"Half-Yearly",Yearly;
            DataClassification = CustomerContent;
        }
        field(73209607; "BLRPayment Method"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209608; "BLRUpdate Contract Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Update Contract Status';
            OptionMembers = " ","Initiate Activation Process","Initiate Suspension Process","Initiate Termination Process","Initiate Under Suspension-Unit Released";
        }
        field(73209609; "BLRTenant Contract Status"; Option)
        {
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Tenant Contract Status';
            OptionMembers = " ",Active,Terminated,Suspended,Inactive,"Under Suspension-Unit Released","Active-Contract Renewed","Contract Renewed";

            trigger OnValidate()
            var
                ItemRec: Record Item;
                MergeUnitRec: Record "BLRMergedUnits";
                LeaseProposalRec: Record "BLRLeaseProposalDetails";
                paymentscheule: Record "BLRPaymentSchedule";
                paymentschedule2: Record "BLRPaymentSchedule2";
                paymentscheule1: Record "BLRPaymentSchedule";
                paymentschedule3grid: Record "BLRPaymentSchedule2";
                paymentscheulecard: Record "BLRPaymentSchedule";
                emailrec: Codeunit "Send Contract Email";
            begin
                if Rec."BLRTenant Contract Status" = Rec."BLRTenant Contract Status"::Active then begin
                    if paymentscheule.Get(Rec."BLRContract ID") then begin
                        paymentscheule."BLRContract Status" := Format(Rec."BLRTenant Contract Status");
                        paymentscheule.Modify();
                    end;

                    paymentschedule2.SetRange("BLRContract ID", Rec."BLRContract ID");
                    if paymentschedule2.FindSet() then
                        repeat
                            paymentschedule2."BLRContract Status" := Format(Rec."BLRTenant Contract Status");
                            paymentschedule2.Modify();
                        until paymentschedule2.Next() = 0;

                end;

                if Rec."BLRTenant Contract Status" = Rec."BLRTenant Contract Status"::Suspended then
                    if paymentscheule1.Get(Rec."BLRContract ID") then begin
                        paymentscheule1."BLRContract Status" := Format(Rec."BLRTenant Contract Status");
                        paymentscheule1.Modify();
                    end;

                if Rec."BLRTenant Contract Status" = Rec."BLRTenant Contract Status"::Terminated then begin
                    if paymentscheulecard.Get(Rec."BLRContract ID") then begin
                        paymentscheulecard."BLRContract Status" := Format(Rec."BLRTenant Contract Status");
                        paymentscheulecard.Modify();
                    end;

                    paymentschedule3grid.SetRange("BLRContract ID", Rec."BLRContract ID");
                    if paymentschedule3grid.FindSet() then
                        repeat
                            paymentschedule3grid."BLRContract Status" := Format(Rec."BLRTenant Contract Status");
                            paymentschedule3grid.Modify();
                        until paymentschedule3grid.Next() = 0;

                end;

                if ("BLRTenant Contract Status" = "BLRTenant Contract Status"::Terminated) or
                    ("BLRTenant Contract Status" = "BLRTenant Contract Status"::"Under Suspension-Unit Released") then begin

                    LeaseProposalRec.Reset();
                    LeaseProposalRec.SetRange("BLRProposal ID", Rec."BLRProposal ID"); // assuming field exists

                    if LeaseProposalRec.FindFirst() then begin
                        LeaseProposalRec."BLRProposal Status" := LeaseProposalRec."BLRProposal Status"::Completed;
                        LeaseProposalRec.Modify();
                    end;
                end;

                if "BLRUnit ID" <> '' then
                    if ItemRec.Get("BLRUnit ID") then begin
                        case "BLRTenant Contract Status" of
                            "BLRTenant Contract Status"::Active,
                            "BLRTenant Contract Status"::Suspended:
                                ItemRec."BLRUnit Status" := ItemRec."BLRUnit Status"::Occupied;

                            "BLRTenant Contract Status"::Terminated,
                            "BLRTenant Contract Status"::"Under Suspension-Unit Released":
                                ItemRec."BLRUnit Status" := ItemRec."BLRUnit Status"::Free;
                        end;
                        ItemRec.Modify();
                    end;

                if "BLRMerge Unit ID" <> '' then
                    if MergeUnitRec.Get("BLRMerge Unit ID") then begin
                        case "BLRTenant Contract Status" of
                            "BLRTenant Contract Status"::Terminated:
                                MergeUnitRec."BLRStatus" := MergeUnitRec."BLRStatus"::Free;
                            "BLRTenant Contract Status"::"Under Suspension-Unit Released":
                                MergeUnitRec."BLRStatus" := MergeUnitRec."BLRStatus"::Free;
                            "BLRTenant Contract Status"::Active:
                                MergeUnitRec."BLRStatus" := MergeUnitRec."BLRStatus"::Occupied;
                            "BLRTenant Contract Status"::Suspended:
                                MergeUnitRec."BLRStatus" := MergeUnitRec."BLRStatus"::Occupied;
                        end;

                        case "BLRTenant Contract Status" of
                            "BLRTenant Contract Status"::Active:
                                MergeUnitRec."BLRSpliting Status" := MergeUnitRec."BLRSpliting Status"::Merge;
                            "BLRTenant Contract Status"::Terminated:
                                MergeUnitRec."BLRSpliting Status" := MergeUnitRec."BLRSpliting Status"::Merge;
                            "BLRTenant Contract Status"::Suspended:
                                MergeUnitRec."BLRSpliting Status" := MergeUnitRec."BLRSpliting Status"::Merge;
                            "BLRTenant Contract Status"::"Under Suspension-Unit Released":
                                MergeUnitRec."BLRSpliting Status" := MergeUnitRec."BLRSpliting Status"::Merge;
                        end;

                        MergeUnitRec.Modify();

                        if MergeUnitRec."BLRUnit ID" <> '' then begin
                            ItemRec.SetRange("BLRMerged Unit ID", MergeUnitRec."BLRMerged Unit ID");
                            if ItemRec.FindSet() then
                                repeat
                                    case "BLRTenant Contract Status" of
                                        "BLRTenant Contract Status"::Active,
                                          "BLRTenant Contract Status"::Suspended:
                                            ItemRec."BLRUnit Status" := ItemRec."BLRUnit Status"::Occupied;

                                        "BLRTenant Contract Status"::Terminated,
                                            "BLRTenant Contract Status"::"Under Suspension-Unit Released":
                                            ItemRec."BLRUnit Status" := ItemRec."BLRUnit Status"::Free;
                                    end;
                                    ItemRec.Modify();
                                until ItemRec.Next() = 0;
                        end;
                    end;

                if Rec."BLRTenant Contract Status" = Rec."BLRTenant Contract Status"::Active then
                    emailrec.SendEmail(Rec);
            end;
        }
        field(73209610; "BLRUnitID"; code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Uniq Unit ID';
        }
        field(73209611; "BLRCreated By"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
        }
        field(73209612; "BLRHandover is Completed"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Handover is Completed';
        }
        field(73209613; "BLRHandover of PDC"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Handover of PDC';
        }
        field(73209614; "BLRSigned TC Document"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Signed TC Document';
        }
        field(73209615; "BLRHandover Unit"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Handover Unit';
        }
        field(73209616; "BLRMerge Unit ID"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Merge Unit ID';
        }
        field(73209617; "BLRRent Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Annual "BLRRent Amount" ';
        }
        field(73209618; "BLRTenant_License No."; Code[20])
        {
            Caption = 'Tenant Trade License No.';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(73209619; "BLRTenant_Licensing Authority"; Text[100])
        {
            Caption = 'Tenant_Licensing Authority';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(73209620; "BLRSecurity Deposit Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209621; "BLRUnit Number"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(73209622; "BLRMakani Number"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
        }
        field(73209623; "BLREmirate"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(73209624; "BLRCommunity"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209625; "BLRDEWA Number"; Text[100])
        {
            Caption = 'DEWA Number';
            DataClassification = CustomerContent;
        }
        field(73209626; "BLRProperty Size"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Size';
        }
        field(73209627; "BLRID"; Integer)
        {
            Caption = 'Suspended Reason ID';
            DataClassification = CustomerContent;
        }
        field(73209628; "BLRSuspended Reason list"; Text[250])
        {
            Caption = 'Suspended Reason list';
            DataClassification = CustomerContent;
        }
        field(73209629; "BLRNo of Installments"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No of Installments';
            Editable = false;
        }
        field(73209630; "BLRUpload Document"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Upload Document';
        }
        field(73209631; "BLRview Document"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'view Document';
        }
        field(73209632; "BLRdocument URL"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Logo URL';
        }
        field(73209633; "BLRRenewal Contract Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Renewal Contract Status';
            OptionMembers = "N/A","Notify Tenant For Renewal";
        }
        field(73209634; "BLRContract Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Type';
            OptionMembers = " ","New Contract","Renewal Contract";

            trigger OnValidate()
            begin
                Rec.Insert();
            end;
        }
        field(73209635; "BLRRenewal Proposal ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Renewal Proposal ID';
            TableRelation = "BLRContractRenewal"."BLRId" WHERE("BLRFinal Status" = CONST(Approved));

            trigger OnValidate()
            var
                ContractRenewal: Record "BLRContractRenewal";
                TenantContractRec: Record "BLRTenancyContract";
            begin
                TenantContractRec.Reset();
                TenantContractRec.SetRange("BLRProposal ID", "BLRProposal ID");

                ContractRenewal.SetRange("BLRID", "BLRRenewal Proposal ID");
                if ContractRenewal.FindFirst() then begin
                    "BLRTenant ID" := ContractRenewal."BLRTenant ID";
                    "BLRTenant_License No." := ContractRenewal."BLRLicense No.";
                    "BLRTenant_Licensing Authority" := ContractRenewal."BLRLicensing Authority";
                    "BLRCustomer Name" := ContractRenewal."BLRTenant Full Name";
                    "BLREmail Address" := ContractRenewal."BLREmail Address";
                    "BLREmirates ID" := ContractRenewal."BLREmirates ID";
                    "BLRProperty ID" := ContractRenewal."BLRProperty ID";
                    "BLRPayment Frequency" := ContractRenewal."BLRPayment Frequency";
                    "BLRPayment Method" := ContractRenewal."BLRPayment Method";
                    "BLRBase Unit of Measure" := ContractRenewal."BLRBase Unit of Measure";
                    "BLRContact Number" := CopyStr(ContractRenewal."BLRContact Number", 1, StrLen(ContractRenewal."BLRContact Number"));
                    "BLRUnit ID" := ContractRenewal."BLRUnit ID";
                    "BLRMerge Unit ID" := ContractRenewal."BLRMerge Unit ID";
                    "BLRUnit Name" := ContractRenewal."BLRUnit Name";
                    "BLRUnit Sq. Feet" := ContractRenewal."BLRUnit Sq. Feet";
                    "BLRAnnual Rent Amount" := ContractRenewal."BLRRent Amount";
                    "BLRUnitID" := ContractRenewal."BLRUnitID";
                    "BLRProperty Classification" := ContractRenewal."BLRProperty Classification";
                    "BLRProperty Type" := ContractRenewal."BLRProperty Type";
                    "BLRProperty Name" := ContractRenewal."BLRProperty Name";
                    "BLRContract Start Date" := ContractRenewal."BLRContract Start Date";
                    "BLRContract End Date" := ContractRenewal."BLRContract End Date";
                    "BLRContract Tenor" := ContractRenewal."BLRContract Tenor";
                    "BLRAnnual Rent Amount" := ContractRenewal."BLRContract Amount";
                    "BLRRent Amount" := ContractRenewal."BLRRent Amount";
                    "BLRSecurity Deposit Amount" := ContractRenewal."BLRSecurity Deposit Amount";
                    "BLRUnit Number" := ContractRenewal."BLRUnit Number";
                    "BLRMakani Number" := ContractRenewal."BLRMakani Number";
                    "BLRMunicipality Number" := ContractRenewal."BLRMunicipality Number";
                    "BLREmirate" := ContractRenewal."BLREmirate";
                    "BLRCommunity" := ContractRenewal."BLRCommunity";
                    "BLRDEWA Number" := ContractRenewal."BLRDEWA Number";
                    "BLRProperty Size" := ContractRenewal."BLRProperty Size";
                    "BLRNo of Installments" := ContractRenewal."BLRNo of Installments";
                    "BLRUnit Type" := ContractRenewal."BLRUnit Type";
                    "BLRUsage Type" := ContractRenewal."BLRUsage Type";

                    "BLRSingle Rent Calculation" := ContractRenewal."BLRSingle Rent Calculation";
                    "BLRMerge Rent Calculation" := ContractRenewal."BLRMerge Rent Calculation";
                    "BLRPraposal Type Selected" := ContractRenewal."BLRPraposal Type Selected";

                    TenancyContractSubpage2();
                    rentdatafetched();
                    renewalbrokerdata();
                    RenewalAdditionalTermFetch();

                end;
            end;
        }
        field(73209636; "BLRYes/No"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Yes/No';
        }
        field(73209637; "BLRPraposal Type Selected"; Option)
        {
            OptionMembers = " ","Single Unit","Merge Unit";
            DataClassification = CustomerContent;
        }
        field(73209638; "BLRUnit Address"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
        }
        field(73209639; "BLRUsage Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Usage Type';
            NotBlank = true;
        }
        field(73209640; "BLRUnit Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Type';
        }
        field(73209641; "BLRSingle Unit Name"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Single Unit Names';
        }
        field(73209642; "BLRMarket Rate per Sq. Ft."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Market Rate per Sq. Ft. ';
        }
        field(73209643; "BLRFacilities/Amenities"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(73209644; "BLRSecDepAmtReceived"; Decimal)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                "BLRSecurity Amount Pending" := "BLRSecurity Deposit Amount" - "BLRSecDepAmtReceived";
                UpdateSecurityDepositBalance();
            end;
        }
        field(73209645; "BLRSingle Rent Calculation"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Single Unit Rent Calculation Type';
            Editable = false;
            OptionMembers = " ","Single Unit with square feet rate","Single Unit with lumpsum square feet rate";
        }
        field(73209646; "BLRMerge Rent Calculation"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Merge Unit Rent Calculation Type';
            OptionMembers = " ","Merged Unit with same square feet","Merged Unit with differential square feet rate","Merged Unit with lumpsum annual amount";
        }
        field(73209647; "BLRUpdate Data"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Rent Calculation';
            InitValue = 'Update Data';
        }
        field(73209648; "BLRFinal Calculation"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Final Calculation';
            InitValue = 'Final Calculation';
            Editable = false;
        }
        field(73209649; "BLRContract VAT %"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "0%","5%";
            Editable = false;
        }
        field(73209650; "BLRContract VAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(73209651; "BLRContAmtInclVAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(73209652; "BLRSecurity Amount Pending"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            begin
                UpdateTenancyContractSubPage();
            end;
        }
        field(73209653; "BLRSecurity Balanced Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(73209654; "BLRTermination Of Contract"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Regular Termination","Early Termination","Suspension to Termination";
            Editable = true;
        }
        field(73209655; "BLRTermination Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209656; "BLRUnpaid Rent Due"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209657; "BLRPenalty Charges"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209658; "BLRDamage Charges"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209659; "BLRService Charges Due"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209660; "BLRFinal Refundable Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209661; "BLRApproval Required"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(73209662; "BLRApproval Stauts"; Enum "Approval Status Enum")
        {
            DataClassification = CustomerContent;
        }
        field(73209663; "BLRApproved By"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209664; "BLRFinal Settlement Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209665; "BLRRent Calculation Link"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Rent Calculation Link';
            Editable = false;
        }
        field(73209666; "BLRLink"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Final Calculation Link';
            Editable = false;
        }
        field(73209667; "BLRRenewalNotiftoTenant"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Renewal Notification to Tenant';
            Editable = true;
        }
        field(73209668; "BLRTenantLoyaltyCheckReminder"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant Loyalty Check Reminder';
            Editable = true;
        }
        field(73209669; "BLRPayment Reminder"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Reminder';
            Editable = false;
        }
        field(73209670; "BLRPrevious Status"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Previous Status';
            Editable = true;
        }
        field(73209671; "BLRVendor ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor ID';
        }
        field(73209672; "BLRVendor Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Vendor Name';
        }
        field(73209673; "BLRPercentage"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Percentage';
        }
        field(73209674; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
        field(73209675; "BLRCalculation Method"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Calculation Method';
            TableRelation = "BLRCalculationType"."BLRCalculation Type";
        }

        field(73209676; "BLRPercentage Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Percentage Type';
            OptionMembers = " ","Fixed","Variable";
        }
        field(73209677; "BLRBase Amount Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Base Amount Type';
            OptionMembers = " ","Revenue","Collection","Annual Rent","Monthly Rent";
        }
        field(73209678; "BLRFrequency Of Payment"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Frequency Of Payment';
            OptionMembers = " ","Monthly","Quaterly","Half Yearly","Yearly";
        }

        field(73209679; "BLRStart Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
            //  Editable = false;
        }
        field(73209680; "BLREnd Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
            //  Editable = false;
        }

        field(73209681; "BLRContract Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Status';
            OptionMembers = " ","Active","Terminate";
        }
        field(73209682; "BLROwner ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Owner ID';
            Editable = false;
            TableRelation = "BLROwnerProfile"."BLROwner ID";
        }
        field(73209683; "BLRLessor's Nationality"; Text[50])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Nationality';
        }
        field(73209684; "BLRLessor's Address"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Address';
        }
        field(73209685; "BLRIsCarryForwarded"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(73209686; "BLRCarry Forward In"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Carry Forward In';

            trigger OnValidate()
            var
                tenancyContractSubPage: Record "BLRTenancyContractSubpage";
            begin
                tenancyContractSubPage.SetRange("BLRContractID", Rec."BLRContract ID");
                tenancyContractSubPage.SetRange("BLRSecondary Item Type", 'Security Deposit');
                if tenancyContractSubPage.FindFirst() then begin
                    Rec.Validate("BLRSecDepAmtReceived", "BLRCarry Forward In" + tenancyContractSubPage."BLRInvoiced and Paid");
                    Rec.Modify()
                end;
            end;
        }
        field(73209687; "BLRCarry Forward Out"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Carry Forward Out';
            trigger OnValidate()
            begin
                UpdateSecurityDepositBalance();
            end;
        }
        field(73209688; "BLRAdjustments"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Adjustments';

            trigger OnValidate()
            begin
                UpdateSecurityDepositBalance();
            end;
        }
        field(73209689; "BLRRefund"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Refund';

            trigger OnValidate()
            begin
                UpdateSecurityDepositBalance();
            end;
        }
        field(73209690; "BLRMunicipality Number"; Text[100])
        {
            Caption = 'Municipality Number';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "BLRContract ID")
        {
            Clustered = false;
        }

        key(PK1; SystemId)
        {
            Clustered = false;
        }

        key(PK2; "BLRProposal ID", "BLRRenewal Proposal ID")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
        fieldgroup(DropDown; "BLRContract ID", "BLRProposal ID", "BLRRenewal Proposal ID")
        { }
    }

    procedure TenancyContractSubpage()
    var
        RevenueSubpage: Record "BLRRevenueItemSubpage";
        lTenancyContractSubpage: Record "BLRTenancyContractSubpage";
    begin
        if Rec."BLRContract Type" = Rec."BLRContract Type"::"New Contract" then begin
            lTenancyContractSubpage.SetRange("BLRContractID", Rec."BLRContract ID");
            if lTenancyContractSubpage.FindSet() then
                lTenancyContractSubpage.DeleteAll();

            RevenueSubpage.SetRange("BLRProposalID", Rec."BLRProposal ID");
            if RevenueSubpage.FindSet() then
                repeat
                    lTenancyContractSubpage.Init();
                    lTenancyContractSubpage."BLRProposalID" := RevenueSubpage."BLRProposalID";
                    lTenancyContractSubpage."BLRContractID" := Rec."BLRContract ID";
                    lTenancyContractSubpage."BLRTenantID" := rec."BLRTenant ID";
                    lTenancyContractSubpage."BLRSecondary Item Type" := RevenueSubpage."BLRSecondary Item Type";
                    lTenancyContractSubpage."BLRAmount" := RevenueSubpage."BLRAmount";
                    lTenancyContractSubpage."BLRVAT Amount" := RevenueSubpage."BLRVAT Amount";
                    lTenancyContractSubpage."BLRVAT %" := RevenueSubpage."BLRVAT %";
                    lTenancyContractSubpage."BLRAmount Including VAT" := RevenueSubpage."BLRAmount Including VAT";
                    lTenancyContractSubpage."BLRStart Date" := RevenueSubpage."BLRStart Date";
                    lTenancyContractSubpage."BLREnd Date" := RevenueSubpage."BLREnd Date";
                    lTenancyContractSubpage."BLRPayment Type" := RevenueSubpage."BLRPayment Type";
                    lTenancyContractSubpage.Insert();
                    Clear(lTenancyContractSubpage);
                until RevenueSubpage.Next() = 0;
        end;
    end;

    procedure TenancyContractSubpage2()
    var
        RevenueSubpage: Record "BLRContractRenewalSubpage";
        lTenancyContractSubpage: Record "BLRTenancyContractSubpage";
    begin
        if Rec."BLRContract Type" = Rec."BLRContract Type"::"Renewal Contract" then begin
            lTenancyContractSubpage.SetRange("BLRContractID", Rec."BLRContract ID");
            if lTenancyContractSubpage.FindSet() then
                lTenancyContractSubpage.DeleteAll();

            RevenueSubpage.SetRange("BLRID", "BLRRenewal Proposal ID");
            if RevenueSubpage.FindSet() then
                repeat
                    lTenancyContractSubpage.Init();
                    lTenancyContractSubpage."BLRContract Renewal ID" := RevenueSubpage."BLRId";
                    lTenancyContractSubpage."BLRContractID" := Rec."BLRContract ID";
                    lTenancyContractSubpage."BLRTenantID" := rec."BLRTenant ID";
                    lTenancyContractSubpage."BLRSecondary Item Type" := RevenueSubpage."BLRSecondary Item Type";
                    lTenancyContractSubpage."BLRAmount" := RevenueSubpage."BLRAmount";
                    lTenancyContractSubpage."BLRVAT Amount" := RevenueSubpage."BLRVAT Amount";
                    lTenancyContractSubpage."BLRVAT %" := RevenueSubpage."BLRVAT %";
                    lTenancyContractSubpage."BLRAmount Including VAT" := RevenueSubpage."BLRAmount Including VAT";
                    lTenancyContractSubpage."BLRStart Date" := RevenueSubpage."BLRStart Date";
                    lTenancyContractSubpage."BLREnd Date" := RevenueSubpage."BLREnd Date";
                    lTenancyContractSubpage."BLRPayment Type" := RevenueSubpage."BLRPayment Type";
                    lTenancyContractSubpage.Insert();
                    Clear(lTenancyContractSubpage);
                until RevenueSubpage.Next() = 0;
        end;

    end;

    procedure TCAdditionalTermFetch()
    var
        additionalTerm: Record "BLRAdditionalTerms";
        TCAdditionalTerm: Record "BLRTCAdditionalTerms";
    begin
        if Rec."BLRContract Type" = Rec."BLRContract Type"::"New Contract"
               then begin
            TCAdditionalTerm.SetRange("BLRDocument No.", Rec."BLRContract ID");
            if TCAdditionalTerm.FindSet() then
                TCAdditionalTerm.DeleteAll();
            additionalTerm.SetRange("BLRDocument No.", Rec."BLRProposal ID");
            if additionalTerm.FindSet() then
                repeat
                    TCAdditionalTerm.Init();
                    TCAdditionalTerm."BLRDocument No." := Rec."BLRContract ID";
                    TCAdditionalTerm."BLRDescription" := additionalTerm."BLRDescription";
                    TCAdditionalTerm.Insert();
                    Clear(TCAdditionalTerm);
                until additionalTerm.Next() = 0;
        end;
    end;

    procedure RenewalAdditionalTermFetch()
    var
        additionalTerm: Record "BLRRenewalAdditionalTerms";
        TCAdditionalTerm: Record "BLRTCAdditionalTerms";
    begin
        if Rec."BLRContract Type" = Rec."BLRContract Type"::"Renewal Contract"
               then begin
            TCAdditionalTerm.SetRange("BLRDocument No.", Rec."BLRContract ID");
            if TCAdditionalTerm.FindSet() then
                TCAdditionalTerm.DeleteAll();
            additionalTerm.SetRange("BLRDocument No.", Rec."BLRRenewal Proposal ID");
            if additionalTerm.FindSet() then
                repeat
                    TCAdditionalTerm.Init();
                    TCAdditionalTerm."BLRDocument No." := Rec."BLRContract ID";
                    TCAdditionalTerm."BLRDescription" := additionalTerm."BLRDescription";
                    TCAdditionalTerm.Insert();
                    Clear(TCAdditionalTerm);
                until additionalTerm.Next() = 0;
        end;
    end;

    procedure rentdatafetch()
    var
        CRSingleUnitRent: Record "BLRSingleUnitRentSubPage"; // Source table
        TCSingleUnitRent: Record "BLRTCSingleUnitRentSubPage"; // Target table

        TCLumpsumUnitRate: Record "BLRTCSingleLumAnnualAmntSP"; // Target table
        CRLumpsumUnitRent: Record "BLRSingleLumAnnualAmntSubPage"; // Source table

        //---Merge unit  same sq ft rate ---//
        TCMergeUnitRate: Record "BLRTCMergeSameSqureSubPage"; // Target table
        CRMergeUnitRent: Record "BLRMergeSameSqureSubPage"; // Source table

        //---Merge unit  diff sq ft rate ---//
        TCMergediffUnitRate: Record "BLRTCMergeDifferentSqSubPage"; // Target table
        CRMergediffUnitRent: Record "BLRMergeDifferentSqureSubPage"; // Source table

        //---Merge unit  lumpsum sq ft rate ---//
        TCMergeLumpsumUnitRate: Record "BLRTCMergeLumAnnualAmountSP"; // Target table
        CRMergeLumpsumUnitRent: Record "BLRMergeLumAnnualAmountSubPage"; // Source table

        TCPerDayRevenewUnitRate: Record "BLRTCPerDayRentforRevenue"; // Target table
        CRPerDayRevenewUnitRate: Record "BLRPerDayRentforRevenue"; // Source table

        LineNoCounter: Integer;
    begin

        if "BLRSingle Rent Calculation" = "BLRSingle Rent Calculation"::"Single Unit with square feet rate" then begin

            // Ã¢Å“â€¦ **Delete Existing Records Before Insert**
            TCSingleUnitRent.Reset();
            TCSingleUnitRent.SetRange("BLRID", "BLRProposal ID");

            if TCSingleUnitRent.FindSet() then
                TCSingleUnitRent.DeleteAll();

            // Ã¢Å“â€¦ **Fetch Data from Single Unit Rent SubPage where "BLRProposal ID" = "BLRProposal ID"**
            CRSingleUnitRent.Reset();
            CRSingleUnitRent.SetRange("BLRProposal ID", "BLRProposal ID"); // Correct condition

            if CRSingleUnitRent.FindSet() then begin
                LineNoCounter := 1; // Start line numbering from 1
                repeat
                    TCSingleUnitRent.Init();
                    TCSingleUnitRent."BLRID" := "BLRProposal ID"; // Ensure "BLRProposal ID" is stored in target ID field
                    TCSingleUnitRent."BLRContract Id" := Rec."BLRContract ID";
                    TCSingleUnitRent."BLRLine No." := LineNoCounter; // Ensure unique line number
                    TCSingleUnitRent."BLRUnit ID" := CRSingleUnitRent."BLRUnit ID";
                    TCSingleUnitRent."BLRYear" := CRSingleUnitRent."BLRYear";
                    TCSingleUnitRent."BLRStart Date" := CRSingleUnitRent."BLRStart Date";
                    TCSingleUnitRent."BLREnd Date" := CRSingleUnitRent."BLREnd Date";
                    TCSingleUnitRent."BLRNumber of Days" := CRSingleUnitRent."BLRNumber of Days";
                    TCSingleUnitRent."BLRUnit Sq Ft" := CRSingleUnitRent."BLRUnit Sq Ft";
                    TCSingleUnitRent."BLRRate per Sq.Ft" := CRSingleUnitRent."BLRRate per Sq.Ft";
                    TCSingleUnitRent."BLRRent Increase %" := CRSingleUnitRent."BLRRent Increase %";
                    TCSingleUnitRent."BLRAnnual Amount" := CRSingleUnitRent."BLRAnnual Amount";
                    TCSingleUnitRent."BLRRound off" := CRSingleUnitRent."BLRRound off";
                    TCSingleUnitRent."BLRFinal Annual Amount" := CRSingleUnitRent."BLRFinal Annual Amount";
                    TCSingleUnitRent."BLRPer Day Rent" := CRSingleUnitRent."BLRPer Day Rent";
                    TCSingleUnitRent.Insert();

                    LineNoCounter += 1; // Increment line number
                until CRSingleUnitRent.Next() = 0;
                // end else begin
                //     Message('No existing records found for "BLRProposal ID": %1 in Single Unit Rent SubPage.', "BLRProposal ID");
            end;
        end
        else
            if "BLRSingle Rent Calculation" = "BLRSingle Rent Calculation"::"Single Unit with lumpsum square feet rate" then begin

                // Ã¢Å“â€¦ Delete Existing Records Before Insert in TC Single LumAnnualAmnt SP
                TCLumpsumUnitRate.Reset();
                TCLumpsumUnitRate.SetRange("BLRID", "BLRProposal ID");
                if TCLumpsumUnitRate.FindSet() then
                    TCLumpsumUnitRate.DeleteAll();

                // Ã¢Å“â€¦ Fetch Data from CR Single LumAnnualAmnt SP and Insert into TC Single LumAnnualAmnt SP
                CRLumpsumUnitRent.Reset();
                CRLumpsumUnitRent.SetRange("BLRProposal ID", "BLRProposal ID");

                if CRLumpsumUnitRent.FindSet() then begin
                    LineNoCounter := 1; // Start line numbering from 1
                    repeat
                        TCLumpsumUnitRate.Init();

                        TCLumpsumUnitRate."BLRID" := CRLumpsumUnitRent."BLRProposal ID";
                        TCLumpsumUnitRate."BLRContract Id" := Rec."BLRContract ID";
                        TCLumpsumUnitRate."BLRSL_Line No." := LineNoCounter; // Ensure unique line number
                        TCLumpsumUnitRate."BLRSL_Unit ID" := CRLumpsumUnitRent."BLRSL_Unit ID";
                        TCLumpsumUnitRate."BLRSL_Year" := CRLumpsumUnitRent."BLRSL_Year";
                        TCLumpsumUnitRate."BLRSL_Start Date" := CRLumpsumUnitRent."BLRSL_Start Date";
                        TCLumpsumUnitRate."BLRSL_End Date" := CRLumpsumUnitRent."BLRSL_End Date";
                        TCLumpsumUnitRate."BLRSL_Number of Days" := CRLumpsumUnitRent."BLRSL_Number of Days";
                        TCLumpsumUnitRate."BLRSL_Unit Sq Ft" := CRLumpsumUnitRent."BLRSL_Unit Sq Ft";
                        TCLumpsumUnitRate."BLRSL_Rate per Sq.Ft" := CRLumpsumUnitRent."BLRSL_Rate per Sq.Ft";
                        TCLumpsumUnitRate."BLRSL_Rent Increase %" := CRLumpsumUnitRent."BLRSL_Rent Increase %";
                        TCLumpsumUnitRate."BLRSL_Annual Amount" := CRLumpsumUnitRent."BLRSL_Annual Amount";
                        TCLumpsumUnitRate."BLRSL_Round off" := CRLumpsumUnitRent."BLRSL_Round off";
                        TCLumpsumUnitRate."BLRSL_Final Annual Amount" := CRLumpsumUnitRent."BLRSL_Final Annual Amount";
                        TCLumpsumUnitRate."BLRSL_Per Day Rent" := CRLumpsumUnitRent."BLRSL_Per Day Rent";
                        TCLumpsumUnitRate."BLRTotalFinalAmount" := CRSingleUnitRent."BLRTotalFinalAmount";
                        TCLumpsumUnitRate."BLRTotalAnnualAmount" := CRSingleUnitRent."BLRTotalAnnualAmount";
                        TCLumpsumUnitRate."BLRTotalRoundOff" := CRSingleUnitRent."BLRTotalRoundOff";
                        TCLumpsumUnitRate."BLRTotalFirstAnnualAmount" := CRSingleUnitRent."BLRTotalFirstAnnualAmount";


                        TCLumpsumUnitRate.Insert();
                        LineNoCounter += 1; // Increment line number
                    until CRLumpsumUnitRent.Next() = 0;
                    // end else begin
                    //     Message('No existing records found for ID: %1 in CR Single LumAnnualAmnt SP.', "BLRProposal ID");
                end;
            end
            else
                if "BLRMerge Rent Calculation" = "BLRMerge Rent Calculation"::"Merged Unit with same square feet" then begin

                    // Ã¢Å“â€¦ **Delete Existing Records Before Insert**
                    TCMergeUnitRate.Reset();
                    TCMergeUnitRate.SetRange("BLRID", "BLRProposal ID");

                    if TCMergeUnitRate.FindSet() then
                        TCMergeUnitRate.DeleteAll();

                    // Ã¢Å“â€¦ **Fetch Data from CR Single Unit Rent SubPage and Insert into TC Single Unit Rent SubPage**
                    CRMergeUnitRent.Reset();
                    CRMergeUnitRent.SetRange("BLRProposal ID", "BLRProposal ID");

                    if CRMergeUnitRent.FindSet() then begin
                        LineNoCounter := 1; // Start line numbering from 1
                        repeat
                            TCMergeUnitRate.Init();
                            TCMergeUnitRate."BLRID" := CRMergeUnitRent."BLRProposal ID";
                            TCMergeUnitRate."BLRContract Id" := Rec."BLRContract ID";
                            TCMergeUnitRate."BLRMS_Line No." := LineNoCounter; // Ensure unique line number
                            TCMergeUnitRate."BLRMS_Merged Unit ID" := CRMergeUnitRent."BLRMS_Merged Unit ID";
                            TCMergeUnitRate."BLRMS_Year" := CRMergeUnitRent."BLRMS_Year";
                            TCMergeUnitRate."BLRMS_Start Date" := CRMergeUnitRent."BLRMS_Start Date";
                            TCMergeUnitRate."BLRMS_End Date" := CRMergeUnitRent."BLRMS_End Date";
                            TCMergeUnitRate."BLRMS_Number of Days" := CRMergeUnitRent."BLRMS_Number of Days";
                            TCMergeUnitRate."BLRMS_Unit Sq Ft" := CRMergeUnitRent."BLRMS_Unit Sq Ft";
                            TCMergeUnitRate."BLRMS_Rate per Sq.Ft" := CRMergeUnitRent."BLRMS_Rate per Sq.Ft";
                            TCMergeUnitRate."BLRMS_Rent Increase %" := CRMergeUnitRent."BLRMS_Rent Increase %";
                            TCMergeUnitRate."BLRMS_Annual Amount" := CRMergeUnitRent."BLRMS_Annual Amount";
                            TCMergeUnitRate."BLRMS_Round off" := CRMergeUnitRent."BLRMS_Round off";
                            TCMergeUnitRate."BLRMS_Final Annual Amount" := CRMergeUnitRent."BLRMS_Final Annual Amount";
                            TCMergeUnitRate."BLRMS_Per Day Rent" := CRMergeUnitRent."BLRMS_Per Day Rent";
                            TCMergeUnitRate."BLRTotalFinalAmount" := CRMergeUnitRent."BLRTotalFinalAmount";
                            TCMergeUnitRate."BLRTotalAnnualAmount" := CRMergeUnitRent."BLRTotalAnnualAmount";
                            TCMergeUnitRate."BLRTotalRoundOff" := CRMergeUnitRent."BLRTotalRoundOff";
                            TCMergeUnitRate."BLRTotalFirstAnnualAmount" := CRMergeUnitRent."BLRTotalFirstAnnualAmount";
                            TCMergeUnitRate.Insert();

                            LineNoCounter += 1; // Increment line number
                        until CRMergeUnitRent.Next() = 0;
                        // end else begin
                        //     Message('No existing records found for ID: %1 in CR Single Unit Rent SubPage.', "BLRProposal ID");
                    end;

                end
                else
                    if "BLRMerge Rent Calculation" = "BLRMerge Rent Calculation"::"Merged Unit with differential square feet rate" then begin

                        // Ã¢Å“â€¦ **Delete Existing Records Before Insert**
                        TCMergediffUnitRate.Reset();
                        TCMergediffUnitRate.SetRange("BLRID", "BLRProposal ID");

                        if TCMergediffUnitRate.FindSet() then
                            TCMergediffUnitRate.DeleteAll();

                        // Ã¢Å“â€¦ **Fetch Data from CR Merge Diff Unit Rent SubPage and Insert into TC Merge Diff Unit Rent SubPage**
                        CRMergediffUnitRent.Reset();
                        CRMergediffUnitRent.SetRange("BLRProposal ID", "BLRProposal ID");

                        if CRMergediffUnitRent.FindSet() then begin
                            LineNoCounter := 1; // Start line numbering from 1
                            repeat
                                // Before inserting, check if the record exists with the same "BLRProposal ID" and MD_Line No.
                                // TCMergediffUnitRate.Reset();
                                // TCMergediffUnitRate.SetRange("BLRID", CRMergediffUnitRent."BLRProposal ID");
                                // TCMergediffUnitRate.SetRange("BLRMD_Line No.", LineNoCounter);

                                // if TCMergediffUnitRate.FindFirst() then begin
                                //     // If a record exists with the same "BLRProposal ID" and MD_Line No., skip this record
                                //     Message('Record with the same "BLRProposal ID" and Line No. already exists for "BLRProposal ID": %1', CRMergediffUnitRent."BLRProposal ID");
                                // end else begin
                                // Proceed with inserting the new record
                                TCMergediffUnitRate.Init();
                                TCMergediffUnitRate."BLRID" := CRMergediffUnitRent."BLRProposal ID";
                                TCMergediffUnitRate."BLRContract Id" := Rec."BLRContract ID";
                                TCMergediffUnitRate."BLRMD_Line No." := LineNoCounter; // Ensure unique line number
                                TCMergediffUnitRate."BLRMD_Merged Unit ID" := CRMergediffUnitRent."BLRMD_Merged Unit ID";
                                TCMergediffUnitRate."BLRMD_Unit ID" := CRMergediffUnitRent."BLRMD_Unit ID";
                                TCMergediffUnitRate."BLRMD_Year" := CRMergediffUnitRent."BLRMD_Year";
                                TCMergediffUnitRate."BLRMD_Start Date" := CRMergediffUnitRent."BLRMD_Start Date";
                                TCMergediffUnitRate."BLRMD_End Date" := CRMergediffUnitRent."BLRMD_End Date";
                                TCMergediffUnitRate."BLRMD_Number of Days" := CRMergediffUnitRent."BLRMD_Number of Days";
                                TCMergediffUnitRate."BLRMD_Unit Sq Ft" := CRMergediffUnitRent."BLRMD_Unit Sq Ft";
                                TCMergediffUnitRate."BLRMD_Rate per Sq.Ft" := CRMergediffUnitRent."BLRMD_Rate per Sq.Ft";
                                TCMergediffUnitRate."BLRMD_Rent Increase %" := CRMergediffUnitRent."BLRMD_Rent Increase %";
                                TCMergediffUnitRate."BLRMD_Annual Amount" := CRMergediffUnitRent."BLRMD_Annual Amount";
                                TCMergediffUnitRate."BLRMD_Round off" := CRMergediffUnitRent."BLRMD_Round off";
                                TCMergediffUnitRate."BLRMD_Final Annual Amount" := CRMergediffUnitRent."BLRMD_Final Annual Amount";
                                TCMergediffUnitRate."BLRMD_Per Day Rent" := CRMergediffUnitRent."BLRMD_Per Day Rent";
                                TCMergediffUnitRate."BLRTotalFinalAmount" := CRMergediffUnitRent."BLRTotalFinalAmount";
                                TCMergediffUnitRate."BLRTotalAnnualAmount" := CRMergediffUnitRent."BLRTotalAnnualAmount";
                                TCMergediffUnitRate."BLRTotalRoundOff" := CRMergediffUnitRent."BLRTotalRoundOff";
                                TCMergediffUnitRate."BLRTotalFirstAnnualAmount" := CRMergediffUnitRent."BLRTotalFirstAnnualAmount";

                                // Insert the new record
                                TCMergediffUnitRate.Insert();
                                // end;

                                LineNoCounter += 1; // Increment line number for next record
                            until CRMergediffUnitRent.Next() = 0;
                            // end else begin
                            //     Message('No existing records found for "BLRProposal ID": %1 in CR Merge Diff Unit Rent SubPage.', "BLRProposal ID");
                        end;
                    end

                    else
                        if "BLRMerge Rent Calculation" = "BLRMerge Rent Calculation"::"Merged Unit with lumpsum annual amount" then begin

                            // Ã¢Å“â€¦ **Delete Existing Records Before Insert**
                            TCMergeLumpsumUnitRate.Reset();
                            TCMergeLumpsumUnitRate.SetRange("BLRID", "BLRProposal ID");

                            if TCMergeLumpsumUnitRate.FindSet() then
                                TCMergeLumpsumUnitRate.DeleteAll();

                            // Ã¢Å“â€¦ **Fetch Data from CR Single Unit Rent SubPage and Insert into TC Single Unit Rent SubPage**
                            CRMergeLumpsumUnitRent.Reset();
                            CRMergeLumpsumUnitRent.SetRange("BLRProposal ID", "BLRProposal ID");

                            if CRMergeLumpsumUnitRent.FindSet() then begin
                                LineNoCounter := 1; // Start line numbering from 1
                                repeat
                                    TCMergeLumpsumUnitRate.Init();
                                    TCMergeLumpsumUnitRate."BLRID" := CRMergeLumpsumUnitRent."BLRProposal ID";
                                    TCMergeLumpsumUnitRate."BLRContract Id" := Rec."BLRContract ID";
                                    TCMergeLumpsumUnitRate."BLRML_Line No." := LineNoCounter; // Ensure unique line number
                                    TCMergeLumpsumUnitRate."BLRML_Merged Unit ID" := CRMergeLumpsumUnitRent."BLRML_Merged Unit ID";
                                    TCMergeLumpsumUnitRate."BLRML_Year" := CRMergeLumpsumUnitRent."BLRML_Year";
                                    TCMergeLumpsumUnitRate."BLRML_Start Date" := CRMergeLumpsumUnitRent."BLRML_Start Date";
                                    TCMergeLumpsumUnitRate."BLRML_End Date" := CRMergeLumpsumUnitRent."BLRML_End Date";
                                    TCMergeLumpsumUnitRate."BLRML_Number of Days" := CRMergeLumpsumUnitRent."BLRML_Number of Days";
                                    TCMergeLumpsumUnitRate."BLRML_Unit Sq Ft" := CRMergeLumpsumUnitRent."BLRML_Unit Sq Ft";
                                    TCMergeLumpsumUnitRate."BLRML_Rate per Sq.Ft" := CRMergeLumpsumUnitRent."BLRML_Rate per Sq.Ft";
                                    TCMergeLumpsumUnitRate."BLRML_Rent Increase %" := CRMergeLumpsumUnitRent."BLRML_Rent Increase %";
                                    TCMergeLumpsumUnitRate."BLRML_Annual Amount" := CRMergeLumpsumUnitRent."BLRML_Annual Amount";
                                    TCMergeLumpsumUnitRate."BLRML_Round off" := CRMergeLumpsumUnitRent."BLRML_Round off";
                                    TCMergeLumpsumUnitRate."BLRML_Final Annual Amount" := CRMergeLumpsumUnitRent."BLRML_Final Annual Amount";
                                    TCMergeLumpsumUnitRate."BLRML_Per Day Rent" := CRMergeLumpsumUnitRent."BLRML_Per Day Rent";
                                    TCMergeLumpsumUnitRate."BLRTotalFinalAmount" := CRMergeLumpsumUnitRent."BLRTotalFinalAmount";
                                    TCMergeLumpsumUnitRate."BLRTotalAnnualAmount" := CRMergeLumpsumUnitRent."BLRTotalAnnualAmount";
                                    TCMergeLumpsumUnitRate."BLRTotalRoundOff" := CRMergeLumpsumUnitRent."BLRTotalRoundOff";
                                    TCMergeLumpsumUnitRate."BLRTotalFirstAnnualAmount" := CRMergeLumpsumUnitRent."BLRTotalFirstAnnualAmount";
                                    TCMergeLumpsumUnitRate.Insert();

                                    LineNoCounter += 1; // Increment line number
                                until CRMergeLumpsumUnitRent.Next() = 0;
                                // end else begin
                                //     Message('No existing records found for ID: %1 in CR Single Unit Rent SubPage.', "BLRProposal ID");
                            end;

                        end;

        // Ã¢Å“â€¦ **Delete Existing Records Before Insert (TC Per Day Rent for Revenue)**
        TCPerDayRevenewUnitRate.Reset();
        TCPerDayRevenewUnitRate.SetRange("BLRProposal Id", "BLRProposal ID");

        if TCPerDayRevenewUnitRate.FindSet() then
            TCPerDayRevenewUnitRate.DeleteAll();

        // Ã¢Å“â€¦ **Fetch Data from CR Per Day Rent for Revenue and Insert into TC Per Day Rent for Revenue**
        CRPerDayRevenewUnitRate.Reset();
        CRPerDayRevenewUnitRate.SetRange("BLRProposal Id", "BLRProposal ID");

        if CRPerDayRevenewUnitRate.FindSet() then begin
            LineNoCounter := 1; // Reset line numbering for Per Day Rent
            repeat
                TCPerDayRevenewUnitRate.Init();

                // Ã¢Å“â€¦ Assign a unique primary key if ID is part of the primary key
                TCPerDayRevenewUnitRate."BLRProposal Id" := CRPerDayRevenewUnitRate."BLRProposal Id";
                TCPerDayRevenewUnitRate."BLRMerge Unit Id" := CRPerDayRevenewUnitRate."BLRMerge Unit Id";
                TCPerDayRevenewUnitRate."BLRYear" := CRPerDayRevenewUnitRate."BLRYear";
                TCPerDayRevenewUnitRate."BLRUnit ID" := CRPerDayRevenewUnitRate."BLRUnit ID";
                TCPerDayRevenewUnitRate."BLRSq.Ft" := CRPerDayRevenewUnitRate."BLRSq.Ft";
                TCPerDayRevenewUnitRate."BLRPer Day Rent Per Unit" := CRPerDayRevenewUnitRate."BLRPer Day Rent Per Unit";

                TCPerDayRevenewUnitRate.Insert();
                Clear(TCPerDayRevenewUnitRate);
                LineNoCounter += 1; // Increment line number
            until CRPerDayRevenewUnitRate.Next() = 0;
        end;

    end;

    procedure rentdatafetched()
    var
        //---single unit same sq ft rate ---//
        CRSingleUnitRent: Record "BLRCRSingleUnitRentSubPage"; // Source table
        TCSingleUnitRent: Record "BLRTCSingleUnitRentSubPage"; // Target table

        //---single unit lumpsum sq ft rate ---//
        TCLumpsumUnitRate: Record "BLRTCSingleLumAnnualAmntSP"; // Target table
        CRLumpsumUnitRent: Record "BLRCRSingleLumAnnualAmntSP"; // Source table

        //---Merge unit  same sq ft rate ---//
        TCMergeUnitRate: Record "BLRTCMergeSameSqureSubPage"; // Target table
        CRMergeUnitRent: Record "BLRCRMergeSameSqureSubPage"; // Source table

        //---Merge unit  diff sq ft rate ---//
        TCMergediffUnitRate: Record "BLRTCMergeDifferentSqSubPage"; // Target table
        CRMergediffUnitRent: Record "BLRCRMergeDifferentSqSubPage"; // Source table

        //---Merge unit  lumpsum sq ft rate ---//
        TCMergeLumpsumUnitRate: Record "BLRTCMergeLumAnnualAmountSP"; // Target table
        CRMergeLumpsumUnitRent: Record "BLRCRMergeLumAnnualAmountSP"; // Source table
        TCPerDayRevenewUnitRate: Record "BLRTCPerDayRentforRevenue"; // Target table
        CRPerDayRevenewUnitRate: Record "BLRCRPerDayRentforRevenue"; // Source table

        LineNoCounter: Integer;
    begin


        if "BLRSingle Rent Calculation" = "BLRSingle Rent Calculation"::"Single Unit with square feet rate" then begin

            // Ã¢Å“â€¦ **Delete Existing Records Before Insert**
            TCSingleUnitRent.Reset();
            TCSingleUnitRent.SetRange("BLRID", "BLRRenewal Proposal ID");

            if TCSingleUnitRent.FindSet() then
                TCSingleUnitRent.DeleteAll();

            // Ã¢Å“â€¦ **Fetch Data from CR Single Unit Rent SubPage and Insert into TC Single Unit Rent SubPage**
            CRSingleUnitRent.Reset();
            CRSingleUnitRent.SetRange("BLRID", "BLRRenewal Proposal ID");

            if CRSingleUnitRent.FindSet() then begin
                LineNoCounter := 1; // Start line numbering from 1
                repeat
                    TCSingleUnitRent.Init();
                    TCSingleUnitRent."BLRID" := CRSingleUnitRent."BLRID";
                    TCSingleUnitRent."BLRContract Id" := Rec."BLRContract ID";
                    TCSingleUnitRent."BLRLine No." := LineNoCounter; // Ensure unique line number
                    TCSingleUnitRent."BLRUnit ID" := CRSingleUnitRent."BLRUnit ID";
                    TCSingleUnitRent."BLRYear" := CRSingleUnitRent."BLRYear";
                    TCSingleUnitRent."BLRStart Date" := CRSingleUnitRent."BLRStart Date";
                    TCSingleUnitRent."BLREnd Date" := CRSingleUnitRent."BLREnd Date";
                    TCSingleUnitRent."BLRNumber of Days" := CRSingleUnitRent."BLRNumber of Days";
                    TCSingleUnitRent."BLRUnit Sq Ft" := CRSingleUnitRent."BLRUnit Sq Ft";
                    TCSingleUnitRent."BLRRate per Sq.Ft" := CRSingleUnitRent."BLRRate per Sq.Ft";
                    TCSingleUnitRent."BLRRent Increase %" := CRSingleUnitRent."BLRRent Increase %";
                    TCSingleUnitRent."BLRAnnual Amount" := CRSingleUnitRent."BLRAnnual Amount";
                    TCSingleUnitRent."BLRRound off" := CRSingleUnitRent."BLRRound off";
                    TCSingleUnitRent."BLRFinal Annual Amount" := CRSingleUnitRent."BLRFinal Annual Amount";
                    TCSingleUnitRent."BLRPer Day Rent" := CRSingleUnitRent."BLRPer Day Rent";
                    TCSingleUnitRent."BLRTotalFinalAmount" := CRSingleUnitRent."BLRTotalFinalAmount";
                    TCSingleUnitRent."BLRTotalAnnualAmount" := CRSingleUnitRent."BLRTotalAnnualAmount";
                    TCSingleUnitRent."BLRTotalRoundOff" := CRSingleUnitRent."BLRTotalRoundOff";
                    TCSingleUnitRent."BLRTotalFirstAnnualAmount" := CRSingleUnitRent."BLRTotalFirstAnnualAmount";
                    TCSingleUnitRent.Insert();


                    LineNoCounter += 1; // Increment line number
                until CRSingleUnitRent.Next() = 0;
                // end else begin
                //     Message('No existing records found for ID: %1 in CR Single Unit Rent SubPage.', "BLRRenewal Proposal ID");
            end;

        end

        else
            if "BLRSingle Rent Calculation" = "BLRSingle Rent Calculation"::"Single Unit with lumpsum square feet rate" then begin
                // Ã¢Å“â€¦ Delete Existing Records Before Insert in TC Single LumAnnualAmnt SP
                TCLumpsumUnitRate.Reset();
                TCLumpsumUnitRate.SetRange("BLRID", "BLRRenewal Proposal ID");
                if TCLumpsumUnitRate.FindSet() then
                    TCLumpsumUnitRate.DeleteAll();

                // Ã¢Å“â€¦ Fetch Data from CR Single LumAnnualAmnt SP and Insert into TC Single LumAnnualAmnt SP
                CRLumpsumUnitRent.Reset();
                CRLumpsumUnitRent.SetRange("BLRID", "BLRRenewal Proposal ID");

                if CRLumpsumUnitRent.FindSet() then begin
                    LineNoCounter := 1; // Start line numbering from 1
                    repeat
                        TCLumpsumUnitRate.Init();

                        TCLumpsumUnitRate."BLRID" := CRLumpsumUnitRent."BLRID";
                        TCLumpsumUnitRate."BLRContract Id" := Rec."BLRContract ID";
                        TCLumpsumUnitRate."BLRSL_Line No." := LineNoCounter; // Ensure unique line number
                        TCLumpsumUnitRate."BLRSL_Unit ID" := CRLumpsumUnitRent."BLRSL_Unit ID";
                        TCLumpsumUnitRate."BLRSL_Year" := CRLumpsumUnitRent."BLRSL_Year";
                        TCLumpsumUnitRate."BLRSL_Start Date" := CRLumpsumUnitRent."BLRSL_Start Date";
                        TCLumpsumUnitRate."BLRSL_End Date" := CRLumpsumUnitRent."BLRSL_End Date";
                        TCLumpsumUnitRate."BLRSL_Number of Days" := CRLumpsumUnitRent."BLRSL_Number of Days";
                        TCLumpsumUnitRate."BLRSL_Unit Sq Ft" := CRLumpsumUnitRent."BLRSL_Unit Sq Ft";
                        TCLumpsumUnitRate."BLRSL_Rate per Sq.Ft" := CRLumpsumUnitRent."BLRSL_Rate per Sq.Ft";
                        TCLumpsumUnitRate."BLRSL_Rent Increase %" := CRLumpsumUnitRent."BLRSL_Rent Increase %";
                        TCLumpsumUnitRate."BLRSL_Annual Amount" := CRLumpsumUnitRent."BLRSL_Annual Amount";
                        TCLumpsumUnitRate."BLRSL_Round off" := CRLumpsumUnitRent."BLRSL_Round off";
                        TCLumpsumUnitRate."BLRSL_Final Annual Amount" := CRLumpsumUnitRent."BLRSL_Final Annual Amount";
                        TCLumpsumUnitRate."BLRSL_Per Day Rent" := CRLumpsumUnitRent."BLRSL_Per Day Rent";
                        TCLumpsumUnitRate."BLRTotalFinalAmount" := CRSingleUnitRent."BLRTotalFinalAmount";
                        TCLumpsumUnitRate."BLRTotalAnnualAmount" := CRSingleUnitRent."BLRTotalAnnualAmount";
                        TCLumpsumUnitRate."BLRTotalRoundOff" := CRSingleUnitRent."BLRTotalRoundOff";
                        TCLumpsumUnitRate."BLRTotalFirstAnnualAmount" := CRSingleUnitRent."BLRTotalFirstAnnualAmount";


                        TCLumpsumUnitRate.Insert();

                        LineNoCounter += 1; // Increment line number
                    until CRLumpsumUnitRent.Next() = 0;
                    // end else begin
                    //     Message('No existing records found for ID: %1 in CR Single LumAnnualAmnt SP.', "BLRRenewal Proposal ID");
                end;
            end

            else
                if "BLRMerge Rent Calculation" = "BLRMerge Rent Calculation"::"Merged Unit with same square feet" then begin

                    // Ã¢Å“â€¦ **Delete Existing Records Before Insert**
                    TCMergeUnitRate.Reset();
                    TCMergeUnitRate.SetRange("BLRID", "BLRRenewal Proposal ID");

                    if TCMergeUnitRate.FindSet() then
                        TCMergeUnitRate.DeleteAll();

                    // Ã¢Å“â€¦ **Fetch Data from CR Single Unit Rent SubPage and Insert into TC Single Unit Rent SubPage**
                    CRMergeUnitRent.Reset();
                    CRMergeUnitRent.SetRange("BLRID", "BLRRenewal Proposal ID");

                    if CRMergeUnitRent.FindSet() then begin
                        LineNoCounter := 1; // Start line numbering from 1
                        repeat
                            TCMergeUnitRate.Init();
                            TCMergeUnitRate."BLRID" := CRMergeUnitRent."BLRID";
                            TCMergeUnitRate."BLRContract Id" := Rec."BLRContract ID";
                            TCMergeUnitRate."BLRMS_Line No." := LineNoCounter; // Ensure unique line number
                            TCMergeUnitRate."BLRMS_Merged Unit ID" := CRMergeUnitRent."BLRMS_Merged Unit ID";
                            TCMergeUnitRate."BLRMS_Year" := CRMergeUnitRent."BLRMS_Year";
                            TCMergeUnitRate."BLRMS_Start Date" := CRMergeUnitRent."BLRMS_Start Date";
                            TCMergeUnitRate."BLRMS_End Date" := CRMergeUnitRent."BLRMS_End Date";
                            TCMergeUnitRate."BLRMS_Number of Days" := CRMergeUnitRent."BLRMS_Number of Days";
                            TCMergeUnitRate."BLRMS_Unit Sq Ft" := CRMergeUnitRent."BLRMS_Unit Sq Ft";
                            TCMergeUnitRate."BLRMS_Rate per Sq.Ft" := CRMergeUnitRent."BLRMS_Rate per Sq.Ft";
                            TCMergeUnitRate."BLRMS_Rent Increase %" := CRMergeUnitRent."BLRMS_Rent Increase %";
                            TCMergeUnitRate."BLRMS_Annual Amount" := CRMergeUnitRent."BLRMS_Annual Amount";
                            TCMergeUnitRate."BLRMS_Round off" := CRMergeUnitRent."BLRMS_Round off";
                            TCMergeUnitRate."BLRMS_Final Annual Amount" := CRMergeUnitRent."BLRMS_Final Annual Amount";
                            TCMergeUnitRate."BLRMS_Per Day Rent" := CRMergeUnitRent."BLRMS_Per Day Rent";
                            TCMergeUnitRate."BLRTotalFinalAmount" := CRMergeUnitRent."BLRTotalFinalAmount";
                            TCMergeUnitRate."BLRTotalAnnualAmount" := CRMergeUnitRent."BLRTotalAnnualAmount";
                            TCMergeUnitRate."BLRTotalRoundOff" := CRMergeUnitRent."BLRTotalRoundOff";
                            TCMergeUnitRate."BLRTotalFirstAnnualAmount" := CRMergeUnitRent."BLRTotalFirstAnnualAmount";
                            TCMergeUnitRate.Insert();


                            LineNoCounter += 1; // Increment line number
                        until CRMergeUnitRent.Next() = 0;
                        // end else begin
                        //     Message('No existing records found for ID: %1 in CR Single Unit Rent SubPage.', "BLRRenewal Proposal ID");
                    end;

                end
                else
                    if "BLRMerge Rent Calculation" = "BLRMerge Rent Calculation"::"Merged Unit with differential square feet rate" then begin

                        // Ã¢Å“â€¦ **Delete Existing Records Before Insert**
                        TCMergediffUnitRate.Reset();
                        TCMergediffUnitRate.SetRange("BLRID", "BLRRenewal Proposal ID");

                        if TCMergediffUnitRate.FindSet() then
                            TCMergediffUnitRate.DeleteAll();

                        // Ã¢Å“â€¦ **Fetch Data from CR Merge Diff Unit Rent SubPage and Insert into TC Merge Diff Unit Rent SubPage**
                        CRMergediffUnitRent.Reset();
                        CRMergediffUnitRent.SetRange("BLRID", "BLRRenewal Proposal ID");

                        if CRMergediffUnitRent.FindSet() then begin
                            LineNoCounter := 1; // Start line numbering from 1
                            repeat
                                TCMergediffUnitRate.Init();
                                TCMergediffUnitRate."BLRID" := CRMergediffUnitRent."BLRID";
                                TCMergediffUnitRate."BLRContract Id" := Rec."BLRContract ID";
                                TCMergediffUnitRate."BLRMD_Line No." := LineNoCounter; // Ensure unique line number
                                TCMergediffUnitRate."BLRMD_Merged Unit ID" := CRMergediffUnitRent."BLRMD_Merged Unit ID";
                                TCMergediffUnitRate."BLRMD_Year" := CRMergediffUnitRent."BLRMD_Year";
                                TCMergediffUnitRate."BLRMD_Start Date" := CRMergediffUnitRent."BLRMD_Start Date";
                                TCMergediffUnitRate."BLRMD_End Date" := CRMergediffUnitRent."BLRMD_End Date";
                                TCMergediffUnitRate."BLRMD_Number of Days" := CRMergediffUnitRent."BLRMD_Number of Days";
                                TCMergediffUnitRate."BLRMD_Unit Sq Ft" := CRMergediffUnitRent."BLRMD_Unit Sq Ft";
                                TCMergediffUnitRate."BLRMD_Rate per Sq.Ft" := CRMergediffUnitRent."BLRMD_Rate per Sq.Ft";
                                TCMergediffUnitRate."BLRMD_Rent Increase %" := CRMergediffUnitRent."BLRMD_Rent Increase %";
                                TCMergediffUnitRate."BLRMD_Annual Amount" := CRMergediffUnitRent."BLRMD_Annual Amount";
                                TCMergediffUnitRate."BLRMD_Round off" := CRMergediffUnitRent."BLRMD_Round off";
                                TCMergediffUnitRate."BLRMD_Final Annual Amount" := CRMergediffUnitRent."BLRMD_Final Annual Amount";
                                TCMergediffUnitRate."BLRMD_Per Day Rent" := CRMergediffUnitRent."BLRMD_Per Day Rent";
                                TCMergediffUnitRate."BLRTotalFinalAmount" := CRMergediffUnitRent."BLRTotalFinalAmount";
                                TCMergediffUnitRate."BLRTotalAnnualAmount" := CRMergediffUnitRent."BLRTotalAnnualAmount";
                                TCMergediffUnitRate."BLRTotalRoundOff" := CRMergediffUnitRent."BLRTotalRoundOff";
                                TCMergediffUnitRate."BLRTotalFirstAnnualAmount" := CRMergediffUnitRent."BLRTotalFirstAnnualAmount";

                                // Insert the new record
                                TCMergediffUnitRate.Insert();

                                // end;

                                LineNoCounter += 1; // Increment line number for next record
                            until CRMergediffUnitRent.Next() = 0;
                        end;
                    end
                    else
                        if "BLRMerge Rent Calculation" = "BLRMerge Rent Calculation"::"Merged Unit with lumpsum annual amount" then begin

                            // Ã¢Å“â€¦ **Delete Existing Records Before Insert**
                            TCMergeLumpsumUnitRate.Reset();
                            TCMergeLumpsumUnitRate.SetRange("BLRID", "BLRRenewal Proposal ID");

                            if TCMergeLumpsumUnitRate.FindSet() then
                                TCMergeLumpsumUnitRate.DeleteAll();

                            // Ã¢Å“â€¦ **Fetch Data from CR Single Unit Rent SubPage and Insert into TC Single Unit Rent SubPage**
                            CRMergeLumpsumUnitRent.Reset();
                            CRMergeLumpsumUnitRent.SetRange("BLRID", "BLRRenewal Proposal ID");

                            if CRMergeLumpsumUnitRent.FindSet() then begin
                                LineNoCounter := 1; // Start line numbering from 1
                                repeat
                                    TCMergeLumpsumUnitRate.Init();
                                    TCMergeLumpsumUnitRate."BLRID" := CRMergeLumpsumUnitRent."BLRID";
                                    TCMergeLumpsumUnitRate."BLRContract Id" := Rec."BLRContract ID";
                                    TCMergeLumpsumUnitRate."BLRML_Line No." := LineNoCounter; // Ensure unique line number
                                    TCMergeLumpsumUnitRate."BLRML_Merged Unit ID" := CRMergeLumpsumUnitRent."BLRML_Merged Unit ID";
                                    TCMergeLumpsumUnitRate."BLRML_Year" := CRMergeLumpsumUnitRent."BLRML_Year";
                                    TCMergeLumpsumUnitRate."BLRML_Start Date" := CRMergeLumpsumUnitRent."BLRML_Start Date";
                                    TCMergeLumpsumUnitRate."BLRML_End Date" := CRMergeLumpsumUnitRent."BLRML_End Date";
                                    TCMergeLumpsumUnitRate."BLRML_Number of Days" := CRMergeLumpsumUnitRent."BLRML_Number of Days";
                                    TCMergeLumpsumUnitRate."BLRML_Unit Sq Ft" := CRMergeLumpsumUnitRent."BLRML_Unit Sq Ft";
                                    TCMergeLumpsumUnitRate."BLRML_Rate per Sq.Ft" := CRMergeLumpsumUnitRent."BLRML_Rate per Sq.Ft";
                                    TCMergeLumpsumUnitRate."BLRML_Rent Increase %" := CRMergeLumpsumUnitRent."BLRML_Rent Increase %";
                                    TCMergeLumpsumUnitRate."BLRML_Annual Amount" := CRMergeLumpsumUnitRent."BLRML_Annual Amount";
                                    TCMergeLumpsumUnitRate."BLRML_Round off" := CRMergeLumpsumUnitRent."BLRML_Round off";
                                    TCMergeLumpsumUnitRate."BLRML_Final Annual Amount" := CRMergeLumpsumUnitRent."BLRML_Final Annual Amount";
                                    TCMergeLumpsumUnitRate."BLRML_Per Day Rent" := CRMergeLumpsumUnitRent."BLRML_Per Day Rent";
                                    TCMergeLumpsumUnitRate."BLRTotalFinalAmount" := CRMergeLumpsumUnitRent."BLRTotalFinalAmount";
                                    TCMergeLumpsumUnitRate."BLRTotalAnnualAmount" := CRMergeLumpsumUnitRent."BLRTotalAnnualAmount";
                                    TCMergeLumpsumUnitRate."BLRTotalRoundOff" := CRMergeLumpsumUnitRent."BLRTotalRoundOff";
                                    TCMergeLumpsumUnitRate."BLRTotalFirstAnnualAmount" := CRMergeLumpsumUnitRent."BLRTotalFirstAnnualAmount";
                                    TCMergeLumpsumUnitRate.Insert();

                                    // end;

                                    LineNoCounter += 1; // Increment line number
                                until CRMergeLumpsumUnitRent.Next() = 0;
                                // end else begin
                                //     Message('No existing records found for ID: %1 in CR Single Unit Rent SubPage.', "BLRRenewal Proposal ID");
                            end;

                        end;


        TCPerDayRevenewUnitRate.Reset();
        TCPerDayRevenewUnitRate.SetRange("BLRContract Renewal Id", "BLRRenewal Proposal ID");


        if TCPerDayRevenewUnitRate.FindSet() then
            TCPerDayRevenewUnitRate.DeleteAll();


        // Ã¢Å“â€¦ **Fetch Data from CR Per Day Rent for Revenue and Insert into TC Per Day Rent for Revenue**
        CRPerDayRevenewUnitRate.Reset();
        CRPerDayRevenewUnitRate.SetRange("BLRContract Renewal Id", "BLRRenewal Proposal ID");

        if CRPerDayRevenewUnitRate.FindSet() then begin
            LineNoCounter := 1; // Reset line numbering for Per Day Rent
            repeat
                TCPerDayRevenewUnitRate.Init();

                // Ã¢Å“â€¦ Assign a unique primary key if ID is part of the primary key
                TCPerDayRevenewUnitRate."BLRContract Renewal Id" := CRPerDayRevenewUnitRate."BLRContract Renewal Id";
                TCPerDayRevenewUnitRate."BLRMerge Unit Id" := CRPerDayRevenewUnitRate."BLRMerge Unit Id";
                TCPerDayRevenewUnitRate."BLRYear" := CRPerDayRevenewUnitRate."BLRYear";
                TCPerDayRevenewUnitRate."BLRUnit ID" := CRPerDayRevenewUnitRate."BLRUnit ID";
                TCPerDayRevenewUnitRate."BLRSq.Ft" := CRPerDayRevenewUnitRate."BLRSq.Ft";
                TCPerDayRevenewUnitRate."BLRPer Day Rent Per Unit" := CRPerDayRevenewUnitRate."BLRPer Day Rent Per Unit";

                // Ã¢Å“â€¦ Ensure unique Line No. to avoid duplicates
                // TCPerDayRevenewUnitRate."BLRLine No." := LineNoCounter;

                TCPerDayRevenewUnitRate.Insert();
                Clear(TCPerDayRevenewUnitRate);
                LineNoCounter += 1; // Increment line number
            until CRPerDayRevenewUnitRate.Next() = 0;
        end;
    end;

    trigger OnInsert()
    begin
        "BLRCreated By" := CopyStr(UserId, 1, StrLen("BLRCreated By"));
    end;

    procedure CalculateGracePeriod()
    var
        StartDate, EndDate : Date;
        DaysBetween: Integer;
    begin
        StartDate := "BLRGrace Start Date";
        EndDate := "BLRGrace End Date";

        if (StartDate <> 0D) and (EndDate <> 0D) then begin
            if EndDate >= StartDate then
                DaysBetween := EndDate - StartDate
            else
                DaysBetween := 0;

            "BLRGrace Period" := DaysBetween;
        end else
            "BLRGrace Period" := 0; // Clear if either date is not set
    end;

    trigger OnDelete()
    begin
        Deletegriddata();
        DeleteAdditionalTerms();

    end;

    procedure Deletegriddata()
    var
        otherpayments: Record "BLRTenancyContractSubpage";
    begin
        otherpayments.SetRange("BLRContractID", Rec."BLRContract ID");
        if otherpayments.FindSet()
        then
            otherpayments.DeleteAll();
    end;

    procedure DeleteAdditionalTerms()
    var
        AdditionalTerms: Record "BLRTCAdditionalTerms";
    begin
        AdditionalTerms.SetRange("BLRDocument No.", Rec."BLRContract ID");

        if AdditionalTerms.FindSet() then
            AdditionalTerms.DeleteAll();
    end;

    procedure brokerdata()
    var
        leaseproposal: Record "BLRLeaseProposalDetails";
    begin
        leaseproposal.SetRange("BLRProposal ID", Rec."BLRProposal ID");

        if leaseproposal.FindFirst() then begin
            // Exit if "BLRVendor ID" is blank (i.e., not available)
            if leaseproposal."BLRVendor ID" = '' then
                exit;

            // Fill fields from Lease Proposal
            Rec."BLRVendor ID" := leaseproposal."BLRVendor ID";
            Rec."BLRVendor Name" := leaseproposal."BLRVendor Name";
            Rec."BLRStart Date" := leaseproposal."BLRStart Date";
            Rec."BLREnd Date" := leaseproposal."BLREnd Date";
            Rec."BLRContract Status" := leaseproposal."BLRContract Status";
            Rec."BLRCalculation Method" := leaseproposal."BLRCalculation Method";
            Rec."BLRPercentage Type" := leaseproposal."BLRPercentage Type";
            Rec."BLRPercentage" := leaseproposal."BLRPercentage";
            Rec."BLRAmount" := leaseproposal."BLRAmount";
            Rec."BLRBase Amount Type" := leaseproposal."BLRBase Amount Type";
            Rec."BLRFrequency Of Payment" := leaseproposal."BLRFrequency Of Payment";
            Rec.Modify();
            ManagementFeeMasterDetailsFetch();
        end;
    end;



    procedure renewalbrokerdata()
    var
        contractrenewal: Record "BLRContractRenewal";
    begin
        contractrenewal.SetRange("BLRID", Rec."BLRRenewal Proposal ID");

        if contractrenewal.FindFirst() then begin
            // Exit if "BLRVendor ID" is blank (i.e., not available)
            if contractrenewal."BLRVendor ID" = '' then
                exit;

            Rec."BLRVendor ID" := contractrenewal."BLRVendor ID";
            Rec."BLRVendor Name" := contractrenewal."BLRVendor Name";
            Rec."BLRStart Date" := contractrenewal."BLRStart Date";
            Rec."BLREnd Date" := contractrenewal."BLREnd Date";
            Rec."BLRContract Status" := contractrenewal."BLRContract Status";
            Rec."BLRCalculation Method" := contractrenewal."BLRCalculation Method";
            Rec."BLRPercentage Type" := contractrenewal."BLRPercentage Type";
            Rec."BLRPercentage" := contractrenewal."BLRPercentage";
            Rec."BLRAmount" := contractrenewal."BLRAmount";
            Rec."BLRBase Amount Type" := contractrenewal."BLRBase Amount Type";
            Rec."BLRFrequency Of Payment" := contractrenewal."BLRFrequency Of Payment";
            Rec.Modify();
            ManagementFeeMasterDetailsFetchRenewal();
        end;
    end;


    procedure ManagementFeeMasterDetailsFetch()
    var
        managementfee: Record "BLRBrokerageMasterData";
        contractLine: Record "BLRTenancyContract";
    begin
        // Filter contractLine using "BLRProposal ID" or other unique identifiers
        contractLine.SetRange("BLRProposal ID", Rec."BLRProposal ID"); // Add this line or use appropriate filters

        if not contractLine.FindFirst() then
            exit;

        if contractLine."BLRVendor ID" = '' then
            exit;

        managementfee.Reset();
        managementfee.SetRange("BLRVendor ID", contractLine."BLRVendor ID");
        managementfee.SetRange("BLRContract ID", contractLine."BLRContract ID");

        if managementfee.FindFirst() then begin
            // Modify existing
            managementfee."BLRVendor ID" := contractLine."BLRVendor ID";
            managementfee."BLRContract ID" := contractLine."BLRContract ID";
            managementfee."BLRProposal ID" := contractLine."BLRProposal ID";
            managementfee."BLRUnit Name" := contractLine."BLRUnit Name";
            managementfee."BLRUnit Number" := contractLine."BLRUnit Number";
            managementfee."BLRVendor Name" := contractLine."BLRVendor Name";
            managementfee."BLRProperty ID" := contractLine."BLRProperty ID";
            managementfee."BLRProperty Name" := contractLine."BLRProperty Name";
            managementfee."BLRStart Date" := contractLine."BLRStart Date";
            managementfee."BLREnd Date" := contractLine."BLREnd Date";
            managementfee."BLRProperty Type" := contractLine."BLRProperty Classification";
            managementfee."BLRContract Status" := contractLine."BLRContract Status";
            managementfee."BLRCalculation Method" := contractLine."BLRCalculation Method";
            managementfee."BLRPercentage Type" := contractLine."BLRPercentage Type";
            managementfee."BLRBase Amount Type" := contractLine."BLRBase Amount Type";
            managementfee."BLRFrequency Of Payment" := contractLine."BLRFrequency Of Payment";
            managementfee."BLRAmount" := contractLine."BLRAmount";
            managementfee."BLRBase Amount" := contractLine."BLRRent Amount";
            managementfee."BLRPercentage" := contractLine."BLRPercentage";
            managementfee."BLROwner ID" := contractLine."BLROwner ID";
            managementfee."BLROwner Name" := contractLine."BLROwner's Name";
            managementfee."BLRTenant Name" := contractLine."BLRCustomer Name";
            managementfee.Modify();
        end else begin
            // Insert new
            managementfee.Init();
            managementfee."BLRVendor ID" := contractLine."BLRVendor ID";
            managementfee."BLRContract ID" := contractLine."BLRContract ID";
            managementfee."BLRProposal ID" := contractLine."BLRProposal ID";
            managementfee."BLRUnit Name" := contractLine."BLRUnit Name";
            managementfee."BLRUnit Number" := contractLine."BLRUnit Number";
            managementfee."BLRVendor Name" := contractLine."BLRVendor Name";
            managementfee."BLRProperty ID" := contractLine."BLRProperty ID";
            managementfee."BLRProperty Name" := contractLine."BLRProperty Name";
            managementfee."BLRStart Date" := contractLine."BLRStart Date";
            managementfee."BLREnd Date" := contractLine."BLREnd Date";
            managementfee."BLRProperty Type" := contractLine."BLRProperty Classification";
            managementfee."BLRContract Status" := contractLine."BLRContract Status";
            managementfee."BLRCalculation Method" := contractLine."BLRCalculation Method";
            managementfee."BLRPercentage Type" := contractLine."BLRPercentage Type";
            managementfee."BLRBase Amount Type" := contractLine."BLRBase Amount Type";
            managementfee."BLRFrequency Of Payment" := contractLine."BLRFrequency Of Payment";
            managementfee."BLRAmount" := contractLine."BLRAmount";
            managementfee."BLRBase Amount" := contractLine."BLRRent Amount";
            managementfee."BLRPercentage" := contractLine."BLRPercentage";
            managementfee."BLROwner ID" := contractLine."BLROwner ID";
            managementfee."BLROwner Name" := contractLine."BLROwner's Name";
            managementfee."BLRTenant Name" := contractLine."BLRCustomer Name";
            managementfee.Insert();
        end;
    end;


    procedure ManagementFeeMasterDetailsFetchRenewal()
    var
        managementfee: Record "BLRBrokerageMasterData";
        contractLine: Record "BLRTenancyContract";
    begin
        // Filter contractLine using "BLRProposal ID" or other unique identifiers
        contractLine.SetRange("BLRRenewal Proposal ID", Rec."BLRRenewal Proposal ID"); // Add this line or use appropriate filters

        if not contractLine.FindFirst() then
            exit;

        if contractLine."BLRVendor ID" = '' then
            exit;

        managementfee.Reset();
        managementfee.SetRange("BLRVendor ID", contractLine."BLRVendor ID");
        managementfee.SetRange("BLRContract ID", contractLine."BLRContract ID");


        if managementfee.FindFirst() then begin
            // Modify existing
            managementfee."BLRVendor ID" := contractLine."BLRVendor ID";
            managementfee."BLRContract ID" := contractLine."BLRContract ID";
            managementfee."BLRProposal ID" := contractLine."BLRProposal ID";
            managementfee."BLRUnit Name" := contractLine."BLRUnit Name";
            managementfee."BLRUnit Number" := contractLine."BLRUnit Number";
            managementfee."BLRVendor Name" := contractLine."BLRVendor Name";
            managementfee."BLRProperty ID" := contractLine."BLRProperty ID";
            managementfee."BLRProperty Name" := contractLine."BLRProperty Name";
            managementfee."BLRStart Date" := contractLine."BLRStart Date";
            managementfee."BLREnd Date" := contractLine."BLREnd Date";
            managementfee."BLRProperty Type" := contractLine."BLRProperty Classification";
            managementfee."BLRContract Status" := contractLine."BLRContract Status";
            managementfee."BLRCalculation Method" := contractLine."BLRCalculation Method";
            managementfee."BLRPercentage Type" := contractLine."BLRPercentage Type";
            managementfee."BLRBase Amount Type" := contractLine."BLRBase Amount Type";
            managementfee."BLRFrequency Of Payment" := contractLine."BLRFrequency Of Payment";
            managementfee."BLRAmount" := contractLine."BLRAmount";
            managementfee."BLRBase Amount" := contractLine."BLRRent Amount";
            managementfee."BLRPercentage" := contractLine."BLRPercentage";
            managementfee."BLROwner ID" := contractLine."BLROwner ID";
            managementfee."BLROwner Name" := contractLine."BLROwner's Name";
            managementfee."BLRTenant Name" := contractLine."BLRCustomer Name";
            managementfee.Modify();
        end else begin
            // Insert new
            managementfee.Init();
            managementfee."BLRVendor ID" := contractLine."BLRVendor ID";
            managementfee."BLRContract ID" := contractLine."BLRContract ID";
            managementfee."BLRProposal ID" := contractLine."BLRRenewal Proposal ID";
            managementfee."BLRUnit Name" := contractLine."BLRUnit Name";
            managementfee."BLRUnit Number" := contractLine."BLRUnit Number";
            managementfee."BLRVendor Name" := contractLine."BLRVendor Name";
            managementfee."BLRProperty ID" := contractLine."BLRProperty ID";
            managementfee."BLRProperty Name" := contractLine."BLRProperty Name";
            managementfee."BLRStart Date" := contractLine."BLRStart Date";
            managementfee."BLREnd Date" := contractLine."BLREnd Date";
            managementfee."BLRProperty Type" := contractLine."BLRProperty Classification";
            managementfee."BLRContract Status" := contractLine."BLRContract Status";
            managementfee."BLRCalculation Method" := contractLine."BLRCalculation Method";
            managementfee."BLRPercentage Type" := contractLine."BLRPercentage Type";
            managementfee."BLRBase Amount Type" := contractLine."BLRBase Amount Type";
            managementfee."BLRFrequency Of Payment" := contractLine."BLRFrequency Of Payment";
            managementfee."BLRAmount" := contractLine."BLRAmount";
            managementfee."BLRBase Amount" := contractLine."BLRRent Amount";
            managementfee."BLRPercentage" := contractLine."BLRPercentage";
            managementfee."BLROwner ID" := contractLine."BLROwner ID";
            managementfee."BLROwner Name" := contractLine."BLROwner's Name";
            managementfee."BLRTenant Name" := contractLine."BLRCustomer Name";
            managementfee.Insert();
        end;
    end;

    procedure UpdateSecurityDepositBalance()
    begin
        Rec."BLRSecurity Balanced Amount" := Rec."BLRSecDepAmtReceived" - (Rec."BLRCarry Forward Out" + Rec."BLRAdjustments" + Rec."BLRRefund");
        Rec.Modify()
    end;

    procedure UpdateTenancyContractSubPage()
    var
        tenancyContractSubPageRec: Record "BLRTenancyContractSubpage";
    begin
        tenancyContractSubPageRec.SetRange("BLRContractID", Rec."BLRContract ID");
        tenancyContractSubPageRec.SetRange("BLRSecondary Item Type", 'Security Deposit');
        if tenancyContractSubPageRec.FindFirst() then begin
            tenancyContractSubPageRec.Validate("BLRAmount", Rec."BLRSecurity Amount Pending");
            tenancyContractSubPageRec.Modify();
        end;
    end;
}
