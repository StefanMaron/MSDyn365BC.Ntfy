namespace StefanMaron.Ntfy;

interface INtfyEventNTSTM
{
    procedure SetSettings(NtfyEvent: Record NtfyEventNTSTM)
    procedure ResetSettings(NtfyEvent: Record NtfyEventNTSTM)
    procedure FilterNtfyEntriesBeforeBatchSend(var NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text])
    procedure DoCallNtfyEvent(NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Boolean
    procedure GetMessage(NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Text[2048]
    procedure GetTitle(NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Text[150]

}