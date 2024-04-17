namespace StefanMaron.Ntfy;
using StefanMaron.Ntfy;
page 71179875 NtfyEventsNTSTM
{
    Caption = 'Ntfy Events';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    DelayedInsert = true;
    SourceTable = NtfyEventNTSTM;
    PopulateAllFields = true;
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
                field(NtfyTopic; Rec.NtfyTopic) { }
                field(EventType; Rec.EventType) { }
                field(FilterText; Rec.FilterText)
                {
                    Caption = 'Filter';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SetSettings)
            {
                ApplicationArea = All;
                Caption = 'Settings';
                Promoted = true;
                PromotedCategory = Process;
                Image = Setup;

                trigger OnAction()
                begin
                    Rec.SetSettingsTroughInterface();
                end;
            }
            action(ResetSettings)
            {
                ApplicationArea = All;
                Caption = 'Reset Settings';
                Promoted = true;
                PromotedCategory = Process;
                Image = Restore;

                trigger OnAction()
                begin
                    Rec.ResetSettingsTroughInterface();
                end;
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