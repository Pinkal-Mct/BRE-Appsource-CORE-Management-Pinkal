page 73209628 "BLRPayment Type Card"
{
    PageType = Card;
    SourceTable = "BLRPaymentType";
    ApplicationArea = All;
    Caption = 'Payment Type Card';
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Payment Type Details';
                field("Payment ID"; Rec."BLRPayment ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    toolTip = 'Specifies the unique identifier for the payment type.';
                }
                field("Payment Method"; Rec."BLRPayment Method")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Method';
                    ToolTip = 'Enter the Payment Method.';
                    ShowMandatory = true;
                    NotBlank = true;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
            }
        }
    }


}



