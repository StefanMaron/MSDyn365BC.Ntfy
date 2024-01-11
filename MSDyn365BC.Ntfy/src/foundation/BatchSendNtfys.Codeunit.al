namespace StefanMaron.Ntfy;

using System.RestClient;

codeunit 71179879 BatchSendNtfysNTSTM
{
    TableNo = NtfyEntryNTSTM;

    trigger OnRun()
    var
        NtfyEntry: Record NtfyEntryNTSTM;
        RestClient: Codeunit "Rest Client";
        Body: Codeunit "Http Content";
        Description: Text;
    begin
        IsolatedStorage.Get('NtfyDescription', DataScope::User, Description);
        Body.Create(Description);
        IsolatedStorage.Delete('NtfyDescription', DataScope::User);

        if NtfyEntry.FindSet() then
            repeat
                Clear(RestClient);
                RestClient.Post(StrSubstNo('https://ntfy.sh/%1', NtfyEntry.NtfyTopic), Body);
            until NtfyEntry.Next() = 0;
    end;
}