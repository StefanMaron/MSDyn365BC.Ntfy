namespace StefanMaron.Ntfy;

codeunit 71179876 EmptyEventNTSTM implements INtfyEventNTSTM
{
    InherentEntitlements = X;
    InherentPermissions = X;

    procedure SetSettings(NtfyEvent: Record NtfyEventNTSTM)
    begin

    end;

    procedure DoCallNtfyEvent(NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Boolean
    begin

    end;

    procedure GetTitle(NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Text[150]
    begin

    end;

    procedure GetMessage(NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Text[2048]
    begin

    end;

    procedure ResetSettings(NtfyEvent: Record NtfyEventNTSTM)
    begin

    end;

    procedure FilterNtfyEntriesBeforeBatchSend(var NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text])
    begin

    end;
}