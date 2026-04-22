table 73209653 "PDC Approval"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = SystemId;
    fields
    {
        field(73209575; Id; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(73209576; Status; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(73209577; "PDC Id"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(73209578; Tenant_Id; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(73209579; Contract_Id; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(73209580; Check_No; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(73209581; Deposite_Bank; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(73209582; Total_Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73209583; Due_Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(73209584; View; Text[2048])
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(Key1; Id)
        {
            Clustered = true;
        }
    }

}