codeunit 50000 "TestBatchSend"
{
    Subtype = Test;

    var
        Assert: Codeunit "Library Assert";

    [Test]
    procedure TestCreateBodyGetsCalled()
    var
        NtfyEvent: Record NtfyEventNTSTM temporary;
        BatchSend: Codeunit BatchSendNtfysNTSTM;
        RestWrapper: Codeunit RestWrapperTestBodyNTSTM;
    begin
        NtfyEvent.Init();
        NtfyEvent.NtfyMessage := 'Hello World';
        if not NtfyEvent.Insert() then;
        asserterror BatchSend.SendRequests(NtfyEvent, RestWrapper);

        Assert.ExpectedError('CreateBody was called');
    end;

    [Test]
    procedure TestPostGetsCalled()
    var
        NtfyEvent: Record NtfyEventNTSTM temporary;
        BatchSend: Codeunit BatchSendNtfysNTSTM;
        RestWrapper: Codeunit RestWrapperTestPostNTSTM;
    begin
        NtfyEvent.Init();
        NtfyEvent.NtfyMessage := 'Hello World';
        if not NtfyEvent.Insert() then;
        asserterror BatchSend.SendRequests(NtfyEvent, RestWrapper);

        Assert.ExpectedError(StrSubstNo('Post was called with RequestUri: %1', StrSubstNo('https://ntfy.sh/%1', NtfyEvent.NtfyTopic)));
    end;

    [Test]
    procedure TestBodyGetsPassedToPostCorrectly()
    var
        NtfyEvent: Record NtfyEventNTSTM temporary;
        BatchSend: Codeunit BatchSendNtfysNTSTM;
        RestWrapper: Codeunit RestWrapBodyPassNTSTM;
    begin
        NtfyEvent.Init();
        NtfyEvent.NtfyMessage := 'Hello World';
        if not NtfyEvent.Insert() then;
        BatchSend.SendRequests(NtfyEvent, RestWrapper);
    end;


}

