namespace StefanMaron.Ntfy;
using System.Security.AccessControl;


table 71179876 NtfyTopicNTSTM
{
    Caption = 'Ntfy Topic';
    DrillDownPageId = NtfyTopicsNTSTM;
    LookupPageId = NtfyTopicsNTSTM;
    DataClassification = CustomerContent;

    fields
    {
        field(1; UserName; Text[50])
        {
            Caption = 'User Name';
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
        field(2; Topic; Text[150])
        {
            Caption = 'Topic';
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