namespace StefanMaron.Ntfy;
using System.Security.AccessControl;


table 71179875 NtfyEntryNTSTM
{
    DataClassification = CustomerContent;
    DrillDownPageId = NtfyEntryNTSTM;
    LookupPageId = NtfyEntryNTSTM;

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
            //Temporary user only
        }
        field(6; NtfyMessage; Text[2048])
        {
            Caption = 'Message';
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
        NtfyEntry: Record NtfyEntryNTSTM;
        INtfyEvent: Interface INtfyEventNTSTM;
    begin
        INtfyEvent := Type;

        NtfyEntry.SetRange(EventType, Type);
        NtfyEntry.SetFilter(NtfyTopic, '<>%1', '');
        if NtfyEntry.FindSet() then
            repeat
                if INtfyEvent.DoCallNtfyEntry(NtfyEntry, Params) then
                    NtfyEntry.Mark(true);
            until NtfyEntry.Next() = 0;

        NtfyEntry.NtfyMessage := INtfyEvent.GetMessage(Params);

        NtfyEntry.MarkedOnly(true);
        NtfyEntry.RunBatch();

    end;
}