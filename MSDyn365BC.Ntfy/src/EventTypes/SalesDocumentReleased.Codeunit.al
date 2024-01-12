namespace StefanMaron.Ntfy;
using Microsoft.Sales.Document;
using System.RestClient;

codeunit 71179877 SalesDocumentReleasedNTSTM implements INtfyEventNTSTM
{

    procedure SetSettings(NtfyEntry: Record NtfyEntryNTSTM)
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

    procedure ResetSettings(NtfyEntry: Record NtfyEntryNTSTM);
    begin
        NtfyEntry.Validate(FilterText, '');
        NtfyEntry.Modify(true);
    end;

    procedure FilterNtfyEntriesBeforeBatchSend(var NtfyEntry: Record NtfyEntryNTSTM; Params: Dictionary of [Text, Text]);
    begin

    end;

    procedure DoCallNtfyEntry(NtfyEntry: Record NtfyEntryNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Boolean
    var
        FilterSalesHeader: Record "Sales Header";
    begin
        ReturnValue := true;
        if NtfyEntry.FilterText <> '' then begin
            FilterSalesHeader.SetView(NtfyEntry.FilterText);
            FilterSalesHeader.FilterGroup(2);
            FilterSalesHeader.SetRange(SystemId, Params.Get('SystemID'));
            ReturnValue := not FilterSalesHeader.IsEmpty();
        end;
    end;

    procedure GetMessage(Params: Dictionary of [Text, Text]) ReturnValue: Text[2048]
    begin
        exit(StrSubstNo('Sales %1 - %2 - has been released', Params.Get('DocumentType'), Params.Get('No')));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnAfterReleaseSalesDoc, '', false, false)]
    local procedure SentNtfyOnAfterReleaseSalesDoc(var SalesHeader: Record "Sales Header")
    var
        NtfyEntry: Record NtfyEntryNTSTM;
        Params: Dictionary of [Text, Text];
    begin
        Params.Add('SystemID', SalesHeader."SystemId");
        Params.Add('DocumentType', Format(SalesHeader."Document Type"));
        Params.Add('No', SalesHeader."No.");
        NtfyEntry.SendNotifications(NtfyEntry.EventType::SalesDocumentReleased, Params);
    end;
}