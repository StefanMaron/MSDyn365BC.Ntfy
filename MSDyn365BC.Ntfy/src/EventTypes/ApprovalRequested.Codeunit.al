namespace StefanMaron.Ntfy;
using Microsoft.Sales.Document;
using System.Automation;

codeunit 71179884 ApprovalRequestedNTSTM implements INtfyEventNTSTM
{

    procedure SetSettings(NtfyEvent: Record NtfyEventNTSTM)
    var
        FilterPageBuilder: FilterPageBuilder;
    begin
        FilterPageBuilder.AddTable('Approval Entry', Database::"Approval Entry");
        if NtfyEvent.FilterText <> '' then
            FilterPageBuilder.SetView('Approval Entry', NtfyEvent.FilterText);
        if FilterPageBuilder.RunModal() then begin
            if not FilterPageBuilder.GetView('Approval Entry').Contains('WHERE') then
                NtfyEvent.Validate(FilterText, '')
            else
                NtfyEvent.Validate(FilterText, FilterPageBuilder.GetView('Approval Entry'));
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
        NtfyEvent.SetRange(UserName, Params.Get('ApproverID'));
    end;

    procedure DoCallNtfyEvent(NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Boolean
    begin
        exit(true);
    end;

    procedure GetMessage(NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Text[2048]
    begin
        exit(StrSubstNo('%1 | Pending Approval [Go to Approval List](%2)', Params.Get('RecordID'), GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Requests to Approve")));
    end;

    [EventSubscriber(ObjectType::Table, Database::"Approval Entry", OnAfterInsertEvent, '', false, false)]
    local procedure SentNtfyOnAfterReopenSalesDoc(var Rec: Record "Approval Entry")
    var
        NtfyEvent: Record NtfyEventNTSTM;
        Params: Dictionary of [Text, Text];
    begin
        if not (Rec.Status in [Rec.Status::Open, Rec.Status::Created]) then exit;

        Params.Add('ApproverID', Rec."Approver ID");
        Params.Add('RecordID', Format(Rec."Record ID to Approve"));
        NtfyEvent.SendNotifications(NtfyEvent.EventType::ApprovalRequested, Params);
    end;
}