codeunit 50001 RestWrapperTestBodyNTSTM implements IRestWrapperNTSTM
{
    procedure CreateBody(Content: Text) HttpContent: Codeunit System.RestClient."Http Content"
    begin
        Error('CreateBody was called');
    end;

    procedure Post(RequestUri: Text; Content: Codeunit System.RestClient."Http Content") HttpResponseMessage: Codeunit System.RestClient."Http Response Message"
    begin
    end;
}