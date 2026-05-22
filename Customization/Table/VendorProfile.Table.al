table 73209712 "BLRVendorProfile"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "BLRVendor ID";
    fields
    {
        field(73209575; "BLRVendor ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor ID';
            TableRelation = Vendor."No." WHERE("BLRVendor Category" = FILTER('Property Management System' | 'Brokers and Commission Agent'));
            trigger OnValidate()
            var
                vendor: Record Vendor;
            begin
                vendor.SetRange("No.", Rec."BLRVendor ID");
                if vendor.FindFirst() then begin
                    Rec."BLRVendor ID" := vendor."No.";
                    "BLRVendor Name" := vendor."Name";
                    "BLRSearch Name" := vendor."Search Name";
                    "BLRVendor Contact No." := Vendor.Contact;
                    "BLRVendor Category" := vendor."BLRVendor Category";
                    "BLRBlocked" := Vendor."Blocked";
                    "BLRPrivacy Blocked" := Vendor."Privacy Blocked";
                    "BLRIC Partner Code" := Vendor."IC Partner Code";
                    "BLRPurchaser Code" := Vendor."Purchaser Code";
                    "BLRResponsibility Center" := Vendor."Responsibility Center";
                    "BLRDisable Search by Name" := Vendor."Disable Search by Name";
                    "BLRCompany Size Code" := Vendor."Company Size Code";
                    "BLRLast Date Modified" := Vendor."Last Date Modified";
                    "BLRDocument Sending Profile" := Vendor."Document Sending Profile";
                    "BLRBalance (LCY)" := Vendor."Balance (LCY)";
                    "BLRBalance Due (LCY)" := Vendor."Balance Due (LCY)";
                    "BLRAddress" := Vendor.Address;
                    "BLRAddress 2" := Vendor."Address 2";
                    "BLRCountry" := Vendor.County;
                    "BLREmirate" := vendor."BLREmirate Name";
                    "BLRCommunity" := vendor.BLRCommunity;
                    "BLRPhone No." := Vendor."Phone No.";
                    "BLRMobile Phone No." := Vendor."Mobile Phone No.";
                    "BLRE-Mail" := Vendor."E-Mail";
                    "BLROur Account No." := Vendor."Our Account No.";
                    "BLRPrimary Contact Code" := Vendor."Primary Contact No.";
                    "BLRVAT Registration No." := Vendor."VAT Registration No.";
                    "BLRPrice Calculation Method" := Vendor."Price Calculation Method";
                    "BLRPrice Including VAT" := Vendor."Prices Including VAT";
                    "BLRApplication Method" := Vendor."Application Method";
                    "BLRPayment Terms Code" := Vendor."Payment Terms Code";
                    "BLRPayment Method Code" := Vendor."Payment Method Code";
                    "BLRPriority" := Vendor.Priority;
                    "BLRBlock Payment Tolerance" := Vendor."Block Payment Tolerance";
                    "BLRPreferred Bank Account Code" := Vendor."Preferred Bank Account Code";
                    "BLRPartner Type" := Vendor."Partner Type";
                    "BLRCashFlowPmtTermsCode" := Vendor."Cash Flow Payment Terms Code";
                    "BLRCreditor No." := Vendor."Creditor No.";
                    "BLRLocation Code" := Vendor."Location Code";
                    "BLRShipment Method Code" := Vendor."Shipment Method Code";
                    "BLRLead Time Calculation" := Vendor."Lead Time Calculation";
                    "BLRBase Calendar Code" := Vendor."Base Calendar Code";
                    "BLROver-Receipt Code" := Vendor."Over-Receipt Code";
                end;
            end;
        }
        field(73209576; "BLRVendor Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Vendor Name';
            Editable = false;
        }
        field(73209577; "BLRVendor Contact No."; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Vendor Contact No.';
            Editable = false;
        }
        field(73209578; "BLRStart Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
        }
        field(73209579; "BLREnd Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
        }
        field(73209580; "BLRVendor Category"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor Category';
            TableRelation = "BLRVendorCategory"."BLRVendor Category Type";
        }
        field(73209581; "BLRContract Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Status';
            OptionMembers = " ","Active","Terminate";
        }
        field(73209582; "BLRBlocked"; Enum "Vendor Blocked")
        {
            DataClassification = CustomerContent;
            Caption = 'Blocked';
            Editable = false;
        }
        field(73209583; "BLRBalance (LCY)"; Decimal)
        {
            Caption = 'Balance (LCY)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209584; "BLRBalance Due (LCY)"; Decimal)
        {
            Caption = 'Balance Due (LCY)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209585; "BLRAddress"; Text[100])
        {
            Caption = 'Address';
            Editable = false;
            DataClassification = EndUserIdentifiableInformation;
        }
        field(73209586; "BLRAddress 2"; Text[50])
        {
            Caption = 'Address 2';
            Editable = false;
            DataClassification = EndUserIdentifiableInformation;
        }
        field(73209587; "BLRCountry"; Text[30])
        {
            Caption = 'Country';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209588; "BLREmirate"; Text[50])
        {
            Caption = 'Emirate';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209589; "BLRCommunity"; Text[100])
        {
            Caption = 'Community';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209590; "BLRPhone No."; Text[30])
        {
            Caption = 'Phone No.';
            Editable = false;
            DataClassification = EndUserIdentifiableInformation;
        }
        field(73209591; "BLRMobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
            Editable = false;
            DataClassification = EndUserIdentifiableInformation;
        }
        field(73209592; "BLRE-Mail"; Text[80])
        {
            Caption = 'Email';
            Editable = false;
            DataClassification = EndUserIdentifiableInformation;
        }
        field(73209593; "BLRHome Page"; Text[80])
        {
            Caption = 'Home Page';
            Editable = false;
            DataClassification = EndUserIdentifiableInformation;
        }
        field(73209594; "BLROur Account No."; Text[20])
        {
            Caption = 'Our Account No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209595; "BLRPrimary Contact Code"; Code[80])
        {
            Caption = 'Primary Contact Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209596; "BLRVAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
            Editable = false;
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(73209597; "BLRPrice Calculation Method"; Enum "Price Calculation Method")
        {
            Caption = 'Price Calculation Method';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209598; "BLRPrice Including VAT"; Boolean)
        {
            Caption = 'Price Including VAT';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209599; "BLRApplication Method"; Enum "Application Method")
        {
            DataClassification = CustomerContent;
            Caption = 'Application Method';
            Editable = false;
        }
        field(73209600; "BLRPayment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209601; "BLRPayment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209602; "BLRPriority"; Integer)
        {
            Caption = 'Priority';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209603; "BLRBlock Payment Tolerance"; Boolean)
        {
            Caption = 'Block Payment Tolerance';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209604; "BLRPreferred Bank Account Code"; Code[100])
        {
            Caption = 'Preferred Bank Account Code';
            Editable = false;
            DataClassification = AccountData;
        }
        field(73209605; "BLRPartner Type"; Enum "Partner Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Partner Type';
            Editable = false;
        }
        field(73209606; "BLRCashFlowPmtTermsCode"; Code[100])
        {
            Caption = 'Cash Flow Payment Terms Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209607; "BLRCreditor No."; Code[100])
        {
            Caption = 'Creditor No.';
            Editable = false;
            DataClassification = AccountData;
        }
        field(73209608; "BLRLocation Code"; Code[10])
        {
            Caption = 'Location Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209609; "BLRShipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209610; "BLRLead Time Calculation"; DateFormula)
        {
            Caption = 'Lead Time Calculation';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209611; "BLRBase Calendar Code"; Code[10])
        {
            Caption = 'Base Calendar Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209612; "BLROver-Receipt Code"; Code[20])
        {
            Caption = 'Over-Receipt Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209613; "BLRReceive E-Document To"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Receive E-Document To';
            OptionMembers = " ","Purchase Order","Purchase Invoice";
            Editable = false;
        }
        field(73209614; "BLRPrivacy Blocked"; Boolean)
        {
            Caption = 'Privacy Blocked';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209615; "BLRLast Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209616; "BLRDocument Sending Profile"; Code[20])
        {
            Caption = 'Document Sending Profile';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209617; "BLRSearch Name"; Code[100])
        {
            Caption = 'Search Name';
            Editable = false;
            DataClassification = EndUserIdentifiableInformation;
        }
        field(73209618; "BLRIC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209619; "BLRPurchaser Code"; Code[20])
        {
            Caption = 'Purchaser Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209620; "BLRResponsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209621; "BLRDisable Search by Name"; Boolean)
        {
            Caption = 'Disable Search by Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209622; "BLRCompany Size Code"; Code[20])
        {
            Caption = 'Company Size Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209623; "BLRPercentage"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Percentage';
        }
        field(73209624; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
        field(73209625; "BLRCalculation Method"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Calculation Method';
            TableRelation = "BLRCalculationType"."BLRCalculation Type";
        }
        field(73209626; "BLRPercentage Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Percentage Type';
            OptionMembers = " ","Fixed","Variable";
        }
        field(73209627; "BLRBase Amount Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Base Amount Type';
            OptionMembers = " ","Revenue","Collection","Annual Rent","Monthly Rent";
        }
        field(73209628; "BLRFrequency Of Payment"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Frequency Of Payment';
            OptionMembers = " ","Monthly","Quaterly","Half Yearly","Yearly";
        }
    }
    keys
    {
        key(PK; "BLRVendor ID", "BLRVendor Name")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "BLRVendor ID", "BLRVendor Name")
        {
        }
    }
    trigger OnDelete()
    var
    begin
        DeleteVendorContractDocument();
        DeleteVendorDocument();
        DeleteVendorCalculationDetails();
    end;

    procedure DeleteVendorContractDocument()
    var
        VendorDoc: Record "BLRVendorContractDocument";
    begin
        VendorDoc.SetRange("BLRVendor ID", Rec."BLRVendor ID");
        if VendorDoc.FindSet() then
            VendorDoc.DeleteAll();
    end;

    procedure DeleteVendorDocument()
    var
        VendorDoc: Record "BLRVendorDocument";
    begin
        VendorDoc.SetRange("BLRVendor ID", Rec."BLRVendor ID");
        if VendorDoc.FindSet() then
            VendorDoc.DeleteAll();
    end;

    procedure DeleteVendorCalculationDetails()
    var
        VendorDoc: Record "BLRVendorCalculationDetails";
    begin
        VendorDoc.SetRange("BLRVendor ID", Rec."BLRVendor ID");
        if VendorDoc.FindSet() then
            VendorDoc.DeleteAll();
    end;
}
