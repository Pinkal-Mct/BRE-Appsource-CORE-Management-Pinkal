table 73209600 "BLRContractRenewal"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "BLRId";

    fields
    {
        field(73209575; "BLRId"; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209576; "BLROwner's Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Owner Name';
            TableRelation = "BLROwnerProfile"."BLRFull Name";
        }
        field(73209577; "BLRLessor's Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Lessor Name';
        }
        field(73209578; "BLRLessor's Emirates ID"; Code[15])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Lessor Emirates ID';
        }
        field(73209579; "BLRLicense No."; Code[20])
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'License No.';
        }
        field(73209580; "BLRLicensing Authority"; Text[100])
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'Licensing Authority';
        }
        field(73209581; "BLRLessor's Email"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Lessor Email';
        }
        field(73209582; "BLRLessor's Phone"; Text[20])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Lessor Phone';
        }
        field(73209583; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
            TableRelation = "BLRTenancyContract"."BLRContract ID";
            trigger OnValidate()
            var
                TenancyContractRec: Record "BLRTenancyContract";
                EndDate: Date;
            begin
                TenancyContractRec.SetRange("BLRContract ID", "BLRContract ID");
                if TenancyContractRec.FindFirst() then begin
                    EndDate := TenancyContractRec."BLRContract End Date" + 1;
                    "BLRContract Start Date" := EndDate;
                    "BLRContract Amount" := TenancyContractRec."BLRAnnual Rent Amount";
                    "BLRUnit ID" := TenancyContractRec."BLRUnit ID";
                    "BLRUnit Name" := TenancyContractRec."BLRUnit Name";
                    "BLRProperty ID" := TenancyContractRec."BLRProperty ID";
                    "BLRProperty Name" := TenancyContractRec."BLRProperty Name";
                    "BLRTenant Full Name" := TenancyContractRec."BLRCustomer Name";
                    "BLROwner's Name" := TenancyContractRec."BLROwner's Name";
                    "BLRLessor's Name" := TenancyContractRec."BLRLessor's Name";
                    "BLRLessor's Emirates ID" := TenancyContractRec."BLRLessor's Emirates ID";
                    "BLRLicense No." := TenancyContractRec."BLRLicense No.";
                    "BLRLicensing Authority" := TenancyContractRec."BLRLicensing Authority";
                    "BLRLessor's Email" := TenancyContractRec."BLRLessor's Email";
                    "BLRProposal ID" := TenancyContractRec."BLRProposal ID";
                    "BLREjari Name" := TenancyContractRec."BLREjari Name";
                    "BLRProperty Classification" := TenancyContractRec."BLRProperty Classification";
                    "BLRProperty Type" := TenancyContractRec."BLRProperty Type";
                    "BLRAnnual Rent Amount" := TenancyContractRec."BLRAnnual Rent Amount";
                    "BLRBase Unit of Measure" := TenancyContractRec."BLRBase Unit of Measure";
                    "BLRUnit Sq. Feet" := TenancyContractRec."BLRUnit Sq. Feet";
                    "BLRGrace Period" := TenancyContractRec."BLRGrace Period";
                    "BLRGrace Start Date" := TenancyContractRec."BLRGrace Start Date";
                    "BLRGrace End Date" := TenancyContractRec."BLRGrace End Date";
                    "BLRTenant ID" := TenancyContractRec."BLRTenant ID";
                    "BLREmirates ID" := CopyStr(TenancyContractRec."BLREmirates ID", 1, StrLen(TenancyContractRec."BLREmirates ID"));
                    "BLRContact Number" := TenancyContractRec."BLRContact Number";
                    "BLREmail Address" := TenancyContractRec."BLREmail Address";
                    "BLRPayment Frequency" := TenancyContractRec."BLRPayment Frequency";
                    "BLRPayment Method" := TenancyContractRec."BLRPayment Method";
                    "BLRCreated By" := CopyStr(TenancyContractRec."BLRCreated By", 1, StrLen(TenancyContractRec."BLRCreated By"));
                    "BLRMerge Unit ID" := TenancyContractRec."BLRMerge Unit ID";
                    "BLRRent Amount" := TenancyContractRec."BLRRent Amount";
                    "BLRTenant_License No." := TenancyContractRec."BLRTenant_License No.";
                    "BLRTenant_Licensing Authority" := TenancyContractRec."BLRTenant_Licensing Authority";
                    "BLRSecurity Deposit Amount" := TenancyContractRec."BLRSecurity Deposit Amount";
                    "BLRUnit Number" := TenancyContractRec."BLRUnit Number";
                    "BLRMakani Number" := TenancyContractRec."BLRMakani Number";
                    "BLRMunicipality Number" := TenancyContractRec."BLRMunicipality Number";

                    "BLREmirate" := TenancyContractRec."BLREmirate";
                    "BLRCommunity" := TenancyContractRec."BLRCommunity";
                    "BLRProperty Size" := TenancyContractRec."BLRProperty Size";
                    "BLRNo of Installments" := TenancyContractRec."BLRNo of Installments";
                    "BLRDEWA Number" := TenancyContractRec."BLRDEWA Number";
                    "BLRUnitID" := TenancyContractRec."BLRUnitID";
                    "BLRLessor's Phone" := TenancyContractRec."BLRLessor's Phone";
                    "BLRPraposal Type Selected" := TenancyContractRec."BLRPraposal Type Selected";
                    "BLRRent Amount VAT %" := TenancyContractRec."BLRContract VAT %";
                    "BLRRent VAT Amount" := TenancyContractRec."BLRContract VAT Amount";
                    "BLRRent Amount Including VAT" := TenancyContractRec."BLRContAmtInclVAT";
                    "BLRUnit Type" := TenancyContractRec."BLRUnit Type";
                    "BLRUsage Type" := TenancyContractRec."BLRUsage Type";
                end else begin
                    Clear("BLRContract Start Date");
                    Clear("BLRContract End Date");
                    Clear("BLRContract Amount");
                    Clear("BLRUnit ID");
                    Clear("BLRUnit Name");
                    Clear("BLRProperty ID");
                    Clear("BLRProperty Name");
                end;
            end;
        }

        field(73209584; "BLRContract Start Date"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                TenancyContractRec: Record "BLRTenancyContract";
                ErrorLbl: Label 'Renewal contract start date (%1) must be after the original contract end date (%2).';
                ErrorMsg: Text;
            begin
                CalculateLeaseDuration();

                if "BLRContract ID" <> 0 then begin
                    TenancyContractRec.SetRange("BLRContract ID", "BLRContract ID");
                    if TenancyContractRec.FindFirst() then
                        if "BLRContract Start Date" <> 0D then
                            if "BLRContract Start Date" <= TenancyContractRec."BLRContract End Date" then begin
                                ErrorMsg := StrSubstNo(ErrorLbl, "BLRContract Start Date", TenancyContractRec."BLRContract End Date");
                                Error(ErrorMsg);
                            end;
                end;
            end;
        }
        field(73209585; "BLRContract End Date"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CalculateLeaseDuration();
            end;
        }

        field(73209586; "BLRContract Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209587; "BLRUnit ID"; Code[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209588; "BLRUnit Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209589; "BLRProperty ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(73209590; "BLRProperty Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209591; "BLRRenewal Contract Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Active,"Renewal of Original Contract ID";
            Editable = false;

            trigger OnValidate()
            var
                TenancyContractRec: Record "BLRTenancyContract";
                emailrec: Codeunit "BLRSend Contract Renewal Email";
            begin
                if "BLRRenewal Contract Status" = "BLRRenewal Contract Status"::"Renewal of Original Contract ID" then begin
                    TenancyContractRec.SetRange("BLRContract ID", "BLRContract ID");
                    if TenancyContractRec.FindFirst() then begin
                        TenancyContractRec."BLRTenant Contract Status" :=
                            TenancyContractRec."BLRTenant Contract Status"::"Active-Contract Renewed";
                        TenancyContractRec.Modify();
                        Message('Tenancy "BLRContract ID" %1 updated to "Active-Contract Renewed".', "BLRContract ID");
                    end else
                        Error('No Tenancy Contract found with "BLRContract ID" %1.', "BLRContract ID");
                end;
                if Rec."BLRRenewal Contract Status" = Rec."BLRRenewal Contract Status"::"Renewal of Original Contract ID" then
                    emailrec.SendEmail(Rec);
            end;

        }

        field(73209592; "BLRTenant Full Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
        }
        field(73209593; "BLRContract Tenor"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Period (Months)';
        }
        field(73209594; "BLRApproval For Renewal"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Approval For Renewal';
            OptionMembers = " ","Request For Renewal";
        }
        field(73209595; "BLRProposal ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Proposal ID';
        }
        field(73209596; "BLREjari Name"; Text[100])
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'Ejari Name';
        }
        field(73209597; "BLRProperty Classification"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Classification';
            TableRelation = "BLRPrimaryClassification"."BLRClassification Name";
            NotBlank = true;
        }
        field(73209598; "BLRProperty Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Type';
            TableRelation = "BLRSecondaryClassification"
                where("BLRClassification Name" = field("BLRProperty Classification"));

            trigger OnValidate()
            var
                secondaryClassification: Record "BLRSecondaryClassification";
            begin
                if secondaryClassification.Get(Rec."BLRProperty Type") then
                    Rec."BLRProperty Type" := secondaryClassification."BLRProperty Type";
            end;
        }
        field(73209599; "BLRAnnual Rent Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Rent Amount ';
        }

        field(73209600; "BLRContract Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Date';
            trigger OnValidate()
            var
                MergeUnitGrid: Record "BLRSubMergedUnits";
                MergeUnitLeaseGrid: Record "BLRCRSubLeaseMergedUnits";
                mergeUnitId: Integer;
            begin
                if Rec."BLRMerge Unit ID" <> '' then begin

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
                            MergeUnitLeaseGrid."BLRID" := Rec."BLRId";
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
            end;

        }

        field(73209601; "BLRBase Unit of Measure"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Base Unit of Measure';

        }

        field(73209602; "BLRUnit Sq. Feet"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Size';
        }

        field(73209603; "BLRGrace Period"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Grace Period (Days)';
        }

        field(73209604; "BLRGrace Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Grace Start Date';

        }

        field(73209605; "BLRGrace End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Grace End Date';


        }

        field(73209606; "BLRTenant ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
            TableRelation = Customer."No.";
        }

        field(73209607; "BLREmirates ID"; Code[15])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Emirates ID';
        }

        field(73209608; "BLRContact Number"; Text[30])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Contact Number';
        }
        field(73209609; "BLREmail Address"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Email Address';
        }

        field(73209610; "BLRPayment Frequency"; Option)
        {
            OptionMembers = Monthly,Quarterly,Yearly;
            DataClassification = CustomerContent;
        }
        field(73209611; "BLRPayment Method"; Text[100])
        {
            DataClassification = CustomerContent;
        }

        field(73209612; "BLRCreated By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
        }

        field(73209613; "BLRMerge Unit ID"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Merge Unit ID';
            // TableRelation = "BLRMergedUnits"."BLRMerged Unit ID"
            //      where("BLRProperty ID" = field("BLRProperty ID"));


        }

        field(73209614; "BLRRent Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Annual "BLRRent Amount" ';
        }


        field(73209615; "BLRTenant_License No."; Code[20])
        {
            Caption = 'Tenant Trade License No.';
            DataClassification = OrganizationIdentifiableInformation;
        }

        field(73209616; "BLRTenant_Licensing Authority"; Text[100])
        {
            Caption = 'Tenant_Licensing Authority';
            DataClassification = OrganizationIdentifiableInformation;
        }


        field(73209617; "BLRUnit Number"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(73209618; "BLRMakani Number"; Text[50])
        {
            DataClassification = EndUserIdentifiableInformation;

        }
        field(73209619; "BLREmirate"; Text[50])
        {
            DataClassification = CustomerContent;

        }
        field(73209620; "BLRCommunity"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209621; "BLRDEWA Number"; Text[100])
        {
            Caption = 'DEWA Number';
            DataClassification = CustomerContent;
        }
        field(73209622; "BLRProperty Size"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Size';
        }
        field(73209623; "BLRNo of Installments"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No of Installments';
            Editable = false;
        }

        field(73209624; "BLRUnitID"; code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Uniq Unit ID';

        }

        field(73209625; "BLROriginal Contract ID"; code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Original Contract ID';

        }

        field(73209626; "BLRFinal Status"; Option)
        {
            OptionMembers = " ",Approved,Reject;
            DataClassification = CustomerContent;
        }

        field(73209627; "BLRContract Status"; Option)
        {
            OptionMembers = " ",Active;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                TenancyContractRec: Record "BLRTenancyContract";
            begin
                if "BLRContract Status" = "BLRContract Status"::Active then begin
                    TenancyContractRec.SetRange("BLRRenewal Proposal ID", "BLRId");
                    if TenancyContractRec.FindSet() then
                        repeat
                            TenancyContractRec."BLRTenant Contract Status" :=
      TenancyContractRec."BLRTenant Contract Status"::Active;
                            TenancyContractRec.Modify();
                        until TenancyContractRec.Next() = 0;

                end;
            end;

        }
        field(73209628; "BLRRera"; Decimal)
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'Rera';

        }
        field(73209629; "BLREjari Processing Charges"; Decimal)
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'Ejari Processing Charges';
        }
        field(73209630; "BLRRenewal Charges"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Renewal Charges';

        }
        field(73209631; "BLRPraposal Type Selected"; Option)
        {
            OptionMembers = " ","Single Unit","Merge Unit";
            DataClassification = CustomerContent;

        }
        field(73209632; "BLRSingle Rent Calculation"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Single Unit Rent Calculation Type';
            OptionMembers = " ","Single Unit with square feet rate","Single Unit with lumpsum square feet rate";
            trigger OnValidate()
            var
                LeaseProposal: Record "BLRContractRenewal"; // Replace with actual table name
                SingleSameSquare: Record "BLRCRSingleUnitRentSubPage"; // Target table
                SingleLumSquare: Record "BLRCRSingleLumAnnualAmntSP"; // Target table
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
                    SingleSameSquare.SetRange("BLRId", Rec."BLRId");
                    if SingleSameSquare.FindSet() then
                        repeat
                            SingleSameSquare.Delete();
                        until SingleSameSquare.Next() = 0;
                    PeriodStartDate := Rec."BLRContract Start Date";
                    LeaseEndDate := Rec."BLRContract End Date";
                    YearCounter := 1;
                    LineNoCounter := 1;
                    while PeriodStartDate <= LeaseEndDate do begin
                        SingleSameSquare.Init();
                        SingleSameSquare."BLRId" := Rec."BLRId";
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
                        SingleSameSquare."BLRUnit Sq Ft" := Rec."BLRUnit Sq. Feet";
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
                        if Rec."BLRId" = 0 then
                            Error('Contract Renewal ID is missing or not assigned.');
                        LeaseProposal.Reset();
                        LeaseProposal.SetRange("BLRId", Rec."BLRId");
                        if not LeaseProposal.FindFirst() then
                            Error('No record found for Contract Renewal ID %1.', Rec."BLRId");
                        SingleLumSquare.SetRange("BLRID", LeaseProposal."BLRId");
                        if SingleLumSquare.FindSet() then
                            repeat
                                SingleLumSquare.Delete();
                            until SingleLumSquare.Next() = 0;
                        PeriodStartDate := LeaseProposal."BLRContract Start Date";
                        YearCounter := 1;
                        LineNoCounter := 1;
                        while PeriodStartDate <= LeaseProposal."BLRContract End Date" do begin
                            SingleLumSquare.Init();
                            SingleLumSquare."BLRID" := LeaseProposal."BLRId";
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
                            if PeriodEndDate > LeaseProposal."BLRContract End Date" then
                                PeriodEndDate := LeaseProposal."BLRContract End Date";
                            SingleLumSquare."BLRSL_End Date" := PeriodEndDate;
                            TotalDays := PeriodEndDate - PeriodStartDate + 1;
                            SingleLumSquare."BLRSL_Number of Days" := TotalDays;
                            SingleLumSquare."BLRSL_Unit ID" := LeaseProposal."BLRUnit Name";
                            SingleLumSquare."BLRSL_Unit Sq Ft" := LeaseProposal."BLRUnit Sq. Feet";
                            if YearCounter = 1 then begin
                                SingleLumSquare."BLRSL_Annual Amount" := 0;
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
        field(73209633; "BLRMerge Rent Calculation"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Merge Unit Rent Calculation Type';
            OptionMembers = " ","Merged Unit with same square feet","Merged Unit with differential square feet rate","Merged Unit with lumpsum annual amount";
            trigger OnValidate()
            var
                LeaseProposal: Record "BLRContractRenewal";
                MergeSameSquare: Record "BLRCRMergeSameSqureSubPage";
                MergeDiffSquare: Record "BLRCRMergeDifferentSqSubPage";
                MergeLumSquare: Record "BLRCRMergeLumAnnualAmountSP";
                SubLeaseMergeRec: Record "BLRCRSubLeaseMergedUnits";
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
                            MergeSameSquare.SetRange("BLRID", Rec."BLRId");
                            if MergeSameSquare.FindSet() then
                                repeat
                                    MergeSameSquare.Delete();
                                until MergeSameSquare.Next() = 0;

                            // Initialize variables
                            PeriodStartDate := Rec."BLRContract Start Date";
                            LeaseEndDate := Rec."BLRContract End Date";
                            YearCounter := 1;
                            LineNoCounter := 1;

                            // Loop to divide the period into yearly chunks and create records
                            while PeriodStartDate <= LeaseEndDate do begin
                                MergeSameSquare.Init();
                                MergeSameSquare."BLRID" := Rec."BLRId";
                                MergeSameSquare."BLRMS_Line No." := LineNoCounter;
                                MergeSameSquare."BLRMS_Year" := YearCounter;
                                MergeSameSquare."BLRMS_Start Date" := PeriodStartDate;

                                // Calculate the "BLREnd Date" (365 days after "BLRStart Date", adjusted for leap years)
                                DaysToAdd := 365; // Default to 365 days
                                LeapDays := 0;

                                // Check for leap years in the range from "BLRStart Date" to "BLRStart Date" + 364 days
                                for CurrentYear := Date2DMY(PeriodStartDate, 3) to Date2DMY(PeriodStartDate + 364, 3) do
                                    if IsLeapYear(CurrentYear) then
                                        // Ensure the leap day (Feb 29) falls within the range
                                        if (DMY2Date(29, 2, CurrentYear) >= PeriodStartDate) and
                                           (DMY2Date(29, 2, CurrentYear) <= PeriodStartDate + DaysToAdd - 1) then
                                            LeapDays += 1;

                                // Adjust DaysToAdd to account for any leap days
                                DaysToAdd := DaysToAdd + LeapDays;

                                // Calculate the PeriodEndDate
                                PeriodEndDate := PeriodStartDate + DaysToAdd - 1;

                                // Ensure the "BLREnd Date" does not exceed the Lease "BLREnd Date"
                                if PeriodEndDate > LeaseEndDate then
                                    PeriodEndDate := LeaseEndDate;

                                MergeSameSquare."BLRMS_End Date" := PeriodEndDate;

                                // Calculate the number of days for this chunk
                                TotalDays := PeriodEndDate - PeriodStartDate + 1;
                                MergeSameSquare."BLRMS_Number of Days" := TotalDays;

                                // Populate other fields
                                MergeSameSquare."BLRMS_Merged Unit ID" := Rec."BLRUnit Name";
                                MergeSameSquare."BLRMS_Unit Sq Ft" := Rec."BLRUnit Sq. Feet";

                                // Set default values for Rate per Sq.Ft and Annual Amount (to be manually entered)
                                MergeSameSquare."BLRMS_Rate per Sq.Ft" := 0; // Initialize as 0; users will manually enter this
                                MergeSameSquare."BLRMS_Annual Amount" := 0; // Calculated after manual input

                                // Set Final Annual Amount to match Annual Amount
                                MergeSameSquare."BLRMS_Final Annual Amount" := MergeSameSquare."BLRMS_Annual Amount";

                                // Calculate Per Day Rent
                                MergeSameSquare."BLRMS_Per Day Rent" := 0; // Will be calculated after manual input

                                MergeSameSquare.Insert();

                                // Move to the next period
                                PeriodStartDate := PeriodEndDate + 1;
                                YearCounter += 1;
                                LineNoCounter += 1;
                            end;
                        end;

                    "BLRMerge Rent Calculation"::"Merged Unit with lumpsum annual amount":
                        begin

                            if Rec."BLRId" = 0 then
                                Error('ID is missing or not assigned.');

                            LeaseProposal.Reset();
                            LeaseProposal.SetRange("BLRId", Rec."BLRId");

                            if not LeaseProposal.FindFirst() then
                                Error('No record found for ID %1.', Rec."BLRId");

                            // Delete existing records to avoid duplication
                            MergeLumSquare.SetRange("BLRID", LeaseProposal."BLRId");
                            if MergeLumSquare.FindSet() then
                                repeat
                                    MergeLumSquare.Delete();
                                until MergeLumSquare.Next() = 0;

                            PeriodStartDate := LeaseProposal."BLRContract Start Date";
                            YearCounter := 1;
                            LineNoCounter := 1;

                            // Loop through years and create records
                            while PeriodStartDate <= LeaseProposal."BLRContract End Date" do begin
                                // Set the period start date for each year
                                MergeLumSquare.Init();
                                MergeLumSquare."BLRID" := LeaseProposal."BLRId";
                                MergeLumSquare."BLRML_Line No." := LineNoCounter;
                                MergeLumSquare."BLRML_Year" := YearCounter;
                                MergeLumSquare."BLRML_Start Date" := PeriodStartDate;

                                // Default to 365 days, but check for leap years
                                DaysToAdd := 365; // Default to 365 days
                                LeapDays := 0;

                                // Check for leap years in the current period range
                                for CurrentYear := Date2DMY(PeriodStartDate, 3) to Date2DMY(PeriodStartDate + 364, 3) do
                                    if IsLeapYear(CurrentYear) then
                                        // Ensure the leap day (Feb 29) falls within the range
                                        if (DMY2Date(29, 2, CurrentYear) >= PeriodStartDate) and
                                           (DMY2Date(29, 2, CurrentYear) <= PeriodStartDate + DaysToAdd - 1) then
                                            LeapDays += 1;

                                // Adjust DaysToAdd to account for any leap days
                                DaysToAdd := DaysToAdd + LeapDays;

                                // Calculate the period end date
                                PeriodEndDate := PeriodStartDate + DaysToAdd - 1;

                                // Ensure the period end date does not exceed the contract end date
                                if PeriodEndDate > LeaseProposal."BLRContract End Date" then
                                    PeriodEndDate := LeaseProposal."BLRContract End Date";

                                MergeLumSquare."BLRML_End Date" := PeriodEndDate;

                                // Calculate the number of days for this period
                                TotalDays := PeriodEndDate - PeriodStartDate + 1;
                                MergeLumSquare."BLRML_Number of Days" := TotalDays;

                                // Populate fields with the unit and size from LeaseProposal
                                MergeLumSquare."BLRML_Merged Unit ID" := LeaseProposal."BLRUnit Name";
                                MergeLumSquare."BLRML_Unit Sq Ft" := LeaseProposal."BLRUnit Sq. Feet";

                                // For the first year, initialize the Annual Amount and Final Annual Amount
                                if YearCounter = 1 then begin
                                    MergeLumSquare."BLRML_Annual Amount" := 0; // User will enter manually
                                    MergeLumSquare."BLRML_Final Annual Amount" := 0;
                                end;

                                // Calculate Per Day Rent for the period (Annual Amount / Total Days)
                                if TotalDays > 0 then
                                    MergeLumSquare."BLRML_Per Day Rent" := MergeLumSquare."BLRML_Final Annual Amount" / TotalDays
                                else
                                    MergeLumSquare."BLRML_Per Day Rent" := 0;

                                MergeLumSquare.Insert();

                                // Move to the next year and update the line number
                                PeriodStartDate := PeriodEndDate + 1;
                                YearCounter += 1;
                                LineNoCounter += 1;
                            end; // End of the loop for years
                        end;


                    "BLRMerge Rent Calculation"::"Merged Unit with differential square feet rate":
                        begin

                            // Delete existing records with the same "ID" and "MD_Line No."
                            MergeDiffSquare.SetRange("BLRID", Rec."BLRId");
                            if MergeDiffSquare.FindSet() then
                                repeat
                                    MergeDiffSquare.Delete();  // Delete existing records to prevent duplicates
                                until MergeDiffSquare.Next() = 0;

                            // Initialize variables
                            PeriodStartDate := Rec."BLRContract Start Date";
                            LeaseEndDate := Rec."BLRContract End Date";
                            YearCounter := 1;
                            LineNoCounter := 1;

                            // Fetch data from the Sub Lease Merged Units table based on "ID"
                            SubLeaseMergeRec.SetRange("BLRID", Rec."BLRId");

                            // Loop through the Sub Lease Merged Units and fetch relevant data
                            if SubLeaseMergeRec.FindSet() then
                                repeat
                                    // Loop through each year and create records
                                    YearCounter := 1;
                                    PeriodStartDate := Rec."BLRContract Start Date";
                                    LeaseEndDate := Rec."BLRContract End Date";

                                    // Loop to divide the period into yearly chunks and create records for each unit
                                    while PeriodStartDate <= LeaseEndDate do begin
                                        MergeDiffSquare.Init();
                                        MergeDiffSquare."BLRID" := Rec."BLRId";  // Use "ID" here
                                        MergeDiffSquare."BLRMD_Line No." := LineNoCounter;
                                        MergeDiffSquare."BLRMD_Year" := YearCounter;
                                        MergeDiffSquare."BLRMD_Start Date" := PeriodStartDate;

                                        // Calculate the "BLREnd Date" (365 days after "BLRStart Date", adjusted for leap years)
                                        DaysToAdd := 365; // Default to 365 days
                                        LeapDays := 0;

                                        // Check for leap years in the range from "BLRStart Date" to "BLRStart Date" + 364 days
                                        for CurrentYear := Date2DMY(PeriodStartDate, 3) to Date2DMY(PeriodStartDate + 364, 3) do
                                            if IsLeapYear(CurrentYear) then
                                                // Ensure the leap day (Feb 29) falls within the range
                                                if (DMY2Date(29, 2, CurrentYear) >= PeriodStartDate) and
                                                   (DMY2Date(29, 2, CurrentYear) <= PeriodStartDate + DaysToAdd - 1) then
                                                    LeapDays += 1;

                                        // Adjust DaysToAdd to account for any leap days
                                        DaysToAdd := DaysToAdd + LeapDays;

                                        // Calculate the PeriodEndDate
                                        PeriodEndDate := PeriodStartDate + DaysToAdd - 1;

                                        // Ensure the "BLREnd Date" does not exceed the Lease "BLREnd Date"
                                        if PeriodEndDate > LeaseEndDate then
                                            PeriodEndDate := LeaseEndDate;

                                        MergeDiffSquare."BLRMD_End Date" := PeriodEndDate;

                                        // Calculate the number of days for this chunk
                                        TotalDays := PeriodEndDate - PeriodStartDate + 1;
                                        MergeDiffSquare."BLRMD_Number of Days" := TotalDays;

                                        // Populate other fields based on the Sub Lease Merged Units data
                                        MergeDiffSquare."BLRMD_Merged Unit ID" := Rec."BLRUnit Name";
                                        MergeDiffSquare."BLRMD_Unit Sq Ft" := SubLeaseMergeRec."BLRUnit Size"; // From Sub Lease Merged Units
                                        MergeDiffSquare."BLRMD_Unit ID" := CopyStr(SubLeaseMergeRec."BLRSingle Unit Name", 1, StrLen(SubLeaseMergeRec."BLRSingle Unit Name")); // From Sub Lease Merged Units

                                        // Set default values for Rate per Sq.Ft and Annual Amount (to be manually entered)
                                        MergeDiffSquare."BLRMD_Rate per Sq.Ft" := 0; // Initialize as 0; users will manually enter this
                                        MergeDiffSquare."BLRMD_Annual Amount" := 0; // Calculated after manual input

                                        // Set Final Annual Amount to match Annual Amount
                                        MergeDiffSquare."BLRMD_Final Annual Amount" := MergeSameSquare."BLRMS_Annual Amount";

                                        // Calculate Per Day Rent
                                        MergeDiffSquare."BLRMD_Per Day Rent" := 0;
                                        // Will be calculated after manual input

                                        MergeDiffSquare.Insert(); // Insert the record

                                        // Move to the next period
                                        PeriodStartDate := PeriodEndDate + 1;
                                        YearCounter += 1;
                                        LineNoCounter += 1;
                                    end; // End of the while loop

                                until SubLeaseMergeRec.Next() = 0
                            else
                                Error('No matching records found in Sub Lease Merged Units for the given ID.');
                        end;
                end;
            end;

        }

        field(73209634; "BLRSingle Unit Name"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Single Unit Names';
        }

        field(73209635; "BLRRent VAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract VAT Amount';
            Editable = false;

            // trigger OnValidate()
            // begin
            //     "BLRRent VAT Amount" := "BLRAnnual Rent Amount" * ("BLRRent Amount VAT %" / 100);
            // end;
        }

        field(73209636; "BLRRent Amount VAT %"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "0%","5%";
            Caption = 'Contract Amount VAT %';
            Editable = false;
        }

        field(73209637; "BLRRent Amount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Amount Including VAT';
            Editable = false;
        }
        field(73209638; "BLRSecurity Deposit Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209639; "BLROther Fees"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Other Fees ';
        }
        field(73209640; "BLRRefund Conditions"; Text[1000])
        {
            DataClassification = CustomerContent;
        }
        field(73209641; "BLRMaintResp"; Option)
        {
            OptionMembers = Tenant,Landlord;
            DataClassification = CustomerContent;
        }
        field(73209642; "BLRUtilityBillsResp"; Option)
        {
            OptionMembers = Tenant,Landlord;
            DataClassification = CustomerContent;
        }
        field(73209643; "BLRInsurance Requirements"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(73209644; "BLRRent Escalation Clause"; Text[1000])
        {
            DataClassification = CustomerContent;
        }
        field(73209645; "BLREarlyTermCond"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(73209646; "BLRRestrictions"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(73209647; "BLRLegal Jurisdiction"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Legal Jurisdiction (e.g., Dubai Courts)';
        }
        field(73209648; "BLRCalculation Method"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Calculation Method';
            TableRelation = "BLRCalculationType"."BLRCalculation Type";
        }

        field(73209649; "BLRPercentage Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Percentage Type';
            OptionMembers = " ","Fixed","Variable";
        }
        field(73209650; "BLRBase Amount Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Base Amount Type';
            OptionMembers = " ","Revenue","Collection","Annual Rent","Monthly Rent";
        }
        field(73209651; "BLRFrequency Of Payment"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Frequency Of Payment';
            OptionMembers = " ","Monthly","Quaterly","Half Yearly","Yearly";
        }

        field(73209652; "BLRStart Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
            Editable = false;
        }
        field(73209653; "BLREnd Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
            Editable = false;
        }

        field(73209654; "BLRContractStatus"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Status';
            OptionMembers = " ","Active","Terminate";
        }

        field(73209655; "BLRIs any Broker Involved?"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Is any Broker Involved?';
        }

        field(73209656; "BLRVendor ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor ID';
        }
        field(73209657; "BLRVendor Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Vendor Name';
            Editable = false;
        }
        field(73209658; "BLRPercentage"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Percentage';
        }
        field(73209659; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
        field(73209660; "BLRUnit Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Type';
        }
        field(73209661; "BLRUsage Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Usage Type';
        }
        field(73209662; "BLRMunicipality Number"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Municipality Number';

        }
    }
    keys
    {
        key(PK; "BLRId")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "BLRId", "BLRUnit Name", "BLRProperty Name", "BLRTenant Full Name", "BLRTenant ID", "BLRUnit Number")
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
        LeaseStartDate := "BLRContract Start Date";
        LeaseEndDate := "BLRContract End Date";

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

                "BLRContract Tenor" := DelChr(DurationText, '<>', ' ');
            end else
                "BLRContract Tenor" := '';
        end else
            "BLRContract Tenor" := '';
    end;

    local procedure IsLeapYear(Year: Integer): Boolean
    begin
        if (Year mod 4 = 0) and ((Year mod 100 <> 0) or (Year mod 400 = 0)) then
            exit(true);
        exit(false);
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
        deleteSingleUnitRecords: Record "BLRCRSingleUnitRentSubPage";

    begin
        deleteSingleUnitRecords.SetRange("BLRId", Rec."BLRProposal ID");

        if deleteSingleUnitRecords.FindSet() then
            deleteSingleUnitRecords.DeleteAll();
    end;

    procedure DeleteAdditionalTerms()
    var
        RenewalAdditionalTerms: Record "BLRRenewalAdditionalTerms";
    begin
        RenewalAdditionalTerms.SetRange("BLRDocument No.", Rec."BLRId");

        if RenewalAdditionalTerms.FindSet() then
            RenewalAdditionalTerms.DeleteAll();
    end;


    procedure DeleteMergeUnitSameRate()
    var
        deleteMergeUnitRecords: Record "BLRCRMergeSameSqureSubPage";

    begin
        deleteMergeUnitRecords.SetRange("BLRID", Rec."BLRProposal ID");

        if deleteMergeUnitRecords.FindSet() then
            deleteMergeUnitRecords.DeleteAll();
    end;

    procedure DeletePerDayRevenueUnitSameRate()
    var
        deletePerDayRevenueUnitRecords: Record "BLRCRPerDayRentforRevenue";

    begin
        deletePerDayRevenueUnitRecords.SetRange("BLRProposal Id", Rec."BLRProposal ID");

        if deletePerDayRevenueUnitRecords.FindSet() then
            deletePerDayRevenueUnitRecords.DeleteAll();
    end;

    procedure DeleteLeaseMergeAllUnitDetails()
    var
        deleteAllUnitRecords: Record "BLRCRSubLeaseMergedUnits";

    begin
        deleteAllUnitRecords.SetRange("BLRID", Rec."BLRProposal ID");

        if deleteAllUnitRecords.FindSet() then
            deleteAllUnitRecords.DeleteAll();
    end;

    procedure DeleteMergeUnitDiffRate()
    var
        deleteMergeUnitDiffRecords: Record "BLRCRMergeDifferentSqSubPage";

    begin
        deleteMergeUnitDiffRecords.SetRange("BLRID", Rec."BLRProposal ID");

        if deleteMergeUnitDiffRecords.FindSet() then
            deleteMergeUnitDiffRecords.DeleteAll();
    end;

    procedure DeleteMergeUnitLumpsumRate()
    var
        deleteMergeUnitLumpsumRecords: Record "BLRCRMergeLumAnnualAmountSP";

    begin
        deleteMergeUnitLumpsumRecords.SetRange("BLRID", Rec."BLRProposal ID");

        if deleteMergeUnitLumpsumRecords.FindSet() then
            deleteMergeUnitLumpsumRecords.DeleteAll();
    end;

    procedure DeleteSingleUnitLumpsumRate()
    var
        deleteSingleUnitLumpsumRecords: Record "BLRCRSingleLumAnnualAmntSP";

    begin
        deleteSingleUnitLumpsumRecords.SetRange("BLRID", Rec."BLRProposal ID");

        if deleteSingleUnitLumpsumRecords.FindSet() then
            deleteSingleUnitLumpsumRecords.DeleteAll();
    end;
}
