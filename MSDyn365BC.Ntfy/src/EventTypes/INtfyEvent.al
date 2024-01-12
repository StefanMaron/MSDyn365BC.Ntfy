namespace StefanMaron.Ntfy;

interface INtfyEventNTSTM
{
    procedure SetSettings(NtfyEntry: Record NtfyEntryNTSTM)
    procedure ResetSettings(NtfyEntry: Record NtfyEntryNTSTM)
    procedure DoCallNtfyEntry(NtfyEntry: Record NtfyEntryNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Boolean
    procedure GetMessage(Params: Dictionary of [Text, Text]) ReturnValue: Text[2048]

}