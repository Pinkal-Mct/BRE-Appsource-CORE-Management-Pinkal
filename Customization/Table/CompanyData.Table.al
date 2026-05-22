table 73209598 "BLRCompanyData"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "BLRCompany ID";

    fields
    {
        field(73209575; "BLRCompany ID"; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }

        field(73209576; "BLRCompany Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(73209577; "BLRCompany Logo"; Text[50])
        {
            DataClassification = CustomerContent;

        }

        field(73209578; "BLRLogo URL"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Logo URL';
        }
        field(73209579; "BLRView Document URL"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'View Document URL';
        }
        field(73209580; "BLRTenant id"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'View Document URL';
            Editable = false;
        }
        field(73209581; "BLREnvironment Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Environment Name';
            Editable = false;
        }

        field(73209582; "BLRAccess Validity"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Access Validity (Days)';
            Editable = true;
        }
        field(73209583; "BLRAPI URL"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'API URL';
            Editable = true;
        }
        field(73209584; "BLRRevenue Methods"; Option)
        {
            OptionMembers = " ","Fixed Monthly Rent","Per Day Rent";
            Caption = 'Revenue Methods';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK;"BLRCompany ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"BLRCompany ID", "BLRCompany Name")
        {

        }
    }

    //--------------Record Insertion-----------------//
    trigger OnInsert()
    var
        CompanyInfo: Record "Company Information";
        Msg: Label 'Tenant Id is ''%1''.\Tenant Guid is ''%2''.', Comment = '%1=Tenant Id, %2=Tenant Guid';
        BCURLList: List of [Text];
        TenantIdTxt: Text;
        TenantGuidTxt: Text;
        EnvironmentNameTxt: Text;

    begin
        if CompanyInfo.Get() then
            "BLRCompany Name" := CompanyInfo.Name;

        TenantIdTxt := TenantId();
        BCURLList := GetUrl(ClientType::Web).Split('/');
        TenantGuidTxt := BCURLList.Get(4);
        EnvironmentNameTxt := BCURLList.Get(5);

        "BLRTenant id" := CopyStr(TenantGuidTxt, 1, StrLen(TenantGuidTxt));
        "BLREnvironment Name" := CopyStr(EnvironmentNameTxt, 1, StrLen(EnvironmentNameTxt));

        Message(Msg, TenantIdTxt, TenantGuidTxt);
    end;
}
