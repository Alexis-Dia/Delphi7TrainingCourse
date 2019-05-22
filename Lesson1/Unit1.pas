unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Unit2;

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
  Integral: TIntegral;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  S:extended;
begin
  Integral:=TIntegral.Create;
  Integral.SetField(2,9);
  S:=Integral.CalculateLeftRectangle();
  Edit1.Text:=FloatToStr(S);
end;

end.
