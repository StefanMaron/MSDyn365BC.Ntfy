codeunit 71179881 RunBatchWrapperNTSTM implements IRunBatchNTSTM
{
    InherentEntitlements = X;
    InherentPermissions = X;

    procedure RunBatch(var Rec: Record NtfyEventRequestNTSTM)
    begin
        Rec.RunBatch();
    end;
}