unit UnitGraphic;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, StdCtrls, ExtCtrls, TeeProcs, Chart, XPMan,
  TeeFunci, Buttons;

type
  TFormGraphic = class(TForm)
    Chart1: TChart;
    Button1: TButton;
    XPManifest1: TXPManifest;
    Series1: TLineSeries;
    Series2: TLineSeries;
    TeeFunction1: TAddTeeFunction;
    Series3: TLineSeries;
    Image1: TImage;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormGraphic: TFormGraphic;

implementation

uses UnitRiad;

{$R *.dfm}

procedure TFormGraphic.Button1Click(Sender: TObject);
begin
Chart1.Series[0].Clear;
Chart1.Series[1].Clear;
Chart1.Series[2].Clear;
Close;
end;//TFormGraphic.Button1Click

procedure TFormGraphic.BitBtn1Click(Sender: TObject);
begin
   Riad.Graphic1(FormGraphic.Chart1);
   Chart1.SaveToBitmapFile('PictureWord.bmp');
end;

procedure TFormGraphic.BitBtn2Click(Sender: TObject);
begin
 Riad.Graphic2(FormGraphic.Chart1);
 Chart1.SaveToBitmapFile('PictureWord.bmp');
end;

procedure TFormGraphic.BitBtn3Click(Sender: TObject);
begin
  Riad.Graphic3(FormGraphic.Chart1);
  Chart1.SaveToBitmapFile('PictureWord.bmp');
end;

procedure TFormGraphic.BitBtn4Click(Sender: TObject);
begin
Chart1.Series[0].Clear;
Chart1.Series[1].Clear;
Chart1.Series[2].Clear;
end;

end.
end.