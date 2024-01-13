codeunit 50009 MarkingTestRunBatchNTSTM implements IRunBatchNTSTM
{


    procedure RunBatch(var Rec: Record NtfyEntryNTSTM)
    var
        Assert: Codeunit "Library Assert";
    begin
        Assert.AreEqual(1, Rec.Count, 'Marked only did not work');
    end;

}