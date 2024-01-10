namespace StefanMaron.Ntfy;
using Microsoft.Sales.Document;
using System.RestClient;

codeunit 71179877 SalesDocumentReleasedNTSTM implements INtfyEventNTSTM
{

    procedure SetFilters(NtfyEntry: Record NtfyEntryNTSTM)
    var
        FilterPageBuilder: FilterPageBuilder;
    begin
        FilterPageBuilder.AddTable('Sales Header', Database::"Sales Header");
        if NtfyEntry.FilterText <> '' then
            FilterPageBuilder.SetView('Sales Header', NtfyEntry.FilterText);
        if FilterPageBuilder.RunModal() then begin
            if not FilterPageBuilder.GetView('Sales Header').Contains('WHERE') then
                NtfyEntry.Validate(FilterText, '')
            else
                NtfyEntry.Validate(FilterText, FilterPageBuilder.GetView('Sales Header'));
            NtfyEntry.Modify(true);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnAfterReleaseSalesDoc, '', false, false)]
    local procedure SentNtfyOnAfterReleaseSalesDoc(var SalesHeader: Record "Sales Header")
    var
        FilterSalesHeader: Record "Sales Header";
        NtfyEntry: Record NtfyEntryNTSTM;
        RestClient: Codeunit "Rest Client";
        Body: Codeunit "Http Content";
        DoCall: Boolean;
    begin
        NtfyEntry.SetRange(EventType, NtfyEntry.EventType::SalesDocumentReleased);
        NtfyEntry.SetFilter(NtfyTopic, '<>%1', '');
        if NtfyEntry.FindSet() then
            repeat
                Clear(Body);
                Clear(RestClient);
                Clear(FilterSalesHeader);
                DoCall := true;

                if NtfyEntry.FilterText <> '' then begin
                    FilterSalesHeader.SetView(NtfyEntry.FilterText);
                    FilterSalesHeader.FilterGroup(2);
                    FilterSalesHeader.SetRange(SystemId, SalesHeader."SystemId");
                    DoCall := not FilterSalesHeader.IsEmpty();
                end;

                if DoCall then begin
                    Body.Create(StrSubstNo('Sales %1 - %2 - has been released', SalesHeader."Document Type", SalesHeader."No."));
                    RestClient.Post(StrSubstNo('https://ntfy.sh/%1', NtfyEntry.NtfyTopic), Body).GetContent().AsText();
                end;
            until NtfyEntry.Next() = 0;

    end;

}