table 73209628 "BLRLeaseProposalDetails"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "BLRProposal ID";

    fields
    {
        field(73209575; "BLRProposal ID"; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209576; "BLRUnit Address"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = "Item"."BLRUnit Address";
        }

        field(73209577; "BLRProperty ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Property ID';
            TableRelation = "BLRPropertyRegistration"."BLRProperty ID";

            trigger OnValidate()
            var
                PropertyRec: Record "BLRPropertyRegistration";
            begin
                PropertyRec.SetRange("BLRProperty ID", Rec."BLRProperty ID");
                if PropertyRec.FindFirst() then begin
                    "BLRProperty Name" := PropertyRec."BLRProperty Name";
                    "BLRMakani Number" := PropertyRec."BLRMakani Number";
                    "BLREmirate" := CopyStr(PropertyRec."BLREmirate Name", 1, StrLen(PropertyRec."BLREmirate Name"));
                    "BLRCommunity" := PropertyRec."BLRCommunity";
                    "BLRDEWA Number" := PropertyRec."BLRDEWA Number";
                    "BLRProperty Size" := PropertyRec."BLRProperty Size";
                    "BLRMarket Rate per Sq. Ft." := PropertyRec."BLRMarket Rate per Sq. Ft.";

                end else
                    "BLRProperty Name" := '';
            end;
        }

        field(73209578; "BLRProperty Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Name';
        }

        field(73209579; "BLRUnit ID"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Single Unit ID';
            TableRelation = Item."No."
    where("BLRProperty ID" = field("BLRProperty ID"), "BLRUnit Status" = const(Free), "BLRMergeSplitOption" = const(Single));

            trigger OnValidate()
            var
                LeaseProposalRec: Record "BLRLeaseProposalDetails";
                ItemRec: Record Item;
            begin
                if "BLRMerge Unit ID" <> '' then
                    Error('You can only select either Single "BLRUnit ID" or "BLRMerge Unit ID", not both.');
                if "BLRUnit ID" <> '' then
                    if not Confirm('Once you select this Single "BLRUnit ID", the status of the associated units will change from "Free" to "Selected". Do you wish to proceed?', false) then begin
                        Validate("BLRUnit ID", '');
                        exit;
                    end;
                LeaseProposalRec.Reset();
                LeaseProposalRec.SetRange("BLRProperty ID", "BLRProperty ID");
                LeaseProposalRec.SetRange("BLRUnit ID", "BLRUnit ID");
                LeaseProposalRec.SetFilter("BLRProposal ID", '<>%1', "BLRProposal ID"); // Exclude the current record
                if LeaseProposalRec.FindSet() then
                    repeat
                        if LeaseProposalRec."BLRProposal Status" = LeaseProposalRec."BLRProposal Status"::Approved then
                            Error('This property and unit combination is already used in another proposal with an approved status.');
                    until LeaseProposalRec.Next() = 0;
                if ItemRec.Get("BLRUnit ID") then begin
                    "BLRBase Unit of Measure" := ItemRec."Base Unit of Measure";
                    "BLRUnit Number" := ItemRec."BLRUnit Number";
                    "BLRUsage Type" := ItemRec."BLRUsage Type";
                    "BLRUnit Type" := ItemRec."BLRUnit Type";
                    "BLRUnit Size" := ItemRec."BLRUnit Size";
                    "BLRUnit Address" := CopyStr(ItemRec."BLRUnit Address", 1, strlen(ItemRec."BLRUnit Address"));
                    "BLRUnit Name" := ItemRec."BLRUnit Name";
                    "BLRUnitID" := ItemRec."BLRUnitID";
                    "BLRMarket Rate per Sq. Ft." := ItemRec."BLRMarket Rate per Sq. Ft.";
                    "BLRMakani Number" := ItemRec."BLRMakani Number";
                    "BLRDEWA Number" := ItemRec."BLRDEWA Number";
                    "BLRMunicipality Number" := ItemRec."BLRMunicipality Number";
                    SetRentAmountVAT();
                    ItemRec."BLRUnit Status" := ItemRec."BLRUnit Status"::Selected;
                    ItemRec.Modify();
                end;
            end;
        }

        field(73209580; "BLRUnit Number"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = Item."BLRUnit Number";
        }
        field(73209581; "BLRUsage Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Usage Type';
            TableRelation = "Item"."BLRUsage Type";
            NotBlank = true;
        }
        field(73209582; "BLRUnit Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Type';
            TableRelation = "Item"."BLRUnit Type";
        }
        field(73209583; "BLRUnit Size"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Size';
            TableRelation = "Item"."BLRUnit Size";
        }
        field(73209584; "BLRFacilities/Amenities"; Text[250])
        {
            DataClassification = CustomerContent;
        }

        field(73209585; "BLRTenant Full Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = Customer.Name;
        }

        field(73209586; "BLRTenant ID"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Customer"."No." WHERE("BLRApprove" = const(true));
            ValidateTableRelation = true;
            trigger OnValidate()
            var
                TenantRec: Record "Customer";
            begin
                TenantRec.SetRange("No.", Rec."BLRTenant ID");
                if TenantRec.FindFirst() then begin
                    "BLRTenant Full Name" := TenantRec."Name";
                    "BLRTenant Contact Phone" := TenantRec."Phone No."; // Convert Integer to Text
                    "BLRTenant Contact Email" := TenantRec."E-Mail";
                    "BLREmirates ID" := TenantRec."BLREmirates ID";
                    "BLRLicense No." := TenantRec."BLRLicense No.";
                    "BLRLicensing Authority" := TenantRec."BLRLicensing Authority";
                end else begin // Clear the fields if no record is found
                    "BLRTenant Full Name" := '';
                    "BLRTenant Contact Phone" := '';
                    "BLRTenant Contact Email" := '';
                    "BLREmirates ID" := '';
                    "BLRLicense No." := '';
                    "BLRLicensing Authority" := '';
                end;
            end;
        }
        field(73209587; "BLRTenant Contact Phone"; Text[30])
        {
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = Customer."Phone No.";
        }
        field(73209588; "BLRTenant Contact Email"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = Customer."E-Mail";

        }
        field(73209589; "BLRTrade License"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(73209590; "BLRLegal Representative"; Text[100])
        {
            DataClassification = CustomerContent;
            // trigger OnValidate()
            // var
            //     emailrec: Codeunit "Send Proposal Email";
            // begin
            //     emailrec.SendEmail(Rec);
            // end;
        }

        // Lease Terms Group
        field(73209591; "BLRLease Start Date"; Date)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                CalculateLeaseDuration();

            end;
        }

        field(73209592; "BLRLease End Date"; Date)
        {
            DataClassification = CustomerContent;
            // Trasfer from Table Start  
            // trigger OnValidate()
            // var
            //     docAttach: Page "Revenue Item Subpage Card";
            // begin
            //     CalculateLeaseDuration();
            //     docAttach.SetStartEndDate(Rec."BLRLease Start Date", Rec."BLRLease End Date", Rec."BLRUnit Name", Rec."BLRProperty Name", Rec."BLRUnit Size", Rec."BLRTenant Full Name");
            // end;
            // Trasfer from Table End
        }


        field(73209593; "BLRLease Duration"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Lease Duration';
        }
        field(73209594; "BLRRent Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = ' Annual Rent Amount';

        }
        field(73209595; "BLRPayment Frequency"; Option)
        {
            OptionMembers = " ",Monthly,Quarterly,"Half-Yearly",Yearly;
            DataClassification = CustomerContent;
        }

        field(73209596; "BLRPayment Method"; Text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "BLRPaymentType"."BLRPayment Method";
        }
        // field(50122; "Grace Period"; Integer)
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Grace Period (Days)';
        // }

        // Deposit and Fees Group
        field(73209597; "BLRSecurity Deposit Amount"; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(73209598; "BLROther Fees"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Other Fees ';
        }
        field(73209599; "BLRRefund Conditions"; Text[1000])
        {
            DataClassification = CustomerContent;
        }

        // Responsibilities Group
        field(73209600; "BLRMaintResp"; Option)
        {
            OptionMembers = Tenant,Landlord;
            DataClassification = CustomerContent;
        }
        field(73209601; "BLRUtilityBillsResp"; Option)
        {
            OptionMembers = Tenant,Landlord;
            DataClassification = CustomerContent;
        }
        field(73209602; "BLRInsurance Requirements"; Text[250])
        {
            DataClassification = CustomerContent;
        }

        // Conditions for Renewal Group

        field(73209603; "BLRRent Escalation Clause"; Text[1000])
        {
            DataClassification = CustomerContent;
        }

        // Special Conditions Group
        field(73209604; "BLREarlyTermCond"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(73209605; "BLRRestrictions"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(73209606; "BLRLegal Jurisdiction"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Legal Jurisdiction (e.g., Dubai Courts)';
        }
        field(73209607; "BLRProposal Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Proposal Status';
            OptionMembers = "    ",ProposalSharedtoTenant,Approved,Declined,Completed;
            OptionCaption = '   ,Proposal Shared to Tenant, Approved, Declined, Completed';
            trigger OnValidate()
            var
                ItemRec: Record Item;
                MergeUnitRec: Record "BLRMergedUnits";
                MergeUnitLeaseGrid: Record "BLRSubLeaseMergedUnits";
                emailrec: Codeunit "Send Proposal Email";
            begin
                if "BLRUnit ID" <> '' then begin
                    if ItemRec.Get("BLRUnit ID") then
                        case "BLRProposal Status" of
                            "BLRProposal Status"::ProposalSharedtoTenant:

                                emailrec.SendEmail(Rec); // Call your email codeunit

                            "BLRProposal Status"::Approved:
                                begin
                                    ItemRec."BLRUnit Status" := ItemRec."BLRUnit Status"::Selected;
                                    ItemRec.Modify();
                                end;
                            "BLRProposal Status"::Declined:
                                begin
                                    ItemRec."BLRUnit Status" := ItemRec."BLRUnit Status"::Free;
                                    ItemRec.Modify();
                                end;
                        end;
                end else
                    Message('Unit ID not found in Item Record');


                // Handle logic for "BLRMerge Unit ID"
                if "BLRMerge Unit ID" <> '' then
                    if MergeUnitRec.Get("BLRMerge Unit ID") then
                        case "BLRProposal Status" of
                            "BLRProposal Status"::ProposalSharedtoTenant:
                                begin
                                    Message('Sending Email for Merge Unit Approval');
                                    emailrec.SendEmail(Rec); // Call your email codeunit
                                end;
                            "BLRProposal Status"::Approved:
                                begin
                                    MergeUnitRec."BLRStatus" := MergeUnitRec."BLRStatus"::Selected;
                                    MergeUnitRec.Modify();

                                    ItemRec.Reset();
                                    ItemRec.SetRange("BLRMerged Unit ID", MergeUnitRec."BLRMerged Unit ID");
                                    if ItemRec.FindSet() then
                                        repeat
                                            ItemRec."BLRUnit Status" := ItemRec."BLRUnit Status"::Selected;
                                            ItemRec.Modify();
                                        until ItemRec.Next() = 0;
                                end;
                            "BLRProposal Status"::Declined:
                                begin
                                    // Set Merge Unit Status to Free
                                    MergeUnitRec."BLRStatus" := MergeUnitRec."BLRStatus"::Free;
                                    MergeUnitRec.Modify();

                                    // Delete associated records from Sub Lease Merged Units table
                                    MergeUnitLeaseGrid."BLRMerge Unit ID" := FORMAT(MergeUnitRec."BLRMerged Unit ID");

                                    if MergeUnitLeaseGrid.FindSet() then
                                        repeat
                                            MergeUnitLeaseGrid.Delete();
                                        until MergeUnitLeaseGrid.Next() = 0;

                                    // Update all associated Unit IDs in the Item table
                                    ItemRec.Reset();
                                    ItemRec.SetRange("BLRMerged Unit ID", MergeUnitRec."BLRMerged Unit ID");
                                    if ItemRec.FindSet() then
                                        repeat
                                            ItemRec."BLRUnit Status" := ItemRec."BLRUnit Status"::Free;
                                            // Set Unit Status to Free
                                            ItemRec.Modify();
                                        until ItemRec.Next() = 0;
                                end;
                        end
                    else
                        Message('Merge "BLRUnit ID" not found in Merge Unit Record');
            end;
        }
        field(73209608; "BLREmirates ID"; Code[25])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Emirates ID';
        }

        field(73209609; "BLRUnit Name"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Name';

        }

        field(73209610; "BLRUnitID"; code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'UnitID';

        }

        field(73209611; "BLRBase Unit of Measure"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Base Unit of Measure';
        }

        field(73209612; "BLRMerge Unit ID"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Merge Unit ID';
            TableRelation = "BLRMergedUnits"."BLRMerged Unit ID"
    where("BLRProperty ID" = field("BLRProperty ID"), "BLRStatus" = const(Free)); // Filter only "Free" status records

            trigger OnValidate()
            var
                MergedUnitRec: Record "BLRMergedUnits";
                MergeUnitGrid: Record "BLRSubMergedUnits";
                MergeUnitLeaseGrid: Record "BLRSubLeaseMergedUnits";
                ItemRec: Record Item;
                SelectedUnits: Text[1024];
                mergeUnitId: Integer;
            begin
                if "BLRUnit ID" <> '' then
                    Error('You can only select either "BLRMerge Unit ID" or "BLRUnit ID", not both.');
                if "BLRMerge Unit ID" <> '' then begin
                    if not Confirm('Once you select this "BLRMerge Unit ID", the status of the associated units will change from "Free" to "Selected". Do you wish to proceed?', false) then begin
                        Validate("BLRMerge Unit ID", '');
                        exit;
                    end;
                    if MergedUnitRec.Get("BLRMerge Unit ID") then begin
                        "BLRProperty Name" := MergedUnitRec."BLRProperty Name";
                        "BLRUnit Name" := MergedUnitRec."BLRMerged Unit Name";
                        "BLRBase Unit of Measure" := MergedUnitRec."BLRBase Unit of Measure";
                        "BLRUsage Type" := MergedUnitRec."BLRProperty Type";
                        "BLRUnit Size" := MergedUnitRec."BLRUnit Size";
                        "BLRMarket Rate per Sq. Ft." := MergedUnitRec."BLRMarket Rate per Square";
                        "BLRSingle Unit Name" := MergedUnitRec."BLRSingle Unit Name";
                        "BLRUnit Number" := MergedUnitRec."BLRUnit Number";
                        "BLRMakani Number" := MergedUnitRec."BLRMakani Number";
                        "BLRDEWA Number" := MergedUnitRec."BLRDEWA Number";
                        "BLRMunicipality Number" := MergedUnitRec."BLRMunicipality Number";
                        SetRentAmountVAT();

                        if MergedUnitRec."BLRStatus" = MergedUnitRec."BLRStatus"::Free then begin
                            MergedUnitRec."BLRStatus" := MergedUnitRec."BLRStatus"::Selected; // Set to Selected status
                            MergedUnitRec.Modify();
                        end;
                        SelectedUnits := MergedUnitRec."BLRUnit ID";
                        ItemRec.SetFilter("No.", SelectedUnits);
                        if ItemRec.FindSet() then
                            repeat
                                ItemRec."BLRUnit Status" := ItemRec."BLRUnit Status"::Selected;

                                ItemRec.Modify();
                            until ItemRec.Next() = 0;
                    end else begin
                        // Clear fields if no record is found
                        "BLRProperty Name" := '';
                        "BLRUnit Name" := '';
                        "BLRBase Unit of Measure" := '';
                        "BLRUnit Size" := 0;
                        "BLRRent Amount" := 0;
                    end;
                end else begin
                    "BLRProperty Name" := '';
                    "BLRUnit Name" := '';
                    "BLRBase Unit of Measure" := '';
                    "BLRUnit Size" := 0;
                    "BLRRent Amount" := 0;
                end;
                Evaluate(mergeUnitId, Rec."BLRMerge Unit ID");
                MergeUnitLeaseGrid.SetRange("BLRMerge Unit ID", FORMAT(mergeUnitId));
                if MergeUnitLeaseGrid.FindSet() then
                    repeat
                        MergeUnitLeaseGrid.Delete();
                    until MergeUnitLeaseGrid.Next() = 0;
                MergeUnitGrid.SetRange("BLRMerged Unit ID", mergeUnitId);
                if MergeUnitGrid.FindSet() then
                    repeat
                        MergeUnitLeaseGrid.Init();
                        MergeUnitLeaseGrid."BLRMerge Unit ID" := FORMAT(MergeUnitGrid."BLRMerged Unit ID");
                        MergeUnitLeaseGrid."BLRProposal ID" := Rec."BLRProposal ID";
                        MergeUnitLeaseGrid."BLRSingle Unit Name" := MergeUnitGrid."BLRSingle Unit Name";
                        MergeUnitLeaseGrid."BLRUnit ID" := MergeUnitGrid."BLRUnit ID";
                        MergeUnitLeaseGrid."BLRBase Unit of Measure" := MergeUnitGrid."BLRBase Unit of Measure";
                        MergeUnitLeaseGrid."BLRUnit Size" := MergeUnitGrid."BLRUnit Size";
                        MergeUnitLeaseGrid."BLRUnit Name" := MergeUnitGrid."BLRUnit Name";
                        MergeUnitLeaseGrid."BLRMarket Rate per Square" := MergeUnitGrid."BLRMarket Rate per Square";
                        MergeUnitLeaseGrid."BLRAmount" := MergeUnitGrid."BLRAmount";
                        MergeUnitLeaseGrid.Insert();
                    until MergeUnitGrid.Next() = 0;
            end;
        }
        field(73209613; "BLRAnnual Rent Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Amount ';
            Editable = false;
        }

        field(73209614; "BLRPraposal Type Selected"; Option)
        {
            OptionMembers = " ","Single Unit","Merge Unit";
            DataClassification = CustomerContent;

        }

        field(73209615; "BLRChiller Deposit Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Chiller Deposit Amount';
        }


        field(73209616; "BLRElectricity Deposit Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Electricity Deposit Amount';
        }

        field(73209617; "BLRRenewal Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Renewal Amount';
        }

        field(73209618; "BLRRera Fees"; Decimal)
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'Rera Fees';
        }

        field(73209619; "BLREjari Processing Fees"; Decimal)
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'Ejari Processing Fees';
        }

        field(73209620; "BLRRenewal Amount VAT %"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "0%","5%";
            Caption = 'Renewal Amount VAT %';
            Editable = false;
        }

        field(73209621; "BLRRenewalAmtInclVAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Renewal Amount Including VAT';

            trigger OnValidate()
            begin
                "BLRRenewalAmtInclVAT" := "BLRRenewal Amount" + "BLRRenewal VAT Amount";
            end;
        }

        field(73209622; "BLRRent Amount VAT %"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "0%","5%";
            Caption = 'Contract Amount VAT %';
            Editable = false;
        }

        field(73209623; "BLRRent Amount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Amount Including VAT';
            Editable = false;
        }

        field(73209624; "BLREjari Fees VAT %"; Option)
        {
            DataClassification = OrganizationIdentifiableInformation;
            OptionMembers = "0%","5%";
            Caption = 'Ejari Fees VAT %';
            Editable = false;
        }

        field(73209625; "BLREjari Fees Including VAT"; Decimal)
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'Ejari Fees Including VAT';
            trigger OnValidate()
            begin
                "BLREjari Fees Including VAT" := "BLREjari Processing Fees" + "BLREjari VAT Amount";
            end;
        }
        field(73209626; "BLREjari VAT Amount"; Decimal)
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'Ejari VAT Amount';
            trigger OnValidate()
            begin
                "BLREjari VAT Amount" := "BLREjari Processing Fees" * ("BLREjari Fees VAT %" / 100);
            end;
        }

        field(73209627; "BLRRent VAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract VAT Amount';
            Editable = false;
        }

        field(73209628; "BLRRenewal VAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Renewal VAT Amount';

            trigger OnValidate()
            begin
                "BLRRenewal VAT Amount" := "BLRRenewal Amount" * ("BLRRenewal Amount VAT %" / 100);
            end;
        }
        field(73209629; "BLRLicense No."; Code[20])
        {
            Caption = 'License No.';
            DataClassification = OrganizationIdentifiableInformation;
        }

        field(73209630; "BLRLicensing Authority"; Text[100])
        {
            Caption = 'Licensing Authority';
            DataClassification = OrganizationIdentifiableInformation;
        }

        field(73209631; "BLRMakani Number"; Text[100])
        {
            Caption = 'Makani Number';
            DataClassification = EndUserIdentifiableInformation;

        }
        field(73209632; "BLREmirate"; Code[50])
        {
            Caption = 'Emirate';
            DataClassification = CustomerContent;

        }
        field(73209633; "BLRCommunity"; Text[100])
        {
            Caption = 'Community';
            DataClassification = CustomerContent;
        }
        field(73209634; "BLRDEWA Number"; Text[100])
        {
            Caption = 'DEWA Number';
            DataClassification = CustomerContent;
        }
        field(73209635; "BLRProperty Size"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Size';
        }
        field(73209636; "BLRNo of Installments"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No of Installments';
            Editable = false;
        }
        field(73209637; "BLRSingle Rent Calculation"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Single Unit Rent Calculation Type';
            OptionMembers = " ","Single Unit with square feet rate","Single Unit with lumpsum square feet rate";

            trigger OnValidate()

            var
                LeaseProposal: Record "BLRLeaseProposalDetails";
                SingleSameSquare: Record "BLRSingleUnitRentSubPage";
                SingleLumSquare: Record "BLRSingleLumAnnualAmntSubPage";
                PeriodStartDate: Date;
                PeriodEndDate: Date;
                LeaseEndDate: Date;
                TotalDays: Integer;
                DaysToAdd: Integer;
                LeapDays: Integer;
                CurrentYear: Integer;
                YearCounter: Integer;
                LineNoCounter: Integer;
            begin
                if "BLRSingle Rent Calculation" = "BLRSingle Rent Calculation"::"Single Unit with square feet rate" then begin
                    SingleSameSquare.SetRange("BLRProposal ID", Rec."BLRProposal ID");
                    if SingleSameSquare.FindSet() then
                        repeat
                            SingleSameSquare.Delete();
                        until SingleSameSquare.Next() = 0;
                    PeriodStartDate := Rec."BLRLease Start Date";
                    LeaseEndDate := Rec."BLRLease End Date";
                    YearCounter := 1;
                    LineNoCounter := 1;
                    while PeriodStartDate <= LeaseEndDate do begin
                        SingleSameSquare.Init();
                        SingleSameSquare."BLRProposal ID" := Rec."BLRProposal ID";
                        SingleSameSquare."BLRLine No." := LineNoCounter;
                        SingleSameSquare."BLRYear" := YearCounter;
                        SingleSameSquare."BLRStart Date" := PeriodStartDate;
                        DaysToAdd := 365;
                        LeapDays := 0;
                        for CurrentYear := Date2DMY(PeriodStartDate, 3) to Date2DMY(PeriodStartDate + 364, 3) do
                            if IsLeapYear(CurrentYear) then
                                if (DMY2Date(29, 2, CurrentYear) >= PeriodStartDate) and
                                     (DMY2Date(29, 2, CurrentYear) <= PeriodStartDate + DaysToAdd - 1) then
                                    LeapDays += 1;
                        DaysToAdd := DaysToAdd + LeapDays;
                        PeriodEndDate := PeriodStartDate + DaysToAdd - 1;
                        if PeriodEndDate > LeaseEndDate then
                            PeriodEndDate := LeaseEndDate;
                        SingleSameSquare."BLREnd Date" := PeriodEndDate;
                        TotalDays := PeriodEndDate - PeriodStartDate + 1;
                        SingleSameSquare."BLRNumber of Days" := TotalDays;
                        SingleSameSquare."BLRUnit ID" := Rec."BLRUnit Name";
                        SingleSameSquare."BLRUnit Sq Ft" := Rec."BLRUnit Size";
                        SingleSameSquare."BLRRate per Sq.Ft" := 0;
                        SingleSameSquare."BLRAnnual Amount" := 0;
                        SingleSameSquare."BLRFinal Annual Amount" := SingleSameSquare."BLRAnnual Amount";
                        SingleSameSquare."BLRPer Day Rent" := 0;
                        SingleSameSquare.Insert();
                        PeriodStartDate := PeriodEndDate + 1;
                        YearCounter += 1;
                        LineNoCounter += 1;
                    end;
                end
                else
                    if "BLRSingle Rent Calculation" = "BLRSingle Rent Calculation"::"Single Unit with lumpsum square feet rate" then begin
                        if Rec."BLRProposal ID" = 0 then
                            Error('Proposal ID is missing or not assigned.');
                        LeaseProposal.Reset();
                        LeaseProposal.SetRange("BLRProposal ID", Rec."BLRProposal ID");
                        if not LeaseProposal.FindFirst() then
                            Error('No record found for "BLRProposal ID" %1.', Rec."BLRProposal ID");
                        SingleLumSquare.SetRange("BLRProposal ID", LeaseProposal."BLRProposal ID");
                        if SingleLumSquare.FindSet() then
                            repeat
                                SingleLumSquare.Delete();
                            until SingleLumSquare.Next() = 0;
                        PeriodStartDate := LeaseProposal."BLRLease Start Date";
                        YearCounter := 1;
                        LineNoCounter := 1;
                        while PeriodStartDate <= LeaseProposal."BLRLease End Date" do begin
                            SingleLumSquare.Init();
                            SingleLumSquare."BLRProposal ID" := LeaseProposal."BLRProposal ID";
                            SingleLumSquare."BLRSL_Line No." := LineNoCounter;
                            SingleLumSquare."BLRSL_Year" := YearCounter;
                            SingleLumSquare."BLRSL_Start Date" := PeriodStartDate;
                            DaysToAdd := 365;
                            LeapDays := 0;
                            for CurrentYear := Date2DMY(PeriodStartDate, 3) to Date2DMY(PeriodStartDate + 364, 3) do
                                if IsLeapYear(CurrentYear) then
                                    if (DMY2Date(29, 2, CurrentYear) >= PeriodStartDate) and
                                       (DMY2Date(29, 2, CurrentYear) <= PeriodStartDate + DaysToAdd - 1) then
                                        LeapDays += 1;
                            DaysToAdd := DaysToAdd + LeapDays;
                            PeriodEndDate := PeriodStartDate + DaysToAdd - 1;
                            if PeriodEndDate > LeaseProposal."BLRLease End Date" then
                                PeriodEndDate := LeaseProposal."BLRLease End Date";
                            SingleLumSquare."BLRSL_End Date" := PeriodEndDate;
                            TotalDays := PeriodEndDate - PeriodStartDate + 1;
                            SingleLumSquare."BLRSL_Number of Days" := TotalDays;
                            SingleLumSquare."BLRSL_Unit ID" := LeaseProposal."BLRUnit Name";
                            SingleLumSquare."BLRSL_Unit Sq Ft" := LeaseProposal."BLRUnit Size";
                            if YearCounter = 1 then begin
                                SingleLumSquare."BLRSL_Annual Amount" := 0; // User will enter manually
                                SingleLumSquare."BLRSL_Final Annual Amount" := 0;
                            end;
                            if TotalDays > 0 then
                                SingleLumSquare."BLRSL_Per Day Rent" := SingleLumSquare."BLRSL_Final Annual Amount" / TotalDays
                            else
                                SingleLumSquare."BLRSL_Per Day Rent" := 0;
                            SingleLumSquare.Insert();
                            PeriodStartDate := PeriodEndDate + 1;
                            YearCounter += 1;
                            LineNoCounter += 1;
                        end;
                    end;
            end;
        }
        field(73209638; "BLRMerge Rent Calculation"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Merge Unit Rent Calculation Type';
            OptionMembers = " ","Merged Unit with same square feet","Merged Unit with differential square feet rate","Merged Unit with lumpsum annual amount";
            trigger OnValidate()
            var
                LeaseProposal: Record "BLRLeaseProposalDetails"; // Replace with actual table name
                MergeSameSquare: Record "BLRMergeSameSqureSubPage"; // Target table
                MergeDiffSquare: Record "BLRMergeDifferentSqureSubPage"; // Target table
                MergeLumSquare: Record "BLRMergeLumAnnualAmountSubPage";
                SubLeaseMergeRec: Record "BLRSubLeaseMergedUnits";
                PeriodStartDate: Date;
                PeriodEndDate: Date;
                LeaseEndDate: Date;
                TotalDays: Integer;
                DaysToAdd: Integer;
                LeapDays: Integer;
                CurrentYear: Integer;
                YearCounter: Integer;
                LineNoCounter: Integer;
            begin
                case
                    "BLRMerge Rent Calculation" of
                    "BLRMerge Rent Calculation"::"Merged Unit with same square feet":
                        begin
                            MergeSameSquare.SetRange("BLRProposal ID", Rec."BLRProposal ID");
                            if MergeSameSquare.FindSet() then
                                repeat
                                    MergeSameSquare.Delete();
                                until MergeSameSquare.Next() = 0;
                            PeriodStartDate := Rec."BLRLease Start Date";
                            LeaseEndDate := Rec."BLRLease End Date";
                            YearCounter := 1;
                            LineNoCounter := 1;
                            while PeriodStartDate <= LeaseEndDate do begin
                                MergeSameSquare.Init();
                                MergeSameSquare."BLRProposal ID" := Rec."BLRProposal ID";
                                MergeSameSquare."BLRMS_Line No." := LineNoCounter;
                                MergeSameSquare."BLRMS_Year" := YearCounter;
                                MergeSameSquare."BLRMS_Start Date" := PeriodStartDate;
                                DaysToAdd := 365; // Default to 365 days
                                LeapDays := 0;
                                for CurrentYear := Date2DMY(PeriodStartDate, 3) to Date2DMY(PeriodStartDate + 364, 3) do
                                    if IsLeapYear(CurrentYear) then
                                        if (DMY2Date(29, 2, CurrentYear) >= PeriodStartDate) and
                                     (DMY2Date(29, 2, CurrentYear) <= PeriodStartDate + DaysToAdd - 1) then
                                            LeapDays += 1;
                                DaysToAdd := DaysToAdd + LeapDays;
                                PeriodEndDate := PeriodStartDate + DaysToAdd - 1;
                                if PeriodEndDate > LeaseEndDate then
                                    PeriodEndDate := LeaseEndDate;
                                MergeSameSquare."BLRMS_End Date" := PeriodEndDate;
                                TotalDays := PeriodEndDate - PeriodStartDate + 1;
                                MergeSameSquare."BLRMS_Number of Days" := TotalDays;
                                MergeSameSquare."BLRMS_Merged Unit ID" := Rec."BLRUnit Name";
                                MergeSameSquare."BLRMS_Unit Sq Ft" := Rec."BLRUnit Size";
                                MergeSameSquare."BLRMS_Rate per Sq.Ft" := 0; // Initialize as 0; users will manually enter this
                                MergeSameSquare."BLRMS_Annual Amount" := 0; // Calculated after manual input
                                MergeSameSquare."BLRMS_Final Annual Amount" := MergeSameSquare."BLRMS_Annual Amount";
                                MergeSameSquare."BLRMS_Per Day Rent" := 0; // Will be calculated after manual input
                                MergeSameSquare.Insert();
                                PeriodStartDate := PeriodEndDate + 1;
                                YearCounter += 1;
                                LineNoCounter += 1;
                            end;
                        end;
                    "BLRMerge Rent Calculation"::"Merged Unit with lumpsum annual amount":
                        begin
                            if Rec."BLRProposal ID" = 0 then
                                Error('Proposal ID is missing or not assigned.');
                            LeaseProposal.Reset();
                            LeaseProposal.SetRange("BLRProposal ID", Rec."BLRProposal ID");
                            if not LeaseProposal.FindFirst() then
                                Error('No record found for "BLRProposal ID" %1.', Rec."BLRProposal ID");
                            MergeLumSquare.SetRange("BLRProposal ID", LeaseProposal."BLRProposal ID");
                            if MergeLumSquare.FindSet() then
                                repeat
                                    MergeLumSquare.Delete();
                                until MergeLumSquare.Next() = 0;
                            PeriodStartDate := LeaseProposal."BLRLease Start Date";
                            YearCounter := 1;
                            LineNoCounter := 1;
                            while PeriodStartDate <= LeaseProposal."BLRLease End Date" do begin
                                MergeLumSquare.Init();
                                MergeLumSquare."BLRProposal ID" := LeaseProposal."BLRProposal ID";
                                MergeLumSquare."BLRML_Line No." := LineNoCounter;
                                MergeLumSquare."BLRML_Year" := YearCounter;
                                MergeLumSquare."BLRML_Start Date" := PeriodStartDate;
                                DaysToAdd := 365; // Default to 365 days
                                LeapDays := 0;

                                for CurrentYear := Date2DMY(PeriodStartDate, 3) to Date2DMY(PeriodStartDate + 364, 3) do
                                    if IsLeapYear(CurrentYear) then
                                        // Ensure the leap day (Feb 29) falls within the range
                                        if (DMY2Date(29, 2, CurrentYear) >= PeriodStartDate) and (DMY2Date(29, 2, CurrentYear) <= PeriodStartDate + DaysToAdd - 1) then
                                            LeapDays += 1;

                                DaysToAdd := DaysToAdd + LeapDays;
                                PeriodEndDate := PeriodStartDate + DaysToAdd - 1;
                                if PeriodEndDate > LeaseProposal."BLRLease End Date" then
                                    PeriodEndDate := LeaseProposal."BLRLease End Date";
                                MergeLumSquare."BLRML_End Date" := PeriodEndDate;
                                TotalDays := PeriodEndDate - PeriodStartDate + 1;
                                MergeLumSquare."BLRML_Number of Days" := TotalDays;
                                MergeLumSquare."BLRML_Merged Unit ID" := LeaseProposal."BLRUnit Name";
                                MergeLumSquare."BLRML_Unit Sq Ft" := LeaseProposal."BLRUnit Size";
                                if YearCounter = 1 then begin
                                    MergeLumSquare."BLRML_Annual Amount" := 0; // User will enter manually
                                    MergeLumSquare."BLRML_Final Annual Amount" := 0;
                                end;
                                if TotalDays > 0 then
                                    MergeLumSquare."BLRML_Per Day Rent" := MergeLumSquare."BLRML_Final Annual Amount" / TotalDays
                                else
                                    MergeLumSquare."BLRML_Per Day Rent" := 0;
                                MergeLumSquare.Insert();
                                PeriodStartDate := PeriodEndDate + 1;
                                YearCounter += 1;
                                LineNoCounter += 1;
                            end;
                        end;
                    "BLRMerge Rent Calculation"::"Merged Unit with differential square feet rate":
                        begin
                            MergeDiffSquare.SetRange("BLRProposal ID", Rec."BLRProposal ID");
                            if MergeDiffSquare.FindSet() then
                                repeat
                                    MergeDiffSquare.Delete();
                                until MergeDiffSquare.Next() = 0;
                            PeriodStartDate := Rec."BLRLease Start Date";
                            LeaseEndDate := Rec."BLRLease End Date";
                            YearCounter := 1;
                            LineNoCounter := 1;
                            SubLeaseMergeRec.SetRange("BLRProposal ID", Rec."BLRProposal ID");
                            if SubLeaseMergeRec.FindSet() then
                                repeat
                                    YearCounter := 1;
                                    PeriodStartDate := Rec."BLRLease Start Date";
                                    LeaseEndDate := Rec."BLRLease End Date";
                                    while PeriodStartDate <= LeaseEndDate do begin
                                        MergeDiffSquare.Init();
                                        MergeDiffSquare."BLRProposal ID" := Rec."BLRProposal ID";
                                        MergeDiffSquare."BLRMD_Line No." := LineNoCounter;
                                        MergeDiffSquare."BLRMD_Year" := YearCounter;
                                        MergeDiffSquare."BLRMD_Start Date" := PeriodStartDate;
                                        DaysToAdd := 365;
                                        LeapDays := 0;

                                        for CurrentYear := Date2DMY(PeriodStartDate, 3) to Date2DMY(PeriodStartDate + 364, 3) do
                                            if IsLeapYear(CurrentYear) then
                                                if (DMY2Date(29, 2, CurrentYear) >= PeriodStartDate) and (DMY2Date(29, 2, CurrentYear) <= PeriodStartDate + DaysToAdd - 1) then
                                                    LeapDays += 1;

                                        DaysToAdd := DaysToAdd + LeapDays;
                                        PeriodEndDate := PeriodStartDate + DaysToAdd - 1;

                                        if PeriodEndDate > LeaseEndDate then
                                            PeriodEndDate := LeaseEndDate;

                                        MergeDiffSquare."BLRMD_End Date" := PeriodEndDate;
                                        TotalDays := PeriodEndDate - PeriodStartDate + 1;
                                        MergeDiffSquare."BLRMD_Number of Days" := TotalDays;
                                        MergeDiffSquare."BLRMD_Merged Unit ID" := Rec."BLRUnit Name";
                                        MergeDiffSquare."BLRMD_Unit Sq Ft" := SubLeaseMergeRec."BLRUnit Size"; // From Sub Lease Merged Units
                                        MergeDiffSquare."BLRMD_Unit ID" := CopyStr(SubLeaseMergeRec."BLRSingle Unit Name", 1, StrLen(SubLeaseMergeRec."BLRSingle Unit Name")); // From Sub Lease Merged Units
                                        MergeDiffSquare."BLRMD_Rate per Sq.Ft" := 0; // Initialize as 0; users will manually enter this
                                        MergeDiffSquare."BLRMD_Annual Amount" := 0; // Calculated after manual input
                                        MergeDiffSquare."BLRMD_Final Annual Amount" := MergeSameSquare."BLRMS_Annual Amount";
                                        MergeDiffSquare."BLRMD_Per Day Rent" := 0;
                                        MergeDiffSquare.Insert();
                                        PeriodStartDate := PeriodEndDate + 1;
                                        YearCounter += 1;
                                        LineNoCounter += 1;
                                    end;
                                until SubLeaseMergeRec.Next() = 0
                            else
                                Error('No matching records found in Sub Lease Merged Units for the given "BLRProposal ID".');
                        end;

                end;
            end;
        }
        field(73209639; "BLRMarket Rate per Sq. Ft."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Market Rate per Sq. Ft. ';
        }

        field(73209640; "BLRSingle Unit Name"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Single Unit Names';
        }

        field(73209641; "BLRTotalFinalAmount"; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(73209642; "BLRTotalAnnualAmount"; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(73209643; "BLRTotalRoundOff"; Decimal)
        {
            DataClassification = CustomerContent;

        }

        field(73209644; "BLRUpdate Data"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Update Data';
            InitValue = 'Update Data';

        }

        field(73209645; "BLRVendor ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor ID';
        }

        field(73209646; "BLRVendor Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Vendor Name';
            Editable = false;
        }
        field(73209647; "BLRPercentage"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Percentage';
        }
        field(73209648; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
        field(73209649; "BLRCalculation Method"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Calculation Method';
            TableRelation = "BLRCalculationType"."BLRCalculation Type";
        }

        field(73209650; "BLRPercentage Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Percentage Type';
            OptionMembers = " ","Fixed","Variable";
        }
        field(73209651; "BLRBase Amount Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Base Amount Type';
            OptionMembers = " ","Revenue","Collection","Annual Rent","Monthly Rent";
        }
        field(73209652; "BLRFrequency Of Payment"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Frequency Of Payment';
            OptionMembers = " ","Monthly","Quaterly","Half Yearly","Yearly";
        }

        field(73209653; "BLRStart Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
            Editable = false;
        }
        field(73209654; "BLREnd Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
            Editable = false;
        }

        field(73209655; "BLRContract Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Status';
            OptionMembers = " ","Active","Terminate";
        }

        field(73209656; "BLRIs any Broker Involved?"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Is any Broker Involved?';
        }
        field(73209657; "BLRMunicipality Number"; Text[100])
        {
            Caption = 'Municipality Number';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "BLRProposal ID", "BLRMerge Unit ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "BLRProposal ID", "BLRUnit Name", "BLRProperty Name", "BLRTenant Full Name", "BLRTenant ID", "BLRUnit Number")
        {

        }
    }
    procedure CalculateLeaseDuration()
    var
        LeaseStartDate: Date;
        LeaseEndDate: Date;
        Years: Integer;
        Months: Integer;
        Days: Integer;
        DurationText: Text[50];
        TempStartDate: Date;
        DaysDifference: Integer;
    begin
        LeaseStartDate := "BLRLease Start Date";
        LeaseEndDate := "BLRLease End Date";

        if (LeaseStartDate <> 0D) and (LeaseEndDate <> 0D) then begin
            if LeaseEndDate >= LeaseStartDate then begin
                DaysDifference := LeaseEndDate - LeaseStartDate + 1;
                if (DaysDifference = 365) or (DaysDifference = 366) then begin
                    Years := 1;
                    Months := 0;
                    Days := 0;
                end else begin
                    TempStartDate := LeaseStartDate;
                    Years := 0;
                    while (CALCDATE('<+1Y>', TempStartDate) <= LeaseEndDate) or
                          (CALCDATE('<+1Y-1D>', TempStartDate) = LeaseEndDate) do begin
                        TempStartDate := CALCDATE('<+1Y>', TempStartDate);
                        Years := Years + 1;
                    end;
                    Months := 0;
                    while CALCDATE('<+1M>', TempStartDate) <= LeaseEndDate do begin
                        TempStartDate := CALCDATE('<+1M>', TempStartDate);
                        Months := Months + 1;
                    end;
                    Days := LeaseEndDate - TempStartDate + 1;
                end;
                DurationText := '';
                if Years > 0 then
                    DurationText := Format(Years) + ' year(s) ';

                if Months > 0 then
                    DurationText := Format(DurationText + Format(Months) + ' month(s) ');
                if Days > 0 then
                    DurationText := Format(DurationText + Format(Days) + ' day(s)');
                "BLRLease Duration" := DelChr(DurationText, '<>', ' ');
            end else
                "BLRLease Duration" := '';
        end else
            "BLRLease Duration" := '';
    end;

    trigger OnDelete()
    var
    begin
        DeleteSingleUnitSameRate();
        DeleteMergeUnitSameRate();
        DeletePerDayRevenueUnitSameRate();
        DeleteLeaseMergeAllUnitDetails();
        DeleteMergeUnitDiffRate();
        DeleteSingleUnitLumpsumRate();
        DeleteMergeUnitLumpsumRate();
        DeleteAdditionalTerms();

    end;

    procedure DeleteSingleUnitSameRate()
    var
        deleteSingleUnitRecords: Record "BLRSingleUnitRentSubPage";

    begin
        deleteSingleUnitRecords.SetRange("BLRProposal ID", Rec."BLRProposal ID");

        if deleteSingleUnitRecords.FindSet() then
            deleteSingleUnitRecords.DeleteAll();
    end;

    procedure DeleteMergeUnitSameRate()
    var
        deleteMergeUnitRecords: Record "BLRMergeSameSqureSubPage";

    begin
        deleteMergeUnitRecords.SetRange("BLRProposal ID", Rec."BLRProposal ID");

        if deleteMergeUnitRecords.FindSet() then
            deleteMergeUnitRecords.DeleteAll();
    end;

    procedure DeleteAdditionalTerms()
    var
        AdditionalTerms: Record "BLRAdditionalTerms";
    begin
        AdditionalTerms.SetRange("BLRDocument No.", Rec."BLRProposal ID");

        if AdditionalTerms.FindSet() then
            AdditionalTerms.DeleteAll();
    end;

    procedure DeletePerDayRevenueUnitSameRate()
    var
        deletePerDayRevenueUnitRecords: Record "BLRPerDayRentforRevenue";

    begin
        deletePerDayRevenueUnitRecords.SetRange("BLRProposal Id", Rec."BLRProposal ID");

        if deletePerDayRevenueUnitRecords.FindSet() then
            deletePerDayRevenueUnitRecords.DeleteAll();
    end;

    procedure DeleteLeaseMergeAllUnitDetails()
    var
        deleteAllUnitRecords: Record "BLRSubLeaseMergedUnits";

    begin
        deleteAllUnitRecords.SetRange("BLRProposal ID", Rec."BLRProposal ID");

        if deleteAllUnitRecords.FindSet() then
            deleteAllUnitRecords.DeleteAll();
    end;

    procedure DeleteMergeUnitDiffRate()
    var
        deleteMergeUnitDiffRecords: Record "BLRMergeDifferentSqureSubPage";

    begin
        deleteMergeUnitDiffRecords.SetRange("BLRProposal ID", Rec."BLRProposal ID");

        if deleteMergeUnitDiffRecords.FindSet() then
            deleteMergeUnitDiffRecords.DeleteAll();
    end;

    procedure DeleteMergeUnitLumpsumRate()
    var
        deleteMergeUnitLumpsumRecords: Record "BLRMergeLumAnnualAmountSubPage";

    begin
        deleteMergeUnitLumpsumRecords.SetRange("BLRProposal ID", Rec."BLRProposal ID");

        if deleteMergeUnitLumpsumRecords.FindSet() then
            deleteMergeUnitLumpsumRecords.DeleteAll();
    end;

    procedure DeleteSingleUnitLumpsumRate()
    var
        deleteSingleUnitLumpsumRecords: Record "BLRSingleLumAnnualAmntSubPage";

    begin
        deleteSingleUnitLumpsumRecords.SetRange("BLRProposal ID", Rec."BLRProposal ID");

        if deleteSingleUnitLumpsumRecords.FindSet() then
            deleteSingleUnitLumpsumRecords.DeleteAll();
    end;

    trigger OnInsert()
    begin
        ValidateRecord();
    end;

    local procedure IsLeapYear(Year: Integer): Boolean
    begin
        if (Year mod 4 = 0) and ((Year mod 100 <> 0) or (Year mod 400 = 0)) then
            exit(true);
        exit(false);
    end;

    procedure SetRentAmountVAT()
    var
        UsageTypeTxt: Text;
    begin
        UsageTypeTxt := UpperCase(Rec."BLRUsage Type");

        case UsageTypeTxt of
            'COMMERCIAL':
                "BLRRent Amount VAT %" := "BLRRent Amount VAT %"::"5%";
            else
                "BLRRent Amount VAT %" := "BLRRent Amount VAT %"::"0%";
        end;
    end;

    procedure ValidateRecord()
    begin
        TestField(Rec."BLRProperty ID");
    end;
}

