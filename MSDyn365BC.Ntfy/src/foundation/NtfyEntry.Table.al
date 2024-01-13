namespace StefanMaron.Ntfy;
using System.Security.AccessControl;


table 71179875 NtfyEntryNTSTM
{
    DataClassification = CustomerContent;
    DrillDownPageId = NtfyEntryNTSTM;
    LookupPageId = NtfyEntryNTSTM;
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
        field(5; NtfyTitle; Text[150])
        {
            Caption = 'Title';
            AllowInCustomizations = Never;
            //Temporary user only
        }
        field(6; NtfyMessage; Text[2048])
        {
            Caption = 'Message';
            AllowInCustomizations = Never;
            //Temporary user only
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

    procedure RunBatch()
    var
        TempSessionId: Integer;
    begin
        if not StartSession(TempSessionId, Codeunit::BatchSendNtfysNTSTM, CompanyName, Rec) then
            Codeunit.Run(Codeunit::BatchSendNtfysNTSTM, Rec);
    end;

    procedure SendNotifications(Type: Enum EventTypeNTSTM; Params: Dictionary of [Text, Text])
    var
        RunBatchWrapper: Codeunit RunBatchWrapperNTSTM;
    begin
        SendNotifications(Type, Type, Params, RunBatchWrapper);
    end;

    internal procedure SendNotifications(INtfyEvent: Interface INtfyEventNTSTM; Type: Enum EventTypeNTSTM; Params: Dictionary of [Text, Text]; RunBatchWrapper: Interface IRunBatchNTSTM)
    begin
        Rec.SetRange(EventType, Type);
        Rec.SetFilter(NtfyTopic, '<>%1', '');
        INtfyEvent.FilterNtfyEntriesBeforeBatchSend(Rec, Params);
        if Rec.FindSet() then
            repeat
                if INtfyEvent.DoCallNtfyEntry(Rec, Params) then
                    Rec.Mark(true);
            until Rec.Next() = 0;

        Rec.NtfyMessage := INtfyEvent.GetMessage(Params);

        Rec.MarkedOnly(true);

        RunBatchWrapper.RunBatch(Rec);
    end;
}