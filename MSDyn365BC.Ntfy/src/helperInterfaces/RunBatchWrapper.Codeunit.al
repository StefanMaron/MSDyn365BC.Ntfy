codeunit 71179881 RunBatchWrapperNTSTM implements IRunBatchNTSTM
{
    procedure RunBatch(var Rec: Record NtfyEntryNTSTM)
    begin
        Rec.RunBatch();
    end;
}