unit UnitPrompt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, XPMan, StdCtrls, Buttons, jpeg, Gauges;

type
  TFormPrompt = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    Gauge1: TGauge;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrompt: TFormPrompt;

implementation

{$R *.dfm}

end.
