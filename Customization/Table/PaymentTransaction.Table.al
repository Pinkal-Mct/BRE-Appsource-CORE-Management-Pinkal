table 73209651 "BLRPaymentTransaction"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "BLRPT Id";
    fields
    {
        field(73209575; "BLRPT Id"; Code[50])
        {
            DataClassification = CustomerContent;

        }

        field(73209576; "BLRTenant Id"; code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";
        }
        field(73209577; "BLRTenant Name"; Text[100])
        {

            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("BLRTenant Id"))); // Displays Customer Name
        }

        field(73209578; "BLRContract Id"; Integer)
        {

            TableRelation = "BLRTenancyContract";
            DataClassification = CustomerContent;
        }

        field(73209579; "BLRApproval Status"; Enum "BLRApproval Status Enum")
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "BLRPT Id")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit "No. Series";

    begin
        if "BLRPT Id" = '' then
            "BLRPT Id" := NoSeriesMgt.GetNextNo('PT-ID', Today(), true);
    end;


}
