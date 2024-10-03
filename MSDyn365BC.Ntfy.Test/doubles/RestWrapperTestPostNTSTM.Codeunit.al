codeunit 50002 RestWrapperTestPostNTSTM implements IRestWrapperNTSTM
{
    procedure CreateBody(Content: Text) HttpContent: Codeunit System.RestClient."Http Content"
    begin
    end;

    procedure Post(RequestUri: Text; Content: Codeunit System.RestClient."Http Content") HttpResponseMessage: Codeunit System.RestClient."Http Response Message"
    begin
        Error('Post was called with RequestUri: %1', RequestUri);
    end;

    procedure SetDefaultRequestHeader(Name: Text; Value: Text)
    begin

    end;
}