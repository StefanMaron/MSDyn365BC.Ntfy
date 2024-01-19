codeunit 50007 RunBatchWrapperEmptyNTSTM implements IRunBatchNTSTM
{

    var
        RunBatchWasCalled: Boolean;

    procedure RunBatch(var Rec: Record NtfyEventRequestNTSTM)
    begin
        RunBatchWasCalled := true;
    end;

    procedure GetRunBatchWasCalled(): Boolean
    begin
        exit(RunBatchWasCalled);
    end;

}