codeunit 71179881 RunBatchWrapperNTSTM implements IRunBatchNTSTM
{
    procedure RunBatch(var Rec: Record NtfyEventNTSTM)
    begin
        Rec.RunBatch();
    end;
}