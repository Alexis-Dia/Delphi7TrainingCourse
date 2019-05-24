unit UnitRiad;
interface

uses Chart, Series, Math, Grids, SysUtils, Types, Graphics,  IniFiles, Messages, Dialogs, StdCtrls, Variants, Classes, Controls, Forms,
  ExtCtrls, Buttons, Menus;

Type
TRiad = class //�����


private
IniFile : TIniFile; //������ Ini-�����
w: integer;

public
Constructor Create(AIniFileName : string);
Destructor Destroy;
procedure Graphic1(AChart:TChart); //��������� �������
procedure Graphic2(AChart:TChart); //��������� �������
procedure Graphic3(AChart:TChart); //��������� �������
procedure Table(AStringGrid:TStringGrid); //����� � �������
procedure WriteToIniFile; //������ � Ini-����
procedure ReadFromIniFile; //������ �� Ini-�����
function GetW : integer; //�������� w
procedure SetW; //���������� w
function F(w:integer;t:extended):extended;//���������� �����
//property ww : integer read GetW write SetW;

private

end;

var
Riad : TRiad; //������

implementation

uses UnitMain, UnitGraphic;
const P=500;
const x=1;
const TimeStart=0; //����� ������ �������
const TimeEnd=100; //����� ��������� �������
const TimeStep=0.5; //��� ������������� �������

Constructor TRiad.Create(AIniFileName : string);
begin
//������� ������ Ini-�����
IniFile:= TIniFile.Create(AIniFileName);
end;//TRiad.Create

Destructor TRiad.Destroy;
begin
//������� �� Heap ������ Ini-�����
if Assigned(IniFile) then
begin
IniFile.Free;
IniFile:= NIL;
end;
end;//TRiad.Create

procedure TRiad.Graphic1(AChart : TChart);
//���������� �������
var
time : extended;
Y: extended;
begin
Time:= TimeStart;
AChart.Series[0].Clear; //�������� Series[0]
AChart.BottomAxis.Increment:= Floor((TimeEnd - TimeStart) / 5);
//������� �������� � Series

while(time <= TimeEnd) do
begin
Y:= F(1,time);
AChart.Series[0].AddXY(time, Y);
time:= time + TimeStep / 4;
end;

end;//TRiad.Graphic1

procedure TRiad.Graphic2(AChart : TChart);
//���������� �������
var
time : extended;
Y: extended;
begin
Time:= TimeStart;
AChart.Series[1].Clear; //�������� Series[0]
AChart.BottomAxis.Increment:= Floor(( TimeEnd- TimeStart) / 5);
//������� �������� � Series

while(time <= TimeEnd) do
begin
Y:= F(3,time);
AChart.Series[1].AddXY(time, Y);
time:= time + TimeStep / 4;
end;

end;//TRiad.Graphic2

procedure TRiad.Graphic3(AChart : TChart);
//���������� �������
var
time : extended;
Y: extended;
begin
Time:= TimeStart;
AChart.Series[2].Clear; //�������� Series[0]
AChart.BottomAxis.Increment:= Floor((TimeEnd - TimeStart) / 5);
//������� �������� � Series

while(time <= TimeEnd) do
begin
Y:= F(5,time);
AChart.Series[2].AddXY(time, Y);
time:= time + TimeStep / 4;
end;

end;//TRiad.Graphic3

function TRiad.F(w : integer;t : extended) : extended;
//���������� �������
var
j:integer;
begin
 F:=(2*P/x)*(sin(w*t)-1/2*sin(2*w*t)+1/3*sin(3*w*t)-1/4*sin(4*w*t))
end;//TRiad.F

procedure TRiad.Table(AStringGrid : TStringGrid);
//����� ���������� � �������
var
k : integer;
time : extended;
y: extended;
begin
k:= 0;
time:= TimeStart;
  if w=1 then
while (time <= TimeEnd) do
begin
inc(k);
y:= F(w, time);
Form1.StringGrid1.Cells[2,k]:= FloatToStrF(y , ffFixed, 5, 3);
time:= time + TimeStep;
end
 else if w=3 then
while (time <= TimeEnd) do
begin
inc(k);
y:= F(w, time);
Form1.StringGrid1.Cells[3,k]:= FloatToStrF(y , ffFixed, 5, 3);
time:= time + TimeStep;
end
  else   if w=5 then
while (time <= TimeEnd) do
begin
inc(k);
y:= F(w, time);
Form1.StringGrid1.Cells[4,k]:= FloatToStrF(y , ffFixed, 5, 3);
time:= time + TimeStep;
end  ;
end;//TRiad.Table


procedure TRiad.WriteToIniFile;
//������ � Ini-����
begin
IniFile.WriteInteger('Parameters', 'W', W);
IniFile.UpdateFile;//������� ������ � ������ ����� �� ����
end;//TRiad.WriteToIniFile

procedure TRiad.ReadFromIniFile;
//������ �� Ini-�����
begin
W:= IniFile.ReadInteger('Parameters', 'W', w);
end;//TRiad.ReadFromIniFile

function TRiad.GetW :integer;
begin
 result:= W;
end;//TRiad.GetW


procedure TRiad.SetW;
begin
if Form1.RadioGroup1.ItemIndex=-1 then
    MessageDlg(Pchar('�� ������� �������� w!!!'),mtError,[mbOk],0);
 if Form1.RadioGroup1.ItemIndex =0 then
  begin
  Form1.Label10.Caption:='1';
  w:=1;
  end
 else if Form1.RadioGroup1.ItemIndex =1 then
  begin
  Form1.label10.Caption:='3';
  w:=3;
   end
  else
  begin
  Form1.label10.Caption:='5';
  w:=5;
  end ;
 end;//TRiad.SetW

end.

