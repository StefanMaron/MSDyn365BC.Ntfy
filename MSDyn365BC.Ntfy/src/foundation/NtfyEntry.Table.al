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
    }

    keys
    {
        key(Key1; UserName, NtfyTopic, EventType)
        {
            Clustered = true;
        }
    }

    procedure SetFiltersTroughInterface()
    var
        INtfyEvent: Interface INtfyEventNTSTM;
    begin
        INtfyEvent := Rec.EventType;
        INtfyEvent.SetFilters(Rec);
    end;

    procedure RunBatch()
    var
        TempSessionId: Integer;
    begin
        Commit();
        StartSession(TempSessionId, Codeunit::BatchSendNtfysNTSTM, CompanyName, Rec);
        // if not TaskScheduler.CreateTask() then
        // Codeunit.Run(Codeunit::BatchSendNtfysNTSTM, Rec);
    end;
}