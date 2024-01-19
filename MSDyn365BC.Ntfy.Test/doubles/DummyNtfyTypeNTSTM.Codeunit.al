codeunit 50006 DummyNtfyTypeNTSTM implements INtfyEventNTSTM
{
    var
        SetSettingsWasCalled: Boolean;
        ResetSettingsWasCalled: Boolean;
        FilterNtfyEntriesBeforeBatchSendWasCalled: Boolean;
        DoCallNtfyEventWasCalled: Boolean;
        GetMessageWasCalled: Boolean;

    procedure SetSettings(NtfyEvent: Record NtfyEventNTSTM);
    begin
        SetSettingsWasCalled := true;
    end;

    procedure ResetSettings(NtfyEvent: Record NtfyEventNTSTM);
    begin
        ResetSettingsWasCalled := true;
    end;

    procedure FilterNtfyEntriesBeforeBatchSend(var NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]);
    begin
        FilterNtfyEntriesBeforeBatchSendWasCalled := true;
    end;

    procedure DoCallNtfyEvent(NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Boolean;
    begin
        DoCallNtfyEventWasCalled := true;
        exit(true);
    end;

    procedure GetMessage(NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Text[2048];
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

    procedure GetDoCallNtfyEventWasCalled(): Boolean;
    begin
        exit(DoCallNtfyEventWasCalled);
    end;

    procedure GetGetMessageWasCalled(): Boolean;
    begin
        exit(GetMessageWasCalled);
    end;
}