namespace StefanMaron.Ntfy;
using System.Security.AccessControl;


table 71179877 NtfyEventRequestNTSTM
{
    TableType = Temporary;
    InherentEntitlements = RIMDX;
    InherentPermissions = RIMDX;

    fields
    {
        field(1; EntryNo; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; NtfyTopic; Text[150])
        {
            Caption = 'Topic';
        }
        field(3; NtfyTitle; Text[150])
        {
            Caption = 'Title';
        }
        field(4; NtfyMessage; Text[2048])
        {
            Caption = 'Message';
        }
    }

    keys
    {
        key(Key1; EntryNo)
        {
            Clustered = true;
        }
    }

    procedure RunBatch()
    var
        TempSessionId: Integer;
    begin
        //TODO: Handle System app Web request allow for sandboxes
        if not StartSession(TempSessionId, Codeunit::BatchSendNtfysNTSTM, CompanyName, Rec) then
            Codeunit.Run(Codeunit::BatchSendNtfysNTSTM, Rec);
    end;
}