codeunit 71179883 ReportFinishedProcessingNTSTM implements INtfyEventNTSTM
{
    InherentEntitlements = X;
    InherentPermissions = X;

    procedure SetSettings(NtfyEvent: Record NtfyEventNTSTM)
    var
        AllObjWithCaption: Record AllObjWithCaption;
        NtfyHelper: Codeunit NtfyHelperNTSTM;
        FilterPageBuilder: FilterPageBuilder;
        FilterText: Text[2048];
        FilterPageCaptionLbl: Label 'Report List';
    begin
        FilterPageBuilder.AddField(FilterPageCaptionLbl, AllObjWithCaption."Object Type", 'Report');
        FilterPageBuilder.AddField(FilterPageCaptionLbl, AllObjWithCaption."Object ID");

        FilterText := NtfyEvent.FilterText;
        NtfyHelper.GetFilterTextForTable(FilterPageBuilder, FilterPageCaptionLbl, Database::AllObjWithCaption, FilterText);
        NtfyEvent.Validate(FilterText, FilterText);
        NtfyEvent.Modify(true);
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


    procedure GetTitle(NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Text[150]
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

    procedure GetMessage(NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Text[2048]
    begin
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