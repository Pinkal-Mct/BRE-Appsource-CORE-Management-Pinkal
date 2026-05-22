table 73209590 "BLRCalculationType"
{
    DataClassification = SystemMetadata;
    DataCaptionFields = "BLRID";
    fields
    {
        field(73209575; "BLRID"; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
            Editable = false;
        }
        field(73209576; "BLRCalculation Type"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Calculation Type';
        }
    }
    keys
    {
        key(PK;"BLRID", "BLRCalculation Type")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown;"BLRID", "BLRCalculation Type")
        {
        }
    }
}
