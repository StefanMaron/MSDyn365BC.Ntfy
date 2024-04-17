namespace StefanMaron.Ntfy;
using StefanMaron.Ntfy;
page 71179876 NtfyTopicsNTSTM
{
    Caption = 'Ntfy Topics';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    DelayedInsert = true;
    PopulateAllFields = true;
    SourceTable = NtfyTopicNTSTM;
    InherentEntitlements = X;
    InherentPermissions = X;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(UserName; Rec.UserName)
                {
                    //TODO: Visible for administrators
                    Visible = false;
                }
                field(NtfyTopic; Rec.Topic) { }
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