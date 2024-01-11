namespace StefanMaron.Ntfy;

enum 71179875 EventTypeNTSTM implements INtfyEventNTSTM
{
    Extensible = true;
    DefaultImplementation = INtfyEventNTSTM = EmptyEventNTSTM;

    value(0; "")
    {
        Caption = '', Locked = true;
    }

    value(1; SalesDocumentReopened)
    {
        Caption = 'Sales document reopened';
        Implementation = INtfyEventNTSTM = SalesDocumentReopenedNTSTM;
    }
    value(2; SalesDocumentReleased)
    {
        Caption = 'Sales document released';
        Implementation = INtfyEventNTSTM = SalesDocumentReleasedNTSTM;
    }
}