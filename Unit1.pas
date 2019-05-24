unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, TeeProcs, TeEngine, Chart, Series, Menus, ComObj;

type
  //Массив для хранения значения функции в точках
  Dat_Ar = array[0..1000, 1..2] of real;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Button1: TButton;
    Memo1: TMemo;
    Label5: TLabel;
    Label6: TLabel;
    Chart1: TChart;
    Series1: TLineSeries;
    Button2: TButton;
    MainMenu1: TMainMenu;
    A1: TMenuItem;
    txt1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    SaveDialog1: TSaveDialog;
    SaveDialog2: TSaveDialog;
    function f(x, y: real): real;
    //Обычный метод
    function method_ejlera(a, b, y0, h: real; n: integer): Dat_Ar;
    //Модифицированный метод
    function mmethod_ejlera(a, b, y0, h: real; n: integer): Dat_Ar;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure txt1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
   path:string; //путь к программе
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
//Определение функции вызываемой из *.dll
     procedure ShowForm;stdcall;
     external 'Project2.dll' name 'ShowDllForm'; //определение имени библиотеки
                                                 // и имени функции
{$R *.dfm}
//Определение функции дифиринциального уравнения
function TForm1.f(x, y: real): real;
begin
     //Тестовые варианты различных функций
     //f := x + cos(y/sqrt(5));
     //f:= x + exp(x) - 1;
     f:=exp(x)+sin(x)-sqrt(x);
end;
//Функция экспорта данных из программы в Excel
function SaveAsExcelFile(myMemo: TMemo; FileName: string): Boolean;
const
  xlWBATWorksheet = -4167;
var
  Row, n1, n2: Integer;
  curSt,stt: string;
  exRange,XLApp, Sheet: OLEVariant;
  today : TDateTime;
begin
  today := Now;//получение даты
  Result := False;
  //Создать сервер приложения
  XLApp  := CreateOleObject('Excel.Application');
  try
  //Настройки сервера и книги
    XLApp.Visible := False;
    XLApp.Workbooks.Add(xlWBatWorkSheet);
    Sheet      := XLApp.Workbooks[1].WorkSheets[1];
    Sheet.Name := 'Create '+DateToStr(today);
    //Формирование заголовков столюцев
    Sheet.Columns[2].ColumnWidth:=25;
    Sheet.Columns[3].ColumnWidth:=25;
    Sheet.Cells[1,1] := '#';
    Sheet.Cells[1,2] := 'X';
    Sheet.Cells[1,3] := 'Y';
    //Настройка форма та диапазона
    exRange:= Sheet.Range[Sheet.Cells[1, 2],Sheet.Cells[myMemo.Lines.Count+1, 3]];
   exRange.NumberFormat := '0,000000';
   exRange.Value := exRange.Value;
   //Цикл по количеству строк протокола (Memo)
    for row := 0 to myMemo.Lines.Count - 1 do
        begin
         curSt:=myMemo.Lines[row];//получить тек. строку
         n1:= pos('=',curSt);
         n2:= pos(';',curSt);
         stt:= copy (curSt,n1+1,n2-n1-1);//скопировать знаечние Х
         Sheet.Cells[row + 2,1] := IntToStr(row);
         Sheet.Cells[row + 2,2] := StrToFloat(stt);
         delete(curSt,1,n2);
         n1:= pos('=',curSt);
         stt:= copy (curSt,n1+1,length(curSt));//скопировать значение У
         Sheet.Cells[row + 2,3] := StrToFloat(stt);
        end;
    try
      XLApp.Workbooks[1].SaveAs(FileName);
      Result := True;
    except
      // Error ?
    end;
  finally
    if not VarIsEmpty(XLApp) then
    begin
      XLApp.DisplayAlerts := False;
      XLApp.Quit;
      XLAPP := Unassigned;
      Sheet := Unassigned;
    end;
  end;
end;
//Обычный метод Эйлера
function TForm1.method_ejlera(a, b, y0, h: real; n: integer):Dat_Ar;
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
         res_Ar[i, 2] := res_Ar[i-1, 2] + h * f(res_Ar[i-1, 1], res_Ar[i-1, 2]);
         xn := xn + h;
       end;
    res_Ar[0, 1] := i;
    method_ejlera := res_Ar;
end;
//Модифицированный метод Эйлера
function TForm1.mmethod_ejlera(a, b, y0, h: real; n: integer): Dat_Ar;
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
         yr:= res_Ar[i-1, 2] + (h/2) * f(res_Ar[i-1, 1], res_Ar[i-1, 2]);
         //Расчет и занесение новых значений в массив
         res_Ar[i, 1] := res_Ar[i-1, 1] + h;
         //В этом расчете такэже берутся ранее расчитанные значения в серединной точке
         res_Ar[i, 2] := res_Ar[i-1, 2] + h * f(xr, yr);
         xn := xn + h;
       end;
    res_Ar[0, 1] := i;
    mmethod_ejlera := res_Ar;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  a, b, y0, h: real;
  res_Ar: Dat_Ar;
  i,n: integer;
begin
//Получение данных из формы
     a := StrToFloat(Edit1.Text);
     b := StrToFloat(Edit2.Text);
     y0 := StrToFloat(Edit3.Text);
     h := StrToFloat(Edit4.Text);
     n:= round(abs(b-a)/h);
     //очистка протокола и данных для графика
     Memo1.Clear;
     Chart1.Series[0].Clear;
     res_Ar := method_ejlera(a, b, y0, h,n);
     //Занесение данныхз из рассчитанного массива в протокол и
     //форммирование новой серии для построения графика
     for i := 1 to round(res_Ar[0, 1]) do
       begin
         Memo1.Lines.Add('X[' + IntToStr(i) + ']=' + FloatToStrF(res_Ar[i, 1], ffFixed, 4, 2) + ';   Y[' + IntToStr(i) + ']=' + FloatToStrF(res_Ar[i, 2], ffFixed, 8, 6));
         Chart1.Series[0].AddXY(res_Ar[i, 1], res_Ar[i, 2]);
       end;
end;
procedure TForm1.Button2Click(Sender: TObject);
var
  a, b, y0, h: real;
  res_Ar: Dat_Ar;
  i,n: integer;
begin
     a := StrToFloat(Edit1.Text);
     b := StrToFloat(Edit2.Text);
     y0 := StrToFloat(Edit3.Text);
     h := StrToFloat(Edit4.Text);
     n:= round(abs(b-a)/h);
     //Тут вместо обычного метода вызывается модифицированный
     res_Ar := mmethod_ejlera(a, b, y0, h,n);
     Memo1.Clear;
     Chart1.Series[0].Clear;
     for i := 1 to round(res_Ar[0, 1]) do
       begin
         Memo1.Lines.Add('X[' + IntToStr(i) + ']=' + FloatToStrF(res_Ar[i, 1], ffFixed, 4, 2) + ';   Y[' + IntToStr(i) + ']=' + FloatToStrF(res_Ar[i, 2], ffFixed, 8, 6));
         Chart1.Series[0].AddXY(res_Ar[i, 1], res_Ar[i, 2]);
       end;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
 Form1.Close;
end;

procedure TForm1.txt1Click(Sender: TObject);
begin
 //сохранение протокола в тектовый файл
  if (SaveDialog1.Execute) then
  Begin
   Memo1.Lines.SaveToFile(SaveDialog1.FileName);
  end;
end;

procedure TForm1.N3Click(Sender: TObject);
begin
  ShowForm;//вызов формы из ДЛЛ
end;

procedure TForm1.N1Click(Sender: TObject);
begin
//Экспрт данных в Excel
saveDialog2.InitialDir:= form1.path+'\data';  //форирование директории по умолчанию
if (SaveDialog2.Execute) then
 begin
   if (SaveAsExcelFile(Memo1,savedialog2.FileName)= true)
   then
      ShowMessage ('Таблица импортирована в Excel:'+#13+
       savedialog2.FileName);
 end;      
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   path:= getcurrentdir;  //получение пути к программе
end;

end.
