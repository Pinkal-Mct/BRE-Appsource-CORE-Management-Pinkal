page 73209652 "BLRPayment Type List"
{
    PageType = List;
    SourceTable = "BLRPaymentType";
    ApplicationArea = All;
    Caption = 'Payment Type List';
    UsageCategory = Lists;
    CardPageId = 73209628;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Payment ID"; Rec."BLRPayment ID")
                {
                    ApplicationArea = All;
                    Caption = 'Payment ID';
                    ToolTip = 'Specifies the unique identifier for the payment type.';
                }
                field("Payment Method"; Rec."BLRPayment Method")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Method';
                    ToolTip = 'Specifies the method of payment, such as Cash, Credit Card, or Bank Transfer.';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        paymentType: Text[100];
    begin
        Rec.Reset();
        foreach paymentType in Enum::"BLRDefault Payment Type".Names() do begin
            Rec.SetRange("BLRPayment Method", paymentType);
            if not Rec.FindFirst() then begin
                Rec.Init();
                Rec."BLRPayment Method" := paymentType;
                Rec.Insert();
                Rec.Reset();
                clear(Rec);
            end;
        end;
    end;
}
