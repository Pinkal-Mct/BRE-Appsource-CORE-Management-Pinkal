tableextension 73209592 "Vendor Ext" extends Vendor
{
    fields
    {
        field(73209575; "Country"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Country';
            TableRelation = Country;
            trigger OnValidate()
            var
                country: Record Country;
            begin
                if country.Get(Rec.Country) then
                    Rec.Country := country."Country Code";
            end;
        }
        field(73209576; "Emirate Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Emirate';
            TableRelation = Emirate.ID
                 where("Country Code" = field(Country));
            trigger OnValidate()
            var
                emirate: Record "Emirate";
                emirateID: Integer;
            begin
                Evaluate(emirateID, "Emirate Name");
                emirate.SetRange(ID, emirateID);
                if emirate.FindFirst() then begin
                    "Emirate Name" := Format(emirate."Emirate Name");
                    Community := '';
                end else
                    Error('Invalid Emirate Name: %1', "Emirate Name");
            end;
        }
        field(73209577; "Community"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Community';
            TableRelation = Community where("Emirate Name" = field("Emirate Name"));

            trigger OnValidate()
            var
                communityRec: Record Community;
            begin
                if communityRec.Get(Community) then
                    Community := communityRec."Community Name";
            end;
        }
        field(73209578; "Vendor Category"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor Category';
            TableRelation = "Vendor Category"."Vendor Category Type";
        }
    }
}
