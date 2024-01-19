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

    end;

    procedure DoCallNtfyEvent(NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Boolean;
    begin
        Evaluate(ReturnValue, NtfyEvent.NtfyMessage);
    end;

    procedure GetMessage(NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Text[2048];
    begin

    end;

}