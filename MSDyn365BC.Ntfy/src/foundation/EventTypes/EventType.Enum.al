namespace StefanMaron.Ntfy;

enum 71179875 EventTypeNTSTM implements INtfyEventNTSTM
{
    Extensible = true;
    DefaultImplementation = INtfyEventNTSTM = EmptyEventNTSTM;

    value(0; "")
    {
        Caption = '', Locked = true;
    }

    value(1; SalesDocumentReopened) { }
    value(2; SalesDocumentReleased) { }
}