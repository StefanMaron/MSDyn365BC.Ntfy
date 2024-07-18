namespace StefanMaron.Ntfy;

using System.Automation;

codeunit 71179884 ApprovalRequestedNTSTM implements INtfyEventNTSTM
{
    InherentEntitlements = X;
    InherentPermissions = X;

    procedure SetSettings(NtfyEvent: Record NtfyEventNTSTM)
    var
        NtfyHelper: Codeunit NtfyHelperNTSTM;
        FilterText: Text[2048];
    begin
        FilterText := NtfyEvent.FilterText;
        NtfyHelper.GetFilterTextForTable(Database::"Approval Entry", NtfyEvent.FilterText);
        NtfyEvent.Validate(FilterText, NtfyEvent.FilterText);
        NtfyEvent.Modify(true);
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

    procedure GetTitle(NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Text[150]
    begin
        exit(StrSubstNo('%1 | Pending Approval [Go to Approval List](%2)', Params.Get('RecordID'), GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Requests to Approve")));
    end;

    procedure GetMessage(NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Text[2048]
    begin
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