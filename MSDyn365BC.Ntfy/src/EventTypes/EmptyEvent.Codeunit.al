namespace StefanMaron.Ntfy;

codeunit 71179876 EmptyEventNTSTM implements INtfyEventNTSTM
{
    procedure SetSettings(NtfyEntry: Record NtfyEntryNTSTM)
    begin

    end;

    procedure DoCallNtfyEntry(NtfyEntry: Record NtfyEntryNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Boolean
    begin

    end;

    procedure GetMessage(Params: Dictionary of [Text, Text]) ReturnValue: Text[2048]
    begin

    end;

    procedure ResetSettings(NtfyEntry: Record NtfyEntryNTSTM);
    begin

    end;

    procedure FilterNtfyEntriesBeforeBatchSend(var NtfyEntry: Record NtfyEntryNTSTM; Params: Dictionary of [Text, Text]);
    begin

    end;

}