codeunit 50008 MarkingTestTypeNTSTM implements INtfyEventNTSTM
{
    procedure SetSettings(NtfyEntry: Record NtfyEntryNTSTM);
    begin

    end;

    procedure ResetSettings(NtfyEntry: Record NtfyEntryNTSTM);
    begin

    end;

    procedure FilterNtfyEntriesBeforeBatchSend(var NtfyEntry: Record NtfyEntryNTSTM; Params: Dictionary of [Text, Text]);
    begin

    end;

    procedure DoCallNtfyEntry(NtfyEntry: Record NtfyEntryNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Boolean;
    begin
        Evaluate(ReturnValue, NtfyEntry.NtfyMessage);
    end;

    procedure GetMessage(Params: Dictionary of [Text, Text]) ReturnValue: Text[2048];
    begin

    end;

}