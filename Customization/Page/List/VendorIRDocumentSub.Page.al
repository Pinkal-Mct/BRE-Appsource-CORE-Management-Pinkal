page 73209668 "BLRVendor I/R DocumentSub"
{
    PageType = ListPart;
    SourceTable = "BLRVendorContractDocument";
    ApplicationArea = All;
    Caption = 'Vendor Invoice/Receipt Documents';

    layout
    {
        area(content)
        {
            repeater("Documents")
            {
                field("Vendor ID"; Rec."BLRVendor ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'The ID of the vendor associated with this document.';
                }

                field("Amount"; Rec."BLRAmount")
                {
                    ApplicationArea = All;
                    ToolTip = 'The amount associated with the vendor document.';
                }

                field("Payment Status"; Rec."BLRPayment Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'The payment status of the vendor document.';
                }

                field("Invoice ID"; Rec."BLRInvoice ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'The unique identifier for the vendor invoice.';
                }

                field("Invoice Document Upload"; Rec."BLRInvoice Document Upload")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Editable = false;
                    ToolTip = 'Upload the invoice document for the vendor.';

                    trigger OnDrillDown()
                    var
                        azureBlobUploader: Codeunit "BLRAzure AD Blob Storage";
                        fileName: Text;
                        uploadResult: Text;
                        folderName: Text;
                    begin

                        folderName := 'PropertyDocuments';
                        fileName := azureBlobUploader.ValidateDocument(uploadResult, folderName);
                        if fileName <> '' then begin
                            Rec."BLRInvoice Document Upload" := CopyStr(fileName, 1, StrLen(fileName));
                            Rec."BLRInvoice Document URL" := CopyStr(uploadResult, 1, StrLen(uploadResult));
                            Rec.Modify();
                            Message('File uploaded successfully: %1', fileName);
                        end;
                    end;
                }

                field("Invoice Document View"; Rec."BLRInvoice Document View")
                {
                    ApplicationArea = All;
                    Editable = false;
                    DrillDown = true;
                    ToolTip = 'View the uploaded invoice document for the vendor.';

                    trigger OnDrillDown()
                    var
                        FileURL: Text;
                    begin
                        // Get the URL of the uploaded document
                        FileURL := Rec."BLRInvoice Document URL";

                        // Check if the file URL is not empty
                        if FileURL = '' then
                            Error('No document is available to view.');

                        // Open the file URL in the browser (new tab)
                        OpenFileInBrowser(FileURL);

                    end;
                }

                field("Invoice Document URL"; Rec."BLRInvoice Document URL")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                    ToolTip = 'The URL of the uploaded invoice document.';
                }

                field("Receipt ID"; Rec."BLRReceipt ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'The unique identifier for the vendor receipt.';
                }

                field("Receipt Document Upload"; Rec."BLRReceipt Document Upload")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Editable = false;
                    ToolTip = 'Upload the receipt document for the vendor.';

                    trigger OnDrillDown()
                    var
                        azureBlobUploader: Codeunit "BLRAzure AD Blob Storage";
                        fileName: Text;
                        uploadResult: Text;
                        folderName: Text;
                    begin
                        folderName := 'PropertyDocuments';
                        fileName := azureBlobUploader.ValidateDocument(uploadResult, folderName);
                        if fileName <> '' then begin
                            Rec."BLRReceipt Document Upload" := CopyStr(fileName, 1, StrLen(fileName));
                            Rec."BLRReceipt Document URL" := CopyStr(uploadResult, 1, StrLen(uploadResult));
                            Rec.Modify();
                            Message('File uploaded successfully: %1', fileName);
                        end;
                    end;
                }

                field("Receipt Document View"; Rec."BLRReceipt Document View")
                {
                    ApplicationArea = All;
                    Editable = false;
                    DrillDown = true;
                    ToolTip = 'View the uploaded receipt document for the vendor.';

                    trigger OnDrillDown()
                    var
                        FileURL: Text;
                    begin
                        // Get the URL of the uploaded document
                        FileURL := Rec."BLRReceipt Document URL";

                        // Check if the file URL is not empty
                        if FileURL = '' then
                            Error('No document is available to view.');

                        // Open the file URL in the browser (new tab)
                        OpenFileInBrowser(FileURL);

                    end;
                }

                field("Receipt Document URL"; Rec."BLRReceipt Document URL")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                    ToolTip = 'The URL of the uploaded receipt document.';
                }

                field("Entry No."; Rec."BLREntry No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'The unique entry number for the vendor document.';
                }
            }
        }
    }

    procedure OpenFileInBrowser(URL: Text)
    begin
        if URL <> '' then
            Hyperlink(URL)
        else
            Error('The file URL is invalid.');
    end;

    procedure SetVendorID(pVendorID: Code[20])
    begin
        VendorID := pVendorID;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        vendor: Record "BLRVendorProfile";
        PaymentStatus: Enum "BLRPayment Status";
    begin
        Rec."BLRVendor ID" := VendorID;

        vendor.SetRange("BLRVendor ID", Rec."BLRVendor ID");
        if not vendor.IsEmpty() then
            if Rec."BLRPayment Status" = PaymentStatus::" " then
                Rec."BLRPayment Status" := PaymentStatus::Scheduled;

    end;

    var
        VendorID: Code[20];

    trigger OnModifyRecord(): Boolean
    var
        vendor: Record "BLRVendorProfile";
        PaymentStatus: Enum "BLRPayment Status";
    begin
        vendor.SetRange("BLRVendor ID", Rec."BLRVendor ID");
        if not vendor.IsEmpty() then
            if Rec."BLRPayment Status" = PaymentStatus::" " then
                Rec."BLRPayment Status" := PaymentStatus::Scheduled;

    end;

}