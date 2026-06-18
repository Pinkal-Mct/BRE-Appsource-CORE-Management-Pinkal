tableextension 73209586 "BLRSales Header Ext" extends "Sales Header"
{
    fields
    {
        field(73209575; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209576; "BLRProperty Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Name';
        }
        field(73209577; "BLRUnit Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Name';
        }
        field(73209578; "BLRContract Tenure"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Tenure';
        }
        field(73209579; "BLRApproval Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Approved,Rejected;
            Caption = 'Approval Status';
        }
        field(73209580; "BLRTenant Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Name';
        }
        field(73209581; "BLRCustomer P.O"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer P.O';
        }
        field(73209582; "BLRCustomer P.O Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Customer P.O Date';
        }
        field(73209583; "BLRContract Period"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Period';
        }
        field(73209584; "BLRReason for Rejection"; Text[1000])
        {
            DataClassification = CustomerContent;
            Caption = 'Reason for Rejection';
        }
        field(73209585; "BLRView Invoice"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'View Invoice';
        }
        field(73209586; "BLRView Document URL"; Text[1000])
        {
            DataClassification = CustomerContent;
            Caption = 'View Document URL';
        }
        field(73209587; "BLROverdue Invoice"; Text[20])
        {
            Caption = 'Overdue Invoice';
            DataClassification = CustomerContent;
        }
        field(73209588; "BLRFC ID"; Integer)
        {
            Caption = 'FC ID';
            DataClassification = CustomerContent;
        }
        field(73209589; "BLRProperty Classification"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Classification';
        }
        field(73209590; "BLRApprovalStatusforCreditNote"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Approval Status';
            OptionMembers = " ",Approved,Rejected;
        }
        field(73209591; "BLRRejection Reason CreditNote"; Text[1000])
        {
            DataClassification = CustomerContent;
            Caption = 'Rejection Reason';
        }
        field(73209592; "BLRCredit Memo Document"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Memo ID';
        }
        field(73209593; "BLRCredit Memo URL"; Text[1000])
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Memo No';
        }
        field(73209594; "BLRContract Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Amount';
        }
        field(73209595; "BLRTerminated Credit Note"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Terminated Credit Note';
        }
    }
}
