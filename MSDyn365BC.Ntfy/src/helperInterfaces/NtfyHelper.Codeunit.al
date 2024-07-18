namespace StefanMaron.Ntfy;

codeunit 71179886 NtfyHelperNTSTM
{

    Access = Public;
    InherentEntitlements = X;
    InherentPermissions = X;

    procedure GetFilterTextForTable(var FilterPageBuilder: FilterPageBuilder; Caption: Text; TableId: Integer; var FilterText: Text[2048])
    begin
        FilterPageBuilder.AddTable(Caption, TableId);
        if FilterText <> '' then
            FilterPageBuilder.SetView(Caption, FilterText);
        if FilterPageBuilder.RunModal() then
            if not FilterPageBuilder.GetView(Caption).Contains('WHERE') then
                FilterText := ''
            else
                FilterText := CopyStr(FilterPageBuilder.GetView(Caption), 1, MaxStrLen(FilterText));
    end;

    procedure GetFilterTextForTable(TableId: Integer; var FilterText: Text[2048])
    var
        FilterPageBuilder: FilterPageBuilder;
        RecRef: RecordRef;
    begin
        RecRef.Open(TableId);
        GetFilterTextForTable(FilterPageBuilder, RecRef.Caption, TableId, FilterText);
    end;
}