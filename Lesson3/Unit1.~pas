unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TeEngine, Series, ExtCtrls, TeeProcs, Chart, BubbleCh,
  Grids, ComCtrls, ToolWin, Menus, Buttons, ImgList, XPMan, ShellApi,
  InterfaceUnit, Unit2;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Image1: TImage;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    procedure Button1Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
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



procedure TForm1.ToolButton1Click(Sender: TObject);
begin
ShellExecute(Handle, 'open', PChar('Help.chm'), nil, nil, SW_SHOW);
end;

end.
 