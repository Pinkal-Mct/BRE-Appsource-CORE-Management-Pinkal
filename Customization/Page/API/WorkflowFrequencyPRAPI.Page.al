page 73209616 "BLRWorkflow Frequency PR API"
{
    PageType = API;
    SourceTable = "BLRWorkflowFrequencyPR";
    APIPublisher = 'realestate';
    APIGroup = 'workflowManagement';
    APIVersion = 'v2.0';
    EntityName = 'workflowFrequencyPR';
    EntitySetName = 'workflowFrequencyPRs';
    Caption = 'Workflow Frequency PR API';
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(content)
        {
            field("systemId"; Rec.SystemId) // System ID field for unique identification in API calls
            {
                Caption = 'System Identifier';
            }

            field("companyID"; Rec."BLRCompany ID")
            {
            }

            field("workflow"; Rec."BLRWorkflow")
            {
            }

            field("frequencyStatus"; Rec."BLRfrequncy Status")
            {
            }

            field("noOfDays"; Rec."BLRNo. of Days")
            {
            }

            field("propertyID"; Rec."BLRProperty ID")
            {
            }
        }
    }
}
