codeunit 50000 "TestBatchSend"
{
    Subtype = Test;

    var
        Assert: Codeunit "Library Assert";

    [Test]
    procedure TestCreateBodyGetsCalled()
    var
        NtfyEntry: Record NtfyEntryNTSTM temporary;
        BatchSend: Codeunit BatchSendNtfysNTSTM;
        RestWrapper: Codeunit RestWrapperTestBodyNTSTM;
    begin
        NtfyEntry.Init();
        NtfyEntry.NtfyMessage := 'Hello World';
        if not NtfyEntry.Insert() then;
        asserterror BatchSend.SendRequests(NtfyEntry, RestWrapper);

        Assert.ExpectedError('CreateBody was called');
    end;

    [Test]
    procedure TestPostGetsCalled()
    var
        NtfyEntry: Record NtfyEntryNTSTM temporary;
        BatchSend: Codeunit BatchSendNtfysNTSTM;
        RestWrapper: Codeunit RestWrapperTestPostNTSTM;
    begin
        NtfyEntry.Init();
        NtfyEntry.NtfyMessage := 'Hello World';
        if not NtfyEntry.Insert() then;
        asserterror BatchSend.SendRequests(NtfyEntry, RestWrapper);

        Assert.ExpectedError(StrSubstNo('Post was called with RequestUri: %1', StrSubstNo('https://ntfy.sh/%1', NtfyEntry.NtfyTopic)));
    end;

    [Test]
    procedure TestBodyGetsPassedToPostCorrectly()
    var
        NtfyEntry: Record NtfyEntryNTSTM temporary;
        BatchSend: Codeunit BatchSendNtfysNTSTM;
        RestWrapper: Codeunit RestWrapBodyPassNTSTM;
    begin
        NtfyEntry.Init();
        NtfyEntry.NtfyMessage := 'Hello World';
        if not NtfyEntry.Insert() then;
        BatchSend.SendRequests(NtfyEntry, RestWrapper);
    end;


}

