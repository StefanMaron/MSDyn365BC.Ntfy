interface IRestWrapperNTSTM
{
    procedure CreateBody(Content: Text): Codeunit "Http Content"
    procedure SetDefaultRequestHeader(Name: Text; Value: Text)
    procedure Post(RequestUri: Text; Content: Codeunit "Http Content") HttpResponseMessage: Codeunit "Http Response Message"
}