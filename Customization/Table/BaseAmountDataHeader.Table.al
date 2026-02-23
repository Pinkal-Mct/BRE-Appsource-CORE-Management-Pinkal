table 53768 "Base Amount Data Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(53700; "Header No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(53701; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(53702; "Base Amount Type"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53703; "No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
    }
    keys
    {
        key("PK"; "No.", "Header No.", "Line No.")
        {
            Clustered = true;
        }
    }
}

