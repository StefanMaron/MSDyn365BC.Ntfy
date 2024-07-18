namespace StefanMaron.Ntfy;
using System.Security.AccessControl;


table 71179876 NtfyTopicNTSTM
{
    Caption = 'Ntfy Topic';
    DrillDownPageId = NtfyTopicListNTSTM;
    LookupPageId = NtfyTopicListNTSTM;
    DataClassification = CustomerContent;
    InherentEntitlements = RIMDX;
    InherentPermissions = RIMDX;

    fields
    {
        field(1; UserName; Text[50])
        {
            Caption = 'User Name';
            TableRelation = User."User Name";
            ValidateTableRelation = false;
            Editable = false;
        }
        field(2; Topic; Text[150])
        {
            Caption = 'Topic';
        }
        field(3; Enabled; Boolean)
        {
            Caption = 'Enabled';
            InitValue = true;
        }
    }

    keys
    {
        key(Key1; UserName, Topic)
        {
            Clustered = true;
        }
    }
}