table 73209651 "Payment Transaction"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "PT Id";
    fields
    {
        field(73209575; "PT Id"; Code[50])
        {
            DataClassification = ToBeClassified;

        }

        field(73209576; "Tenant Id"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(73209577; "Tenant Name"; Text[100])
        {

            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Tenant Id"))); // Displays Customer Name
        }

        field(73209578; "Contract Id"; Integer)
        {

            TableRelation = "Tenancy Contract";
        }

        field(73209579; "Approval Status"; Enum "Approval Status Enum")
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "PT Id")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit "No. Series";

    begin
        if "PT Id" = '' then
            "PT Id" := NoSeriesMgt.GetNextNo('PT-ID', Today(), true);
    end;


}