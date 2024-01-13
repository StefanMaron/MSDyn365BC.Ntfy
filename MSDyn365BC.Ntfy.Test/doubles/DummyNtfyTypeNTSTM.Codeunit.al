codeunit 50006 DummyNtfyTypeNTSTM implements INtfyEventNTSTM
{
    var
        SetSettingsWasCalled: Boolean;
        ResetSettingsWasCalled: Boolean;
        FilterNtfyEntriesBeforeBatchSendWasCalled: Boolean;
        DoCallNtfyEntryWasCalled: Boolean;
        GetMessageWasCalled: Boolean;

    procedure SetSettings(NtfyEntry: Record NtfyEntryNTSTM);
    begin
        SetSettingsWasCalled := true;
    end;

    procedure ResetSettings(NtfyEntry: Record NtfyEntryNTSTM);
    begin
        ResetSettingsWasCalled := true;
    end;

    procedure FilterNtfyEntriesBeforeBatchSend(var NtfyEntry: Record NtfyEntryNTSTM; Params: Dictionary of [Text, Text]);
    begin
        FilterNtfyEntriesBeforeBatchSendWasCalled := true;
    end;

    procedure DoCallNtfyEntry(NtfyEntry: Record NtfyEntryNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Boolean;
    begin
        DoCallNtfyEntryWasCalled := true;
    end;

    procedure GetMessage(Params: Dictionary of [Text, Text]) ReturnValue: Text[2048];
    begin
        GetMessageWasCalled := true;
    end;

    procedure GetSetSettingsWasCalled(): Boolean;
    begin
        exit(SetSettingsWasCalled);
    end;

    procedure GetResetSettingsWasCalled(): Boolean;
    begin
        exit(ResetSettingsWasCalled);
    end;

    procedure GetFilterNtfyEntriesBeforeBatchSendWasCalled(): Boolean;
    begin
        exit(FilterNtfyEntriesBeforeBatchSendWasCalled);
    end;

    procedure GetDoCallNtfyEntryWasCalled(): Boolean;
    begin
        exit(DoCallNtfyEntryWasCalled);
    end;

    procedure GetGetMessageWasCalled(): Boolean;
    begin
        exit(GetMessageWasCalled);
    end;
}