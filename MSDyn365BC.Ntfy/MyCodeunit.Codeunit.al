namespace DefaultPublisher.Ntfy;
using Microsoft.Sales.Document;
using System.RestClient;

codeunit 71179875 MyCodeunitNTSTM
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnAfterReleaseSalesDoc, '', false, false)]
    local procedure SentNtfyOnAfterReleaseSalesDoc(var SalesHeader: Record "Sales Header")
    var
        NtfyEntry: Record NtfyEntryNTSTM;
        RestClient: Codeunit "Rest Client";
        Body: Codeunit "Http Content";

    begin
        NtfyEntry.SetRange(EventType, NtfyEntry.EventType::SalesDocumentReleased);
        NtfyEntry.SetFilter(NtfyTopic, '<>%1', '');
        if not NtfyEntry.FindFirst() then
            exit;

        Body.Create(StrSubstNo('Sales %1 - %2 - has been released', SalesHeader."Document Type", SalesHeader."No."));
        //Body.SetHeader('Title', 'AL Extension');
        RestClient.Post(StrSubstNo('https://ntfy.sh/%1', NtfyEntry.NtfyTopic), Body).GetContent().AsText();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnAfterReopenSalesDoc, '', false, false)]
    local procedure SentNtfyOnAfterReopenSalesDoc(var SalesHeader: Record "Sales Header")
    var
        NtfyEntry: Record NtfyEntryNTSTM;
        RestClient: Codeunit "Rest Client";
        Body: Codeunit "Http Content";
    begin
        NtfyEntry.SetRange(EventType, NtfyEntry.EventType::SalesDocumentReopened);
        NtfyEntry.SetFilter(NtfyTopic, '<>%1', '');
        if not NtfyEntry.FindFirst() then
            exit;

        Body.Create(StrSubstNo('Sales %1 - %2 - has been reopened', SalesHeader."Document Type", SalesHeader."No."));
        //Body.SetHeader('Title', 'AL Extension');
        RestClient.Post(StrSubstNo('https://ntfy.sh/%1', NtfyEntry.NtfyTopic), Body).GetContent().AsText();
    end;
}