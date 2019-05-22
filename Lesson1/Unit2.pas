unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, TeEngine, Series, TeeProcs, Chart, ImgList;
type
  TIntegral= class
  private
    a: extended;
    b: extended;
  public
    procedure SetField(Aa,Ab:extended);
    function  CalculateLeftRectangle():extended;
  end;

implementation

procedure TIntegral.SetField(Aa,Ab:extended);
begin
  a:=Aa;
  b:=Ab;
end;

function TIntegral.CalculateLeftRectangle():extended;
var
  x,S:extended;
begin
  x:=a;
  S:=0;
  while x<=b do
  begin
    S:=S+1;
    b:=b-1;
  end;
  result:=S;
end;

end.
