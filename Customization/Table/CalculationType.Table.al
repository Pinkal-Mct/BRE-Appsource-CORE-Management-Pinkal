table 73209590 "Calculation Type"
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
        field(73209576; "Calculation Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Calculation Type';
        }
    }
    keys
    {
        key(PK; "ID", "Calculation Type")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; ID, "Calculation Type")
        {
        }
    }
}
