unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComServer;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  II, COM_Object: ISmpCom;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
	S:extended;
begin
   II := SmpComImpl.Create;
   II.QueryInterface(ISmpCom,COM_Object);
   S:=COM_Object.Tangent(420);
   Edit1.Text:=FloatToStr(S);
end;

end.
 