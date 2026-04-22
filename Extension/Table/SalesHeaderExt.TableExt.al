tableextension 73209586 "Sales Header Ext" extends "Sales Header"
{
    fields
    {
        field(73209575; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(73209576; "Property Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Name';
        }
        field(73209577; "Unit Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Name';
        }
        field(73209578; "Contract Tenure"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Tenure';
        }
        field(73209579; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Approved,Rejected;
            Caption = 'Approval Status';
        }
        field(73209580; "Tenant Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Name';
        }
        field(73209581; "Customer P.O"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer P.O';
        }
        field(73209582; "Customer P.O Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer P.O Date';
        }
        field(73209583; "Contract Period"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Period';
        }
        field(73209584; "Reason for Rejection"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reason for Rejection';
        }
        field(73209585; "View Invoice"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'View Invoice';
        }
        field(73209586; "View Document URL"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'View Document URL';
        }
        field(73209587; "Overdue Invoice"; Text[20])
        {
            Caption = 'Overdue Invoice';
            DataClassification = ToBeClassified;
        }
        field(73209588; "FC ID"; Integer)
        {
            Caption = 'FC ID';
            DataClassification = ToBeClassified;
        }
        field(73209589; "Property Classification"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Classification';
        }
        field(73209590; "Approval Status for CreditNote"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Approval Status';
            OptionMembers = " ",Approved,Rejected;
        }
        field(73209591; "Rejection Reason CreditNote"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Rejection Reason';
        }
        field(73209592; "Credit Memo Document"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Memo ID';
        }
        field(73209593; "Credit Memo URL"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Memo No';
        }
        field(73209594; "Contract Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Amount';
        }
        field(73209595; "Terminated Credit Note"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Terminated Credit Note';
        }
    }
}
