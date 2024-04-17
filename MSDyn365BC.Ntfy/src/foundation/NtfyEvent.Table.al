namespace StefanMaron.Ntfy;
using System.Security.AccessControl;


table 71179875 NtfyEventNTSTM
{
    DataClassification = CustomerContent;
    DrillDownPageId = NtfyEventsNTSTM;
    LookupPageId = NtfyEventsNTSTM;
    InherentEntitlements = RIMDX;
    InherentPermissions = RIMDX;

    fields
    {
        field(1; UserName; Text[50])
        {
            Caption = 'User Name';
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
        field(2; NtfyTopic; Text[150])
        {
            Caption = 'Topic';
            TableRelation = NtfyTopicNTSTM.Topic;
        }
        field(3; EventType; Enum EventTypeNTSTM)
        {
            Caption = 'Event Type';
        }
        field(4; FilterText; Text[2048])
        {
            AllowInCustomizations = Never;
            Caption = 'Filter Text';
        }
    }

    keys
    {
        key(Key1; UserName, NtfyTopic, EventType)
        {
            Clustered = true;
        }
    }

    procedure SetSettingsTroughInterface()
    var
        INtfyEvent: Interface INtfyEventNTSTM;
    begin
        INtfyEvent := Rec.EventType;
        INtfyEvent.SetSettings(Rec);
    end;

    procedure ResetSettingsTroughInterface()
    var
        INtfyEvent: Interface INtfyEventNTSTM;
    begin
        INtfyEvent := Rec.EventType;
        INtfyEvent.ResetSettings(Rec);
    end;

    procedure SendNotifications(Type: Enum EventTypeNTSTM; Params: Dictionary of [Text, Text])
    var
        RunBatchWrapper: Codeunit RunBatchWrapperNTSTM;
    begin
        SendNotifications(Type, Type, Params, RunBatchWrapper);
    end;

    internal procedure SendNotifications(INtfyEvent: Interface INtfyEventNTSTM; Type: Enum EventTypeNTSTM; Params: Dictionary of [Text, Text]; RunBatchWrapper: Interface IRunBatchNTSTM)
    var
        NtfyEventRequest: Record NtfyEventRequestNTSTM;
    begin
        Rec.SetRange(EventType, Type);
        Rec.SetFilter(NtfyTopic, '<>%1', '');
        INtfyEvent.FilterNtfyEntriesBeforeBatchSend(Rec, Params);
        if Rec.FindSet() then
            repeat
                if INtfyEvent.DoCallNtfyEvent(Rec, Params) then begin
                    NtfyEventRequest.Init();
                    NtfyEventRequest.Validate(EntryNo, NtfyEventRequest.EntryNo + 1);
                    NtfyEventRequest.Validate(NtfyTopic, Rec.NtfyTopic);
                    NtfyEventRequest.Validate(NtfyTitle, INtfyEvent.GetTitle(Rec, Params));
                    NtfyEventRequest.Validate(NtfyMessage, INtfyEvent.GetMessage(Rec, Params));
                    if NtfyEventRequest.NtfyMessage = '' then
                        NtfyEventRequest.Validate(NtfyMessage, '<empty>');
                    NtfyEventRequest.Insert(true);
                end;
            until Rec.Next() = 0;


        RunBatchWrapper.RunBatch(NtfyEventRequest);
    end;
}