namespace StefanMaron.Ntfy;
using Microsoft.Sales.Document;
using System.RestClient;

codeunit 71179877 SalesDocumentReleasedNTSTM implements INtfyEventNTSTM
{

    procedure SetSettings(NtfyEvent: Record NtfyEventNTSTM)
    var
        FilterPageBuilder: FilterPageBuilder;
    begin
        FilterPageBuilder.AddTable('Sales Header', Database::"Sales Header");
        if NtfyEvent.FilterText <> '' then
            FilterPageBuilder.SetView('Sales Header', NtfyEvent.FilterText);
        if FilterPageBuilder.RunModal() then begin
            if not FilterPageBuilder.GetView('Sales Header').Contains('WHERE') then
                NtfyEvent.Validate(FilterText, '')
            else
                NtfyEvent.Validate(FilterText, FilterPageBuilder.GetView('Sales Header'));
            NtfyEvent.Modify(true);
        end;
    end;

    procedure ResetSettings(NtfyEvent: Record NtfyEventNTSTM)
    begin
        NtfyEvent.Validate(FilterText, '');
        NtfyEvent.Modify(true);
    end;

    procedure FilterNtfyEntriesBeforeBatchSend(var NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text])
    begin

    end;

    procedure DoCallNtfyEvent(NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Boolean
    var
        FilterSalesHeader: Record "Sales Header";
    begin
        ReturnValue := true;
        if NtfyEvent.FilterText <> '' then begin
            FilterSalesHeader.SetView(NtfyEvent.FilterText);
            FilterSalesHeader.FilterGroup(2);
            FilterSalesHeader.SetRange(SystemId, Params.Get('SystemID'));
            ReturnValue := not FilterSalesHeader.IsEmpty();
        end;
    end;

    procedure GetMessage(NtfyEvent: Record NtfyEventNTSTM; Params: Dictionary of [Text, Text]) ReturnValue: Text[2048]
    begin
        exit(StrSubstNo('Sales %1 - %2 - has been released', Params.Get('DocumentType'), Params.Get('No')));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnAfterReleaseSalesDoc, '', false, false)]
    local procedure SentNtfyOnAfterReleaseSalesDoc(var SalesHeader: Record "Sales Header")
    var
        NtfyEvent: Record NtfyEventNTSTM;
        Params: Dictionary of [Text, Text];
    begin
        Params.Add('SystemID', SalesHeader."SystemId");
        Params.Add('DocumentType', Format(SalesHeader."Document Type"));
        Params.Add('No', SalesHeader."No.");
        NtfyEvent.SendNotifications(NtfyEvent.EventType::SalesDocumentReleased, Params);
    end;
}