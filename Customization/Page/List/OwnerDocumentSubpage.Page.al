page 73209650 "Owner Document Subpage"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "BLRDocumentUploadDetails";
    Caption = 'Owner Document Attachments';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."BLRDocument Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Document Type';
                }

                field("Document Name"; Rec."BLRDocument Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Document Name';
                }

                field("Upload Document"; Rec."BLRUpload Document")
                {
                    ApplicationArea = All;
                    Editable = false;
                    DrillDown = true;
                    ToolTip = 'Upload Document';
                    trigger OnDrillDown()
                    var
                        azureBlobUploader: Codeunit "Azure AD Blob Storage";
                        fileName: Text;
                        uploadResult: Text;
                        folderName: Text;
                    begin
                        folderName := 'TenancyContractDocuments';
                        fileName := azureBlobUploader.ValidateDocument(uploadResult, folderName);
                        if fileName <> '' then begin
                            Rec."BLRUpload Document" := CopyStr(fileName, 1, StrLen(fileName));
                            Rec."BLRView Document URL" := CopyStr(uploadResult, 1, StrLen(uploadResult));
                            Rec.Modify();
                            Message('File uploaded successfully: %1', fileName);
                        end;
                    end;
                }

                field("View & Download"; Rec."BLRView & Download")
                {
                    ApplicationArea = All;
                    Editable = false;
                    DrillDown = true;
                    ToolTip = 'View or Download Document';
                    trigger OnDrillDown()
                    var
                        FileURL: Text;
                    begin
                        // Get the URL of the uploaded document
                        FileURL := Rec."BLRView Document URL";

                        // Check if the file URL is not empty
                        if FileURL = '' then
                            Error('No document is available to view.');

                        // Open the file URL in the browser (new tab)
                        OpenFileInBrowser(FileURL);
                    end;
                }
                field(Download; Rec."BLRDownload")
                {
                    ApplicationArea = All;
                    Editable = false;
                    DrillDown = true;
                    Visible = false;
                    ToolTip = 'Download Document';

                    trigger OnDrillDown()
                    var
                        AttachmentRec: Record "Document Attachment";
                        FileName: Text;
                        ToFile: Text;
                    begin
                        // Find the attachment record
                        AttachmentRec.SetRange("No.", Format(Rec."BLROwnerId"));
                        AttachmentRec.SetRange("Table ID", 73209613); // Adjust to match your table ID
                        AttachmentRec.SetRange("File Name", Rec."BLRUpload Document");

                        if AttachmentRec.FindSet() then begin
                            FileName := AttachmentRec."File Name";
                            ToFile := FileName;

                            if AttachmentRec.HasContent() then
                                AttachmentRec.Export(true);

                        end
                        else
                            Message('Document not found.');


                    end;
                }
            }
        }
    }

    procedure SetOwnerId(pOwnerId: Integer)
    begin
        OwnerId := pOwnerId;
    end;

    procedure OpenFileInBrowser(URL: Text)
    begin
        // Use the Hyperlink method to open the file in the browser
        if URL <> '' then
            Hyperlink(URL)
        else
            Error('The file URL is invalid.');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."BLROwnerId" := OwnerId;
    end;

    var
        OwnerId: Integer;
}