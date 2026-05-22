page 73209651 "Owner Profile List"
{
    PageType = List;
    SourceTable = "BLROwnerProfile";
    ApplicationArea = All;
    Caption = 'Owner Profiles';
    UsageCategory = Lists;
    CardPageId = 73209627;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Owner ID"; rec."BLROwner ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique identifier for the owner profile.';
                }
                field("Full Name"; rec."BLRFull Name")
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                    ToolTip = 'Full name of the owner.';
                }
                field("Nationality"; rec."BLRNationality")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nationality of the owner.';

                }
                field("Phone Number"; rec."BLRPhone Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Contact phone number of the owner.';
                }
                field("Email Address"; rec."BLREmail Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Email address of the owner.';
                }
                field("Status"; rec."BLRStatus")
                {
                    ApplicationArea = All;
                    ToolTip = 'Current status of the owner profile, such as Active or Inactive.';
                }

                field("Ejari Registration Number"; Rec."BLREjari Registration Number")
                {
                    ApplicationArea = All;
                    Caption = 'Ejari Reg. No.';
                }
                field("RERA Owner ID"; Rec."BLRRERA Owner ID")
                {
                    ApplicationArea = All;
                    Caption = 'RERA Owner ID';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
#pragma warning disable AW0005
            action(NewOwner)
#pragma warning restore AW0005
            {
                Caption = 'New Owner';
                ApplicationArea = All;
                ToolTip = 'Create a new owner profile.';
                trigger OnAction()
                begin
                    Page.RunModal(Page::"Owner Profile Card");
                end;
            }
        }
    }
}
