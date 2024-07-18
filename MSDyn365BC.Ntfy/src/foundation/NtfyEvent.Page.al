namespace StefanMaron.Ntfy;
using StefanMaron.Ntfy;
page 71179875 NtfyEventsNTSTM
{
    Caption = 'Ntfy Events';
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = None;
    DelayedInsert = true;
    SourceTable = NtfyEventNTSTM;
    PopulateAllFields = true;
    AutoSplitKey = true;
    InherentEntitlements = X;
    InherentPermissions = X;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(EventType; Rec.EventType) { }
                field(Description; Rec.Description) { }
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
}