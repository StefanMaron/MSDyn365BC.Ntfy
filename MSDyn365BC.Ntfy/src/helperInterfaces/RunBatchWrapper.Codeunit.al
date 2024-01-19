codeunit 71179881 RunBatchWrapperNTSTM implements IRunBatchNTSTM
{
    procedure RunBatch(var Rec: Record NtfyEventRequestNTSTM)
    begin
        Rec.RunBatch();
    end;
}