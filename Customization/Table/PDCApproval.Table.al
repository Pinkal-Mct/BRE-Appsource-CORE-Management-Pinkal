table 73209653 "PDC Approval"
{
    DataClassification = CustomerContent;
    DataCaptionFields = SystemId;
    fields
    {
        field(73209575; Id; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209576; Status; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(73209577; "PDC Id"; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209578; Tenant_Id; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209579; Contract_Id; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209580; Check_No; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209581; Deposite_Bank; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209582; Total_Amount; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209583; Due_Date; Date)
        {
            DataClassification = CustomerContent;
        }
        field(73209584; View; Text[2048])
        {
            DataClassification = CustomerContent;
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
