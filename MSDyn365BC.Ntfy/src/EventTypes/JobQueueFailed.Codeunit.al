namespace StefanMaron.Ntfy;

using System.Automation;
using System.Threading;

codeunit 71179885 JobQueueFailedNTSTM implements INtfyEventNTSTM
{
    InherentEntitlements = X;
    InherentPermissions = X;

    procedure SetSettings(NtfyEvent: Record NtfyEventNTSTM)
    var
        FilterPageBuilder: FilterPageBuilder;
    begin
        FilterPageBuilder.AddTable('Job Queue Entry', Database::"Job Queue Entry");
        if NtfyEvent.FilterText <> '' then
            FilterPageBuilder.SetView('Job Queue Entry', NtfyEvent.FilterText);
        if FilterPageBuilder.RunModal() then begin
            if not FilterPageBuilder.GetView('Job Queue Entry').Contains('WHERE') then
                NtfyEvent.Validate(FilterText, '')
            else
                NtfyEvent.Validate(FilterText, FilterPageBuilder.GetView('Job Queue Entry'));
            NtfyEvent.Modify(true);
        end;
    end;

    procedure ResetSettings(NtfyEvent: Record NtfyEventNTSTM);
    begin
        NtfyEvent.Validate(FilterText, '');
        NtfyEvent.Modify(true);
    end;

    procedure FilterNtfyEntriesBeforeBatchSend(var NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]);
    begin
    end;

    procedure DoCallNtfyEvent(NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Boolean
    begin
        exit(true);
    end;

    procedure GetTitle(NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Text[150]
    begin
        exit(StrSubstNo('Job queue for %1 %2 failed', Params.Get('ObjectType'), Params.Get('ObjectID')));
    end;

    procedure GetMessage(NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Text[2048]
    begin
        exit(Params.Get('Error Message'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Queue Error Handler", OnAfterLogError, '', false, false)]
    local procedure SentNtfyOnAfterReopenSalesDoc(var JobQueueEntry: Record "Job Queue Entry")
    var
        NtfyEvent: Record NtfyEventNTSTM;
        Params: Dictionary of [Text, Text];
    begin
        if not (JobQueueEntry.Status in [JobQueueEntry.Status::Error]) then exit;

        Params.Add('Error Message', JobQueueEntry."Error Message");
        Params.Add('ObjectType', Format(JobQueueEntry."Object Type to Run"));
        Params.Add('ObjectID', Format(JobQueueEntry."Object ID to Run"));
        NtfyEvent.SendNotifications(NtfyEvent.EventType::JobQueueFailed, Params);
    end;
}