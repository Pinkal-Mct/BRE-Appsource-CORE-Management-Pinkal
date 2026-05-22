table 73209632 "BLRManagementFeeMasterData"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "BLRVendor ID";
    fields
    {
        field(73209575; "BLRManagement Fee Number"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Management Fee Number';

        }
        field(73209576; "BLRVendor ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor ID';

            trigger OnValidate()
            var
                vendorrec: Record Vendor;
            begin
                vendorrec.Get(Rec."BLRVendor ID");
                Rec."BLRVendor Name" := vendorrec.Name;
            end;

        }
        field(73209577; "BLRVendor Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Vendor Name';
        }
    }
    keys
    {
        key(PK;"BLRManagement Fee Number", "BLRVendor ID")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown;"BLRVendor ID", "BLRVendor Name")
        {

        }
    }

    trigger OnInsert()
    var
        noSeriesSetup: Record "BLRNoSeriesSetup";
        noseries: Codeunit "No. Series";
    begin
        if noSeriesSetup.Get() then
            Rec."BLRManagement Fee Number" := noseries.GetNextNo(noSeriesSetup."BLRManagement Fee Master")
        else
            Error('No. Series Setup not found for Management fee Nos.');
    end;

    trigger OnDelete()
    var
        ManagementFeeGrid: Record "BLRManagementFeeGrid";
    begin
        ManagementFeeGrid.SetRange("BLRManagement Fee Number", Rec."BLRManagement Fee Number");
        if ManagementFeeGrid.FindSet() then
            ManagementFeeGrid.DeleteAll();
    end;
}
