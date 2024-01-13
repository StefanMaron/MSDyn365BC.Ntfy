codeunit 50004 "TestSendNotifications"
{
    Subtype = Test;

    var
        Assert: Codeunit "Library Assert";

    [Test]
    procedure TestIfFunctionsGetCalled()
    var
        NtfyEntry: Record NtfyEntryNTSTM temporary;
        Params: Dictionary of [Text, Text];
        RunBatchWrapperEmpty: Codeunit RunBatchWrapperEmptyNTSTM;
        DummyNtfyType: Codeunit DummyNtfyTypeNTSTM;
    begin
        NtfyEntry.Init();
        NtfyEntry.NtfyMessage := 'Hello World';
        NtfyEntry.NtfyTopic := 'Hello World';
        NtfyEntry.EventType := NtfyEntry.EventType::DummyNtfyType;
        if not NtfyEntry.Insert() then;
        NtfyEntry.SendNotifications(DummyNtfyType, NtfyEntry.EventType::DummyNtfyType, Params, RunBatchWrapperEmpty);

        Assert.IsTrue(DummyNtfyType.GetFilterNtfyEntriesBeforeBatchSendWasCalled(), 'FilterNtfyEntriesBeforeBatchSend was not called');
        Assert.IsTrue(DummyNtfyType.GetDoCallNtfyEntryWasCalled(), 'DoCallNtfyEntry was not called');
        Assert.IsTrue(DummyNtfyType.GetGetMessageWasCalled(), 'GetMessage was not called');
        Assert.IsTrue(RunBatchWrapperEmpty.GetRunBatchWasCalled(), 'RunBatch was not called');
    end;

    [Test]
    procedure TestIfMarkingWorks()
    var
        NtfyEntry: Record NtfyEntryNTSTM temporary;
        Params: Dictionary of [Text, Text];
        MarkingTestRunBatch: Codeunit MarkingTestRunBatchNTSTM;
        MarkingTestType: Codeunit MarkingTestTypeNTSTM;
    begin
        NtfyEntry.Init();
        NtfyEntry.NtfyMessage := 'true';
        NtfyEntry.NtfyTopic := 'true';
        NtfyEntry.EventType := NtfyEntry.EventType::DummyNtfyType;
        if not NtfyEntry.Insert() then;
        NtfyEntry.Init();
        NtfyEntry.NtfyMessage := 'false';
        NtfyEntry.NtfyTopic := 'false';
        NtfyEntry.EventType := NtfyEntry.EventType::DummyNtfyType;
        if not NtfyEntry.Insert() then;

        NtfyEntry.SendNotifications(MarkingTestType, NtfyEntry.EventType::DummyNtfyType, Params, MarkingTestRunBatch);
    end;
}

