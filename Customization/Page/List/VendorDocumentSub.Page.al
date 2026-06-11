page 73209667 "BLRVendor Document Sub"
{
    PageType = ListPart;
    SourceTable = "BLRVendorDocument";
    ApplicationArea = All;
    Caption = 'Vendor All Documents';
    layout
    {
        area(content)
        {
            repeater("Document")
            {
                field("Vendor ID"; Rec."BLRVendor ID")
                {
                    ToolTip = 'The unique identifier for the vendor associated with the document.';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Document Type"; Rec."BLRDocument Type")
                {
                    ToolTip = 'The type of document associated with the vendor.';
                    ApplicationArea = All;
                }
                field("Document No."; Rec."BLRDocument No.")
                {
                    ToolTip = 'The unique identifier for the document associated with the vendor.';
                    ApplicationArea = All;
                }
                field("Document Name"; Rec."BLRDocument Name")
                {
                    ToolTip = 'The name of the document associated with the vendor.';
                    ApplicationArea = All;
                }
                field("Document Upload"; Rec."BLRDocument Upload")
                {
                    ToolTip = 'The uploaded document file associated with the vendor.';
                    ApplicationArea = All;
                    DrillDown = true;
                    Editable = false;
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
                            Rec."BLRDocument Upload" := CopyStr(fileName, 1, StrLen(fileName));
                            Rec."BLRDocument URL" := CopyStr(uploadResult, 1, StrLen(uploadResult));
                            Rec.Modify();
                            Message('File uploaded successfully: %1', fileName);
                        end;
                    end;
                }
                field("Document View"; Rec."BLRDocument View")
                {
                    ToolTip = 'View the uploaded document associated with the vendor.';
                    ApplicationArea = All;
                    Editable = false;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        FileURL: Text;
                    begin
                        FileURL := Rec."BLRDocument URL";
                        if FileURL = '' then
                            Error('No document is available to view.');
                        OpenFileInBrowser(FileURL);
                    end;
                }
                field("Document URL"; Rec."BLRDocument URL")
                {
                    ToolTip = 'The URL of the uploaded document associated with the vendor.';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Entry No."; Rec."BLREntry No.")
                {
                    ToolTip = 'The unique entry number for the vendor document.';
                    ApplicationArea = All;
                    Visible = false;
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
    begin
        Rec."BLRVendor ID" := VendorID;
    end;

    var
        VendorID: Code[20];
}
