tableextension 73209592 "BLRVendor Ext" extends Vendor
{
    fields
    {
        field(73209575; "BLRCountry"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Country';
            TableRelation = "BLRCountry";
            trigger OnValidate()
            var
                country: Record "BLRCountry";
            begin
                if country.Get(Rec."BLRCountry") then
                    Rec."BLRCountry" := country."BLRCountry Code";
            end;
        }
        field(73209576; "BLREmirate Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Emirate';
            TableRelation = "BLREmirate"."BLRID"
                 where("BLRCountry Code" = field("BLRCountry"));
            trigger OnValidate()
            var
                emirate: Record "BLREmirate";
                emirateID: Integer;
            begin
                Evaluate(emirateID, "BLREmirate Name");
                emirate.SetRange("BLRID", emirateID);
                if emirate.FindFirst() then begin
                    "BLREmirate Name" := Format(emirate."BLREmirate Name");
                    "BLRCommunity" := '';
                end else
                    Error('Invalid Emirate Name: %1', "BLREmirate Name");
            end;
        }
        field(73209577; "BLRCommunity"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Community';
            TableRelation = "BLRCommunity" where("BLREmirate Name" = field("BLREmirate Name"));

            trigger OnValidate()
            var
                communityRec: Record "BLRCommunity";
            begin
                if communityRec.Get("BLRCommunity") then
                    "BLRCommunity" := communityRec."BLRCommunity Name";
            end;
        }
        field(73209578; "BLRVendor Category"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor Category';
            TableRelation = "BLRVendorCategory"."BLRVendor Category Type";
        }
    }
}
