codeunit 50008 MarkingTestTypeNTSTM implements INtfyEventNTSTM
{
    procedure SetSettings(NtfyEvent: Record NtfyEventNTSTM);
    begin

    end;

    procedure ResetSettings(NtfyEvent: Record NtfyEventNTSTM);
    begin

    end;

    procedure FilterNtfyEntriesBeforeBatchSend(var NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]);
    begin
        NtfyEvent.SetRange(Topic, 'true');
    end;

    procedure DoCallNtfyEvent(NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Boolean;
    begin
        exit(true);
    end;

    procedure GetMessage(NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Text[2048];
    begin

    end;

    procedure GetTitle(NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Text[150]
    begin

    end;
}