table 73209632 "Management Fee MasterData"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "Vendor ID";
    fields
    {
        field(73209575; "Management Fee Number"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Management Fee Number';

        }
        field(73209576; "Vendor ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor ID';

            trigger OnValidate()
            var
                vendorrec: Record Vendor;
            begin
                vendorrec.Get(Rec."Vendor ID");
                Rec."Vendor Name" := vendorrec.Name;
            end;

        }
        field(73209577; "Vendor Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Vendor Name';
        }
    }
    keys
    {
        key(PK; "Management Fee Number", "Vendor ID")
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

    trigger OnInsert()
    var
        noSeriesSetup: Record "No. Series Setup";
        noseries: Codeunit "No. Series";
    begin
        if noSeriesSetup.Get() then
            Rec."Management Fee Number" := noseries.GetNextNo(noSeriesSetup."Management Fee Master")
        else
            Error('No. Series Setup not found for Management fee Nos.');
    end;

    trigger OnDelete()
    var
        ManagementFeeGrid: Record "Management Fee Grid";
    begin
        ManagementFeeGrid.SetRange("Management Fee Number", Rec."Management Fee Number");
        if ManagementFeeGrid.FindSet() then
            ManagementFeeGrid.DeleteAll();
    end;
}
