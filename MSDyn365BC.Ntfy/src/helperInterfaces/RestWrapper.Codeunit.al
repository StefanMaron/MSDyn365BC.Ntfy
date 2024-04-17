codeunit 71179880 RestWrapperNTSTM implements IRestWrapperNTSTM
{
    InherentEntitlements = X;
    InherentPermissions = X;

    var
        RestClient: Codeunit "Rest Client";

    procedure CreateBody(Content: Text) HttpContent: Codeunit System.RestClient."Http Content"
    begin
        HttpContent.Create(Content);
    end;

    procedure SetDefaultRequestHeader(Name: Text; Value: Text)
    begin
        RestClient.SetDefaultRequestHeader(Name, Value);
    end;

    procedure Post(RequestUri: Text; Content: Codeunit System.RestClient."Http Content") HttpResponseMessage: Codeunit System.RestClient."Http Response Message"
    begin
        SetDefaultRequestHeader('Markdown', 'yes');
        exit(RestClient.Post(RequestUri, Content));
    end;
}