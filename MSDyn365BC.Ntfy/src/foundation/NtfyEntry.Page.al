namespace StefanMaron.Ntfy;
using StefanMaron.Ntfy;
page 71179875 NtfyEntryNTSTM
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    DelayedInsert = true;
    SourceTable = NtfyEntryNTSTM;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(UserName; Rec.UserName) { }
                field(NtfyTopic; Rec.NtfyTopic) { }
                field(EventType; Rec.EventType) { }
            }
        }
    }
}