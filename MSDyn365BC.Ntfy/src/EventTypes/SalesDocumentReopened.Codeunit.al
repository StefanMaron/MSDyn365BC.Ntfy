namespace StefanMaron.Ntfy;
using Microsoft.Sales.Document;
using System.RestClient;

codeunit 71179878 SalesDocumentReopenedNTSTM implements INtfyEventNTSTM
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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnAfterReopenSalesDoc, '', false, false)]
    local procedure SentNtfyOnAfterReopenSalesDoc(var SalesHeader: Record "Sales Header")
    var
        FilterSalesHeader: Record "Sales Header";
        NtfyEntry: Record NtfyEntryNTSTM;
        DoCall: Boolean;
    begin
        IsolatedStorage.Set('NtfyDescription', StrSubstNo('Sales %1 - %2 - has been released', SalesHeader."Document Type", SalesHeader."No."), DataScope::User);

        NtfyEntry.SetRange(EventType, NtfyEntry.EventType::SalesDocumentReopened);
        NtfyEntry.SetFilter(NtfyTopic, '<>%1', '');
        if NtfyEntry.FindSet() then
            repeat
                Clear(FilterSalesHeader);
                DoCall := true;

                if NtfyEntry.FilterText <> '' then begin
                    FilterSalesHeader.SetView(NtfyEntry.FilterText);
                    FilterSalesHeader.FilterGroup(2);
                    FilterSalesHeader.SetRange(SystemId, SalesHeader."SystemId");
                    DoCall := not FilterSalesHeader.IsEmpty();
                end;

                if DoCall then
                    NtfyEntry.Mark(true);
            until NtfyEntry.Next() = 0;

        NtfyEntry.MarkedOnly(true);
        NtfyEntry.RunBatch();
    end;

}