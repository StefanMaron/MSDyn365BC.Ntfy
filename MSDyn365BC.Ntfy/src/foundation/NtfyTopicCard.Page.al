namespace StefanMaron.Ntfy;
using StefanMaron.Ntfy;
page 71179878 NtfyTopicCardNTSTM
{
    Caption = 'Ntfy Topic';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    DelayedInsert = true;
    PopulateAllFields = true;
    SourceTable = NtfyTopicNTSTM;
    InherentEntitlements = X;
    InherentPermissions = X;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(NtfyTopic; Rec.Topic) { }
                field(UserName; Rec.UserName) { }
                field(Enabled; Rec.Enabled) { }
            }
            part(NtfyEventsNTSTM; NtfyEventsNTSTM)
            {
                Caption = 'Events';
                SubPageLink = UserName = field(UserName), Topic = field(Topic);
            }
        }
    }
}