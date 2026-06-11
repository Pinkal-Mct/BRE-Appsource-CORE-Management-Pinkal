codeunit 73209587 "BLRCopy Item Ext"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Item", OnAfterCopyItem, '', false, false)]
    local procedure OnAfterCopyItem(var TargetItem: Record Item)
    var
        NoSeriesManagement: Codeunit "No. Series";
        unitpage: Page "Item Card";
        NewUnitNo: Code[20];
    begin
        NewUnitNo := NoSeriesManagement.GetNextNo('UNITNO', 0D, true);
        TargetItem.BLRFixedNumber := NewUnitNo;
        TargetItem."BLRUnit Status" := TargetItem."BLRUnit Status"::Free;
        TargetItem.BLRMergeSplitOption := TargetItem.BLRMergeSplitOption::Single;
        TargetItem.Modify();

        unitpage.AutoGenerateUnitName(TargetItem);
    end;
}