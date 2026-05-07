table 73209712 "Vendor Profile"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "Vendor ID";
    fields
    {
        field(73209575; "Vendor ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor ID';
            TableRelation = Vendor."No." WHERE("Vendor Category" = FILTER('Property Management System' | 'Brokers and Commission Agent'));
            trigger OnValidate()
            var
                vendor: Record Vendor;
            begin
                vendor.SetRange("No.", Rec."Vendor ID");
                if vendor.FindFirst() then begin
                    Rec."Vendor ID" := vendor."No.";
                    "Vendor Name" := vendor."Name";
                    "Search Name" := vendor."Search Name";
                    "Vendor Contact No." := Vendor.Contact;
                    "Vendor Category" := vendor."Vendor Category";
                    "Blocked" := Vendor."Blocked";
                    "Privacy Blocked" := Vendor."Privacy Blocked";
                    "IC Partner Code" := Vendor."IC Partner Code";
                    "Purchaser Code" := Vendor."Purchaser Code";
                    "Responsibility Center" := Vendor."Responsibility Center";
                    "Disable Search by Name" := Vendor."Disable Search by Name";
                    "Company Size Code" := Vendor."Company Size Code";
                    "Last Date Modified" := Vendor."Last Date Modified";
                    "Document Sending Profile" := Vendor."Document Sending Profile";
                    "Balance (LCY)" := Vendor."Balance (LCY)";
                    "Balance Due (LCY)" := Vendor."Balance Due (LCY)";
                    Address := Vendor.Address;
                    "Address 2" := Vendor."Address 2";
                    "Country" := Vendor.County;
                    "Emirate" := vendor."Emirate Name";
                    "Community" := vendor.Community;
                    "Phone No." := Vendor."Phone No.";
                    "Mobile Phone No." := Vendor."Mobile Phone No.";
                    "E-Mail" := Vendor."E-Mail";
                    "Our Account No." := Vendor."Our Account No.";
                    "Primary Contact Code" := Vendor."Primary Contact No.";
                    "VAT Registration No." := Vendor."VAT Registration No.";
                    "Price Calculation Method" := Vendor."Price Calculation Method";
                    "Price Including VAT" := Vendor."Prices Including VAT";
                    "Application Method" := Vendor."Application Method";
                    "Payment Terms Code" := Vendor."Payment Terms Code";
                    "Payment Method Code" := Vendor."Payment Method Code";
                    Priority := Vendor.Priority;
                    "Block Payment Tolerance" := Vendor."Block Payment Tolerance";
                    "Preferred Bank Account Code" := Vendor."Preferred Bank Account Code";
                    "Partner Type" := Vendor."Partner Type";
                    "Cash Flow Payment Terms Code" := Vendor."Cash Flow Payment Terms Code";
                    "Creditor No." := Vendor."Creditor No.";
                    "Location Code" := Vendor."Location Code";
                    "Shipment Method Code" := Vendor."Shipment Method Code";
                    "Lead Time Calculation" := Vendor."Lead Time Calculation";
                    "Base Calendar Code" := Vendor."Base Calendar Code";
                    "Over-Receipt Code" := Vendor."Over-Receipt Code";
                end;
            end;
        }
        field(73209576; "Vendor Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Vendor Name';
            Editable = false;
        }
        field(73209577; "Vendor Contact No."; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Vendor Contact No.';
            Editable = false;
        }
        field(73209578; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
        }
        field(73209579; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
        }
        field(73209580; "Vendor Category"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor Category';
            TableRelation = "Vendor Category"."Vendor Category Type";
        }
        field(73209581; "Contract Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Status';
            OptionMembers = " ","Active","Terminate";
        }
        field(73209582; "Blocked"; Enum "Vendor Blocked")
        {
            DataClassification = CustomerContent;
            Caption = 'Blocked';
            Editable = false;
        }
        field(73209583; "Balance (LCY)"; Decimal)
        {
            Caption = 'Balance (LCY)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209584; "Balance Due (LCY)"; Decimal)
        {
            Caption = 'Balance Due (LCY)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209585; Address; Text[100])
        {
            Caption = 'Address';
            Editable = false;
            DataClassification = EndUserIdentifiableInformation;
        }
        field(73209586; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            Editable = false;
            DataClassification = EndUserIdentifiableInformation;
        }
        field(73209587; Country; Text[30])
        {
            Caption = 'Country';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209588; Emirate; Text[50])
        {
            Caption = 'Emirate';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209589; Community; Text[100])
        {
            Caption = 'Community';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209590; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            Editable = false;
            DataClassification = EndUserIdentifiableInformation;
        }
        field(73209591; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
            Editable = false;
            DataClassification = EndUserIdentifiableInformation;
        }
        field(73209592; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            Editable = false;
            DataClassification = EndUserIdentifiableInformation;
        }
        field(73209593; "Home Page"; Text[80])
        {
            Caption = 'Home Page';
            Editable = false;
            DataClassification = EndUserIdentifiableInformation;
        }
        field(73209594; "Our Account No."; Text[20])
        {
            Caption = 'Our Account No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209595; "Primary Contact Code"; Code[80])
        {
            Caption = 'Primary Contact Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209596; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
            Editable = false;
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(73209597; "Price Calculation Method"; Enum "Price Calculation Method")
        {
            Caption = 'Price Calculation Method';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209598; "Price Including VAT"; Boolean)
        {
            Caption = 'Price Including VAT';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209599; "Application Method"; Enum "Application Method")
        {
            DataClassification = CustomerContent;
            Caption = 'Application Method';
            Editable = false;
        }
        field(73209600; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209601; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209602; Priority; Integer)
        {
            Caption = 'Priority';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209603; "Block Payment Tolerance"; Boolean)
        {
            Caption = 'Block Payment Tolerance';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209604; "Preferred Bank Account Code"; Code[100])
        {
            Caption = 'Preferred Bank Account Code';
            Editable = false;
            DataClassification = AccountData;
        }
        field(73209605; "Partner Type"; Enum "Partner Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Partner Type';
            Editable = false;
        }
        field(73209606; "Cash Flow Payment Terms Code"; Code[100])
        {
            Caption = 'Cash Flow Payment Terms Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209607; "Creditor No."; Code[100])
        {
            Caption = 'Creditor No.';
            Editable = false;
            DataClassification = AccountData;
        }
        field(73209608; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209609; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209610; "Lead Time Calculation"; DateFormula)
        {
            Caption = 'Lead Time Calculation';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209611; "Base Calendar Code"; Code[10])
        {
            Caption = 'Base Calendar Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209612; "Over-Receipt Code"; Code[20])
        {
            Caption = 'Over-Receipt Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209613; "Receive E-Document To"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Receive E-Document To';
            OptionMembers = " ","Purchase Order","Purchase Invoice";
            Editable = false;
        }
        field(73209614; "Privacy Blocked"; Boolean)
        {
            Caption = 'Privacy Blocked';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209615; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209616; "Document Sending Profile"; Code[20])
        {
            Caption = 'Document Sending Profile';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209617; "Search Name"; Code[100])
        {
            Caption = 'Search Name';
            Editable = false;
            DataClassification = EndUserIdentifiableInformation;
        }
        field(73209618; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209619; "Purchaser Code"; Code[20])
        {
            Caption = 'Purchaser Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209620; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209621; "Disable Search by Name"; Boolean)
        {
            Caption = 'Disable Search by Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209622; "Company Size Code"; Code[20])
        {
            Caption = 'Company Size Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209623; "Percentage"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Percentage';
        }
        field(73209624; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
        field(73209625; "Calculation Method"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Calculation Method';
            TableRelation = "Calculation Type"."Calculation Type";
        }
        field(73209626; "Percentage Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Percentage Type';
            OptionMembers = " ","Fixed","Variable";
        }
        field(73209627; "Base Amount Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Base Amount Type';
            OptionMembers = " ","Revenue","Collection","Annual Rent","Monthly Rent";
        }
        field(73209628; "Frequency Of Payment"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Frequency Of Payment';
            OptionMembers = " ","Monthly","Quaterly","Half Yearly","Yearly";
        }
    }
    keys
    {
        key(PK; "Vendor ID", "Vendor Name")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Vendor ID", "Vendor Name")
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
        VendorDoc: Record "Vendor Contract Document";
    begin
        VendorDoc.SetRange("Vendor Id", Rec."Vendor ID");
        if VendorDoc.FindSet() then
            VendorDoc.DeleteAll();
    end;

    procedure DeleteVendorDocument()
    var
        VendorDoc: Record "Vendor Document";
    begin
        VendorDoc.SetRange("Vendor Id", Rec."Vendor ID");
        if VendorDoc.FindSet() then
            VendorDoc.DeleteAll();
    end;

    procedure DeleteVendorCalculationDetails()
    var
        VendorDoc: Record "Vendor Calculation Details";
    begin
        VendorDoc.SetRange("Vendor Id", Rec."Vendor ID");
        if VendorDoc.FindSet() then
            VendorDoc.DeleteAll();
    end;
}
