table 73209652 "BLRPaymentType"
{
    DataClassification = SystemMetadata;
    DataCaptionFields = "BLRPayment ID";
    fields
    {
        field(73209575; "BLRPayment ID"; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
            Editable = false;
        }
        field(73209576; "BLRPayment Method"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Payment Method';
        }
    }
    keys
    {
        key(PK;"BLRPayment ID", "BLRPayment Method")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown;"BLRPayment ID", "BLRPayment Method")
        {
        }
    }
}
