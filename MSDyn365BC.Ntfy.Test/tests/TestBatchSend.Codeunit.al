codeunit 50000 "TestBatchSend"
{
    Subtype = Test;

    var
        Assert: Codeunit "Library Assert";

    [Test]
    procedure TestCreateBodyGetsCalled()
    var
        NtfyEventRequest: Record NtfyEventRequestNTSTM;
        BatchSend: Codeunit BatchSendNtfysNTSTM;
        RestWrapper: Codeunit RestWrapperTestBodyNTSTM;
    begin
        NtfyEventRequest.Init();
        NtfyEventRequest.NtfyMessage := 'Hello World';
        if not NtfyEventRequest.Insert() then;
        asserterror BatchSend.SendRequests(NtfyEventRequest, RestWrapper);

        Assert.ExpectedError('CreateBody was called');
    end;

    [Test]
    procedure TestPostGetsCalled()
    var
        NtfyEventRequest: Record NtfyEventRequestNTSTM;
        BatchSend: Codeunit BatchSendNtfysNTSTM;
        RestWrapper: Codeunit RestWrapperTestPostNTSTM;
    begin
        NtfyEventRequest.Init();
        NtfyEventRequest.NtfyMessage := 'Hello World';
        if not NtfyEventRequest.Insert() then;
        asserterror BatchSend.SendRequests(NtfyEventRequest, RestWrapper);

        Assert.ExpectedError(StrSubstNo('Post was called with RequestUri: %1', StrSubstNo('https://ntfy.sh/%1', NtfyEventRequest.NtfyTopic)));
    end;

    [Test]
    procedure TestBodyGetsPassedToPostCorrectly()
    var
        NtfyEventRequest: Record NtfyEventRequestNTSTM;
        BatchSend: Codeunit BatchSendNtfysNTSTM;
        RestWrapper: Codeunit RestWrapBodyPassNTSTM;
    begin
        NtfyEventRequest.Init();
        NtfyEventRequest.NtfyMessage := 'Hello World';
        if not NtfyEventRequest.Insert() then;
        BatchSend.SendRequests(NtfyEventRequest, RestWrapper);
    end;


}

