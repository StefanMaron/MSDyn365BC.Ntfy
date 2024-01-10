namespace StefanMaron.Ntfy;
using System.Security.AccessControl;


table 71179875 NtfyEntryNTSTM
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; UserName; Text[50])
        {
            Caption = 'User Name';
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
        field(2; NtfyTopic; Text[150])
        {
            Caption = 'Topic';
        }
        field(3; EventType; Enum EventTypeNTSTM)
        {
            Caption = 'Event Type';
        }
    }

    keys
    {
        key(Key1; UserName, NtfyTopic)
        {
            Clustered = true;
        }
    }
}