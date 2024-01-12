codeunit 71179880 RestWrapperNTSTM implements IRestWrapperNTSTM
{
    procedure CreateBody(Content: Text) HttpContent: Codeunit System.RestClient."Http Content"
    begin
        HttpContent.Create(Content);
    end;

    procedure Post(RequestUri: Text; Content: Codeunit System.RestClient."Http Content") HttpResponseMessage: Codeunit System.RestClient."Http Response Message"
    var
        RestClient: Codeunit "Rest Client";
    begin
        exit(RestClient.Post(RequestUri, Content));
    end;
}