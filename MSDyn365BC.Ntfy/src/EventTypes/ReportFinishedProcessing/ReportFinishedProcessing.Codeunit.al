codeunit 71179883 ReportFinishedProcessingNTSTM implements INtfyEventNTSTM
{
    InherentEntitlements = X;
    InherentPermissions = X;

    procedure SetSettings(NtfyEvent: Record NtfyEventNTSTM)
    var
        AllObjWithCaption: Record AllObjWithCaption;
        FilterPageBuilder: FilterPageBuilder;
    begin
        FilterPageBuilder.AddTable('Report List', Database::AllObjWithCaption);
        FilterPageBuilder.AddField('Report List', AllObjWithCaption."Object Type", 'Report');
        FilterPageBuilder.AddField('Report List', AllObjWithCaption."Object ID");
        if NtfyEvent.FilterText <> '' then
            FilterPageBuilder.SetView('Report List', NtfyEvent.FilterText);
        if FilterPageBuilder.RunModal() then begin
            if not FilterPageBuilder.GetView('Report List').Contains('WHERE') then
                NtfyEvent.Validate(FilterText, '')
            else
                NtfyEvent.Validate(FilterText, FilterPageBuilder.GetView('Report List'));
            NtfyEvent.Modify(true);
        end;
    end;

    procedure ResetSettings(NtfyEvent: Record NtfyEventNTSTM)
    begin
        NtfyEvent.Validate(FilterText, '');
        NtfyEvent.Modify(true);
    end;

    procedure FilterNtfyEntriesBeforeBatchSend(var NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text])
    begin
    end;

    procedure DoCallNtfyEvent(NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Boolean
    var
        FilterObjects: Record AllObj;
    begin
        ReturnValue := true;
        if NtfyEvent.FilterText <> '' then begin
            FilterObjects.SetView(NtfyEvent.FilterText);
            FilterObjects.FilterGroup(2);
            FilterObjects.SetRange("Object Type", FilterObjects."Object Type"::Report);
            FilterObjects.SetFilter("Object ID", Params.Get('ReportID'));
            ReturnValue := not FilterObjects.IsEmpty();
        end;
    end;

    procedure GetMessage(NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Text[2048]
    var
        AllObjWithCaption: Record AllObjWithCaption;
        ReportCaption: Text[249];
        ReportFinishedLbl: Label 'Report %1 (%2) finished processing', Comment = '%1 - Report Caption, %2 - Report ID';
    begin
        AllObjWithCaption.SetRange("Object Type", AllObjWithCaption."Object Type"::Report);
        AllObjWithCaption.SetFilter("Object ID", Params.Get('ReportID'));
        AllObjWithCaption.SetLoadFields("Object Caption");
        if AllObjWithCaption.FindFirst() then
            ReportCaption := AllObjWithCaption."Object Caption";

        exit(StrSubstNo(ReportFinishedLbl, ReportCaption, Params.Get('ReportID')));
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, OnAfterDocumentReady, '', false, false)]
    local procedure SentNtfyOnAfterReleaseSalesDoc(ObjectID: Integer; var Success: Boolean)
    var
        NtfyEvent: Record NtfyEventNTSTM;
        Params: Dictionary of [Text, Text];
    begin
        Params.Add('ReportID', Format(ObjectID));
        NtfyEvent.SendNotifications(NtfyEvent.EventType::ReportFinishedProcessing, Params);
    end;

}