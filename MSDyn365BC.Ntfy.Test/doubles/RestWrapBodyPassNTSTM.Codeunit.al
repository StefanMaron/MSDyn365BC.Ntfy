codeunit 50003 RestWrapBodyPassNTSTM implements IRestWrapperNTSTM
{
    var
        TempContentText: Text;

    procedure CreateBody(Content: Text) HttpContent: Codeunit System.RestClient."Http Content"
    begin
        TempContentText := Content;
        HttpContent.Create(Content);
    end;

    procedure Post(RequestUri: Text; Content: Codeunit System.RestClient."Http Content") HttpResponseMessage: Codeunit System.RestClient."Http Response Message"
    var
        Assert: Codeunit "Library Assert";
    begin
        Assert.AreEqual(TempContentText, Content.AsText(), 'Content is not the same');
    end;
}