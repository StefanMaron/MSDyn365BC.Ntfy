namespace StefanMaron.Ntfy;
using StefanMaron.Ntfy;
page 71179876 NtfyTopicListNTSTM
{
    Caption = 'Ntfy Topics';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    CardPageId = NtfyTopicCardNTSTM;
    DelayedInsert = true;
    Editable = false;
    SourceTable = NtfyTopicNTSTM;
    InherentEntitlements = X;
    InherentPermissions = X;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(NtfyTopic; Rec.Topic) { }
                field(UserName; Rec.UserName) { }
                field(Enabled; Rec.Enabled) { }
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetUserFilter();
    end;

    local procedure SetUserFilter()
    begin
        //TODO: Administrators should be able to see all users
        Rec.FilterGroup(2);
        Rec.SetRange(UserName, UserId);
        Rec.FilterGroup(0);
    end;
}