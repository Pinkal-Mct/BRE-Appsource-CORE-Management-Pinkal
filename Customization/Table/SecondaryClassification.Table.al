table 73209683 "Secondary Classification"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = ID;
    fields
    {
        field(73209575; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
        }
        field(73209576; "Classification Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary Classification';
            TableRelation = "Primary Classification"."Classification Name";
        }
        field(73209577; "Property Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Type';
        }
    }
    keys
    {
        key(PK; "ID", "Property Type")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; ID, "Classification Name", "Property Type")
        {
        }
    }
}
