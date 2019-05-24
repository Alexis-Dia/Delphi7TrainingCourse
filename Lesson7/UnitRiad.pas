unit UnitRiad;
interface

uses Chart, Series, Math, Grids, SysUtils, Types, Graphics,  IniFiles, Messages, Dialogs, StdCtrls, Variants, Classes, Controls, Forms,
  ExtCtrls, Buttons, Menus;

type
  Dat_Ar = array[0..1000, 1..2] of real;//Массив для хранения значения функции в точках

Type
TRiad = class //класс

private
IniFile : TIniFile; //Объект Ini-файла
w: integer;
arr: Dat_Ar;//Массив для хранения значения функции в точках

public
Constructor Create(AIniFileName : string);
Destructor Destroy;
procedure Graphic1(AChart:TChart); //Постоение графика
procedure Graphic2(AChart:TChart); //Постоение графика
procedure Graphic3(AChart:TChart); //Постоение графика
procedure Table(AStringGrid:TStringGrid); //Вывод в таблицу
procedure WriteToIniFile; //Запись в Ini-файл
procedure ReadFromIniFile; //Чтение из Ini-файла

function GetW : integer; //Получить w
procedure SetW; //Установить w
//property ww : integer read GetW write SetW;

procedure buildTable(AStringGrid:TStringGrid; res_Ar:Dat_Ar); stdcall; //Постоение отчета
procedure buildGraphic(AChart:TChart; res_Ar:Dat_Ar); stdcall; //Постоение графика
function selectedOption(x, y: real): real;
function method_ejlera(a, b, y0, h: real; n: integer): Dat_Ar; stdcall;//Обычный метод
function mmethod_ejlera(a, b, y0, h: real; n: integer): Dat_Ar; stdcall;//Модифицированный метод

private

end;

var
Riad : TRiad; //Объект

implementation

uses UnitMain, UnitGraphic;
const P=500;
const x=1;
const TimeStart=0; //Время начала отсчета
const TimeEnd=100; //Время окончания отсчета
const TimeStep=0.5; //Шаг дискретизация времени

Constructor TRiad.Create(AIniFileName : string);
begin
//Создать объект Ini-файла
IniFile:= TIniFile.Create(AIniFileName);
end;//TRiad.Create

Destructor TRiad.Destroy;
begin
//Удалить из Heap объект Ini-файла
if Assigned(IniFile) then
begin
IniFile.Free;
IniFile:= NIL;
end;
end;//TRiad.Create

procedure TRiad.Graphic1(AChart : TChart);
//Построение графика
var
time : extended;
Y: extended;
begin
Time:= TimeStart;
AChart.Series[0].Clear; //Очистить Series[0]
AChart.BottomAxis.Increment:= Floor((TimeEnd - TimeStart) / 5);
//Занести значения в Series

while(time <= TimeEnd) do
begin

AChart.Series[0].AddXY(time, Y);
time:= time + TimeStep / 4;
end;

end;//TRiad.Graphic1

procedure TRiad.Graphic2(AChart : TChart);
//Построение графика
var
time : extended;
Y: extended;
begin
Time:= TimeStart;
AChart.Series[1].Clear; //Очистить Series[0]
AChart.BottomAxis.Increment:= Floor(( TimeEnd- TimeStart) / 5);
//Занести значения в Series

while(time <= TimeEnd) do
begin

AChart.Series[1].AddXY(time, Y);
time:= time + TimeStep / 4;
end;

end;//TRiad.Graphic2

procedure TRiad.Graphic3(AChart : TChart);
//Построение графика
var
time : extended;
Y: extended;
begin
Time:= TimeStart;
AChart.Series[2].Clear; //Очистить Series[0]
AChart.BottomAxis.Increment:= Floor((TimeEnd - TimeStart) / 5);
//Занести значения в Series

while(time <= TimeEnd) do
begin

AChart.Series[2].AddXY(time, Y);
time:= time + TimeStep / 4;
end;

end;//TRiad.Graphic3



procedure TRiad.Table(AStringGrid : TStringGrid);
//Вывод информации в таблицу
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


time:= time + TimeStep;
end
 else if w=3 then
while (time <= TimeEnd) do
begin
inc(k);

//Form1.StringGrid1.Cells[3,k]:= FloatToStrF(y , ffFixed, 5, 3);
time:= time + TimeStep;
end
  else   if w=5 then
while (time <= TimeEnd) do
begin
inc(k);

//Form1.StringGrid1.Cells[4,k]:= FloatToStrF(y , ffFixed, 5, 3);
time:= time + TimeStep;
end  ;
end;//TRiad.Table


procedure TRiad.WriteToIniFile;
//запись в Ini-файл
begin
IniFile.WriteInteger('Parameters', 'W', W);
IniFile.UpdateFile;//очистка буфера и запись файла на диск
end;//TRiad.WriteToIniFile

procedure TRiad.ReadFromIniFile;
//чтение из Ini-файла
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
    MessageDlg(Pchar('Не выбрано значение w!!!'),mtError,[mbOk],0);
 if Form1.RadioGroup1.ItemIndex =0 then
  begin
  //Form1.Label10.Caption:='a';
  //Memo1.Lines.Add("111"));
  w:=1;
  end
 else if Form1.RadioGroup1.ItemIndex =1 then
  begin
  //Form1.label8.Caption:='a';
  w:=2;
   end
  else if Form1.RadioGroup1.ItemIndex =2 then
  begin
  //Form1.label10.Caption:='5';
  w:=3;
  end ;
 end;//TRiad.SetW

procedure TRiad.buildTable(AStringGrid:TStringGrid; res_Ar:Dat_Ar);
//Построение мемо
var
   i: integer;
begin
    for i := 1 to round(res_Ar[0, 1]) do
      begin
        Form1.StringGrid1.Cells[0,i]:=IntToStr(i);
        Form1.StringGrid1.Cells[1,i]:=FloatToStr(res_Ar[i, 1]);
        Form1.StringGrid1.Cells[2,i]:=FloatToStr(res_Ar[i, 2]);
        //AChart.Series[0].AddXY(res_Ar[i, 1], res_Ar[i, 2]);
      end;
//Form1.StringGrid1.Cells[1,1]:='Номер';
end;//TRiad.Graphic1

procedure TRiad.buildGraphic(AChart : TChart; res_Ar:Dat_Ar);
//Построение графика
var
  i,n: integer;
begin
    AChart.Series[0].Clear; //Очистить Series[0]
    //res_Ar := method_ejlera(a, b, y0, h,n);
    //Занесение данныхз из рассчитанного массива в протокол и
    //форммирование новой серии для построения графика
    for i := 1 to round(res_Ar[0, 1]) do
      begin
        AChart.Series[0].AddXY(res_Ar[i, 1], res_Ar[i, 2]);
      end;
end;//TRiad.Graphic1

//Определение функции дифиринциального уравнения
function TRiad.selectedOption(x, y: real): real;
begin
     //Тестовые варианты различных функций
     //f := x + cos(y/sqrt(5));
     //f:= x + exp(x) - 1;
     selectedOption:=exp(x)+sin(x)-sqrt(x);
end;

//Обычный метод Эйлера
function TRiad.method_ejlera(a, b, y0, h: real; n: integer): Dat_Ar;
 var
  xn: real;
  res_Ar: Dat_Ar;
  i: integer;
begin
     i := 1;
     res_Ar[1, 1] := a;
     res_Ar[1, 2] := y0;
     xn := a + h;
     while (xn <= b) do
       begin
         i := i + 1;
         res_Ar[i, 1] := res_Ar[i-1, 1] + h;
         res_Ar[i, 2] := res_Ar[i-1, 2] + h * selectedOption(res_Ar[i-1, 1], res_Ar[i-1, 2]);
         xn := xn + h;
       end;
    res_Ar[0, 1] := i;
    method_ejlera := res_Ar;
end;

//Модифицированный метод Эйлера
function TRiad.mmethod_ejlera(a, b, y0, h: real; n: integer): Dat_Ar;
var
  xn,xr,yr: real;
  res_Ar: Dat_Ar;
  i: integer;
begin
     i := 1;
     res_Ar[1, 1] := a;
     res_Ar[1, 2] := y0;
     xn := a + h;
     while (xn <= b) do
       begin
         i := i + 1;
         //Следующие строки являются отличием от обычного метода
         xr:= res_Ar[i-1, 1] + h/2;//определение серединнй точки
         //Расчет значения функции в этой точке
         yr:= res_Ar[i-1, 2] + (h/2) * selectedOption(res_Ar[i-1, 1], res_Ar[i-1, 2]);
         //Расчет и занесение новых значений в массив
         res_Ar[i, 1] := res_Ar[i-1, 1] + h;
         //В этом расчете такэже берутся ранее расчитанные значения в серединной точке
         res_Ar[i, 2] := res_Ar[i-1, 2] + h * selectedOption(xr, yr);
         xn := xn + h;
       end;
    res_Ar[0, 1] := i;
    mmethod_ejlera := res_Ar;
end;

end.

