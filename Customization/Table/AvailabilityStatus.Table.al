table 73209581 "Availability Status"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "ID";

    fields
    {
        field(73209575; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true; // Automatically increment the ID
            Editable = false; // Make it read-only for the user
        }
        field(73209576; "Status"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Status Name';

        }
    }

    keys
    {
        key(PK; "ID", "Status")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; ID, "Status")
        {

        }
    }



}
