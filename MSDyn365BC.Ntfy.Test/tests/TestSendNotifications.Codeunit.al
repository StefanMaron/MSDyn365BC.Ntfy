codeunit 50004 "TestSendNotifications"
{
    Subtype = Test;

    var
        Assert: Codeunit "Library Assert";

    [Test]
    procedure TestIfFunctionsGetCalled()
    var
        NtfyEvent: Record NtfyEventNTSTM temporary;
        Params: Dictionary of [Text, Text];
        RunBatchWrapperEmpty: Codeunit RunBatchWrapperEmptyNTSTM;
        DummyNtfyType: Codeunit DummyNtfyTypeNTSTM;
    begin
        NtfyEvent.Init();
        // NtfyEvent.NtfyMessage := 'Hello World'; //fixme
        NtfyEvent.Topic := 'Hello World';
        NtfyEvent.EventType := NtfyEvent.EventType::DummyNtfyType;
        if not NtfyEvent.Insert() then;
        NtfyEvent.SendNotifications(DummyNtfyType, NtfyEvent.EventType::DummyNtfyType, Params, RunBatchWrapperEmpty);

        Assert.IsTrue(DummyNtfyType.GetFilterNtfyEntriesBeforeBatchSendWasCalled(), 'FilterNtfyEntriesBeforeBatchSend was not called');
        Assert.IsTrue(DummyNtfyType.GetDoCallNtfyEventWasCalled(), 'DoCallNtfyEvent was not called');
        Assert.IsTrue(DummyNtfyType.GetGetMessageWasCalled(), 'GetMessage was not called');
        Assert.IsTrue(RunBatchWrapperEmpty.GetRunBatchWasCalled(), 'RunBatch was not called');
    end;

    [Test]
    procedure TestIfMarkingWorks()
    var
        NtfyEvent: Record NtfyEventNTSTM temporary;
        Params: Dictionary of [Text, Text];
        MarkingTestRunBatch: Codeunit MarkingTestRunBatchNTSTM;
        MarkingTestType: Codeunit MarkingTestTypeNTSTM;
    begin
        NtfyEvent.Init();
        // NtfyEvent.NtfyMessage := 'true'; //fixme
        NtfyEvent.Topic := 'true';
        NtfyEvent.EventType := NtfyEvent.EventType::DummyNtfyType;
        if not NtfyEvent.Insert() then;
        NtfyEvent.Init();
        // NtfyEvent.NtfyMessage := 'false'; //fixme
        NtfyEvent.Topic := 'false';
        NtfyEvent.EventType := NtfyEvent.EventType::DummyNtfyType;
        if not NtfyEvent.Insert() then;

        NtfyEvent.SendNotifications(MarkingTestType, NtfyEvent.EventType::DummyNtfyType, Params, MarkingTestRunBatch);
    end;
}

