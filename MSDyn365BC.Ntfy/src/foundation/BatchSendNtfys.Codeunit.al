namespace StefanMaron.Ntfy;

using System.RestClient;

codeunit 71179879 BatchSendNtfysNTSTM
{
    TableNo = NtfyEventRequestNTSTM;
    InherentEntitlements = X;
    InherentPermissions = X;

    trigger OnRun()
    var
        RestWrapper: Codeunit RestWrapperNTSTM;
    begin
        SendRequests(Rec, RestWrapper);
    end;

    internal procedure SendRequests(var Rec: Record NtfyEventRequestNTSTM; IRestWrapper: Interface IRestWrapperNTSTM)
    var
        Body: Codeunit "Http Content";
    begin
        Body := IRestWrapper.CreateBody(Rec.NtfyMessage);

        if Rec.FindSet() then
            repeat
                IRestWrapper.Post(StrSubstNo('https://ntfy.sh/%1', Rec.NtfyTopic), Body);
            until Rec.Next() = 0;
    end;
}