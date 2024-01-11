namespace StefanMaron.Ntfy;

using System.RestClient;

codeunit 71179879 BatchSendNtfysNTSTM
{
    TableNo = NtfyEntryNTSTM;

    trigger OnRun()
    var
        RestClient: Codeunit "Rest Client";
        Body: Codeunit "Http Content";
    begin
        Body.Create(Rec.NtfyMessage);

        if Rec.FindSet() then
            repeat
                Clear(RestClient);
                RestClient.Post(StrSubstNo('https://ntfy.sh/%1', Rec.NtfyTopic), Body);
            until Rec.Next() = 0;
    end;
}