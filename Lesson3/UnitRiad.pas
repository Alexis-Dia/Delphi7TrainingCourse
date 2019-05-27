unit UnitRiad;
interface

uses Chart, Series, Math, Grids, SysUtils, Types, Graphics,  IniFiles, Messages,
 Dialogs, StdCtrls, Variants, Classes, Controls, Forms, ExtCtrls, Buttons, Menus,
 WordXP, Clipbrd, OleServer, ComObj, UnitMain;

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

procedure WriteToIniFile; //Запись в Ini-файл
procedure ReadFromIniFile; //Чтение из Ini-файла
function GetW : integer; //Получить w
procedure SetW; //Установить w
procedure SaveToWord; //Запись в Excel
procedure SaveToExcel; //Запись в Excel
procedure BuildTable(AStringGrid:TStringGrid; res_Ar:Dat_Ar); stdcall; //Постоение отчета
procedure BuildGraphic(AChart:TChart; res_Ar:Dat_Ar); stdcall; //Постоение графика
function SelectedOption(x, y: real): real;
function MethodEjlera(a, b, y0, h: real; n: integer): Dat_Ar; stdcall;//Обычный метод
function MmethodEjlera(a, b, y0, h: real; n: integer): Dat_Ar; stdcall;//Модифицированный метод

private

end;

var
Riad : TRiad; //Объект

implementation

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
  end;

procedure TRiad.SetW;
  begin
    if Form1.RadioGroup1.ItemIndex=-1 then
      MessageDlg(Pchar('Не выбрано значение w!!!'),mtError,[mbOk],0);
    if Form1.RadioGroup1.ItemIndex =0 then
      begin
      w:=1;
    end
    else if Form1.RadioGroup1.ItemIndex =1 then
      begin
      w:=2;
    end
    else if Form1.RadioGroup1.ItemIndex =2 then
    begin
      w:=3;
    end;
  end;

//Отчет в Word
procedure TRiad.SaveToWord;
  var
    i,j,k : integer;
    a,b,c : OleVariant;
    wa : TWordApplication; //WordApplication
    wd : TWordDocument; //WordDocument
  begin
    //Создать com-объект
    wa:= TWordApplication.Create(Form1);
   //Подключиться к серверу Word
   wa.Connect;
   //Добавить новый документ
   wa.Documents.Add(EmptyParam, EmptyParam, EmptyParam, EmptyParam);
   wd:= TWordDocument.Create(Form1);
   wd.ConnectTo(wa.ActiveDocument);
   //Отменить проверку правописания
   wa.Options.CheckSpellingAsYouType:=False;
   //Отменить проверку орфографии
   wa.Options.CheckGrammarAsYouType:=False;
   a:= 0;
   b:= 0;
   wd.Range.InsertAfter('Отчет');
   c:= Length(wd.Range.Text) - 1;
   a:= c;
   b:= c + 10;
   //Добавить таблицу
   wd.Tables.Add(wd.Range(a), Form1.StringGrid1.RowCount,
   Form1.StringGrid1.ColCount, EmptyParam, EmptyParam);
   k:= 1;
   //Перенести данные из StringGrid в таблицу
   for i:= 1 to Form1.StringGrid1.RowCount do
     for j:= 1 to Form1.StringGrid1.ColCount do
       wd.Tables.Item(k).Cell(i,j).Range.Text:= Form1.StringGrid1.Cells[j-1, i-1];
       c:= Length(wd.Range.Text) - 1;
    a:= c;
    //Вставить изображение из буфера обмена
    wa.Selection.Paste;
    //Показать Word
    wa.Visible:= true;
  end;

//Отчет в Excel
procedure TRiad.SaveToExcel;
const
  xlWBATWorksheet = -4167;
var
  Result: Boolean;
  Row, n1, n2: Integer;
  curSt,stt: string;
  exRange,XLApp, Sheet: OLEVariant;
  today : TDateTime;
begin
  today := Now;//Получение даты
  //Создание  документа
  XLApp  := CreateOleObject('Excel.Application');
  XLApp.Application.EnableEvents:= true;
  Result := False;
  try
    //Настройка документа и книги
    XLApp.Visible := False;
    XLApp.Workbooks.Add(xlWBatWorkSheet);
    Sheet      := XLApp.Workbooks[1].WorkSheets[1];
    Sheet.Name := 'Create '+DateToStr(today);
    //Формирование заголовков столбцов
    Sheet.Columns[2].ColumnWidth:=25;
    Sheet.Columns[3].ColumnWidth:=25;
    Sheet.Cells[1,1] := 'Index';
    Sheet.Cells[1,2] := 'X';
    Sheet.Cells[1,3] := 'Y';
    //Настройка формата диапазона
    exRange:= Sheet.Range[Sheet.Cells[1, 2],Sheet.Cells[100, 3]];
    exRange.NumberFormat := '0,000000';
    exRange.Value := exRange.Value;
    //Цикл по количеству строк
    for row := 1 to round(arr[0, 1]) do
    //for row := 0 to myMemo.Lines.Count - 1 do
        begin
         Sheet.Cells[row + 2,1] := FloatToStr(row);
         Sheet.Cells[row + 2,2] := StrToFloat(FloatToStrF(arr[row, 1], ffFixed, 6, 2));
         Sheet.Cells[row + 2,3] := StrToFloat(FloatToStr(arr[row, 2]));
        end;
    try
      //XLApp.Workbooks[1].SaveAs('C:\123.xls');
      Result := True;
    except
      // Error
    end;
    XLApp.Visible:=true;
    finally
    if not VarIsEmpty(XLApp) then
    begin
      XLApp.DisplayAlerts := True;
    end;
  end;
end;

procedure TRiad.BuildTable(AStringGrid:TStringGrid; res_Ar:Dat_Ar);
var
   i: integer;
begin
    for i := 1 to round(res_Ar[0, 1]) do
      begin
        Form1.StringGrid1.Cells[0,i]:=IntToStr(i);
        Form1.StringGrid1.Cells[1,i]:=FloatToStr(res_Ar[i, 1]);
        Form1.StringGrid1.Cells[2,i]:=FloatToStr(res_Ar[i, 2]);
      end;
end;//TRiad.Graphic1

procedure TRiad.BuildGraphic(AChart : TChart; res_Ar:Dat_Ar);
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

//Тестовые варианты различных функций дифиринциального уравнения
//selectedOption := x + cos(y/sqrt(5));
//selectedOption:= x + exp(x) - 1;
//selectedOption:=exp(x)+sin(x)-sqrt(x);
function TRiad.SelectedOption(x, y: real): real;
begin
  if Form1.RadioGroup1.ItemIndex =0 then
    begin
      SelectedOption:=exp(x)+sin(x)-sqrt(x);
    end
  else if Form1.RadioGroup1.ItemIndex =1 then
    begin
      SelectedOption:= x + exp(x) - 1;
    end
  else if Form1.RadioGroup1.ItemIndex =2 then
    begin
      SelectedOption := x + cos(y/sqrt(5));
    end
end;

//Обычный метод Эйлера
function TRiad.MethodEjlera(a, b, y0, h: real; n: integer): Dat_Ar;
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
         res_Ar[i, 2] := res_Ar[i-1, 2] + h * SelectedOption(res_Ar[i-1, 1], res_Ar[i-1, 2]);
         xn := xn + h;
       end;
    res_Ar[0, 1] := i;
    arr := res_Ar;
    MethodEjlera := res_Ar;
end;

//Модифицированный метод Эйлера
function TRiad.MmethodEjlera(a, b, y0, h: real; n: integer): Dat_Ar;
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
    arr := res_Ar;
    MmethodEjlera := res_Ar;
end;

end.

