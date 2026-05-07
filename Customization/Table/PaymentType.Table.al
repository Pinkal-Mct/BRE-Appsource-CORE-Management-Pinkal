table 73209652 "Payment Type"
{
    DataClassification = SystemMetadata;
    DataCaptionFields = "Payment ID";
    fields
    {
        field(73209575; "Payment ID"; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
            Editable = false;
        }
        field(73209576; "Payment Method"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Payment Method';
        }
    }
    keys
    {
        key(PK; "Payment ID", "Payment Method")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Payment ID", "Payment Method")
        {
        }
    }
}
