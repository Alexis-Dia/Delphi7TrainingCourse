unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
Dialogs, StdCtrls, Menus, ToolWin,  ComCtrls, XPMan, ImgList, Grids,
IniFiles, Clipbrd, WordXP, Math, ShellAPI, ExtCtrls, msppt8,
UCom_Tlb, ComObj,  MSPpt2000, PowerPointXP, Activex, OleServer,
TeeProcs, TeEngine, Chart, Series,
  Buttons;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label8: TLabel;
    RadioGroup1: TRadioGroup;
    BitBtn1: TBitBtn;
    Panel3: TPanel;
    BitBtn2: TBitBtn;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N6: TMenuItem;
    BitBtn3: TBitBtn;
    N7: TMenuItem;
    BitBtn4: TBitBtn;
    PowerPointApplication1: TPowerPointApplication;
    Presentation: TSpeedButton;
    N8: TMenuItem;
    Word1: TSpeedButton;
    Excel1: TSpeedButton;
    N9: TMenuItem;
    EXcel2: TMenuItem;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Chart1: TChart;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Memo1: TMemo;
    Series1: TFastLineSeries;
    procedure BitBtn3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure PresentationClick(Sender: TObject);
    procedure Word1Click(Sender: TObject);
    procedure Excel1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
   // Procedure TFormMain.PresentationClick(Sender: TObject);
   
  private
    { Private declarations }
  public
IniFileName : string; //Имя файла инициализации
procedure ReportExcel(AStringGrid : TStringGrid); //Передать отчет в Excel
procedure ReportWord (AStringGrid : TStringGrid); //Передать отчет в Word
    { Public declarations }
  end;

var
  Form1: TForm1;
  Flag : bool; //Флаг определения вида используемого объекта
  const x=1;
  const P=500;
 
  
implementation

uses UnitRiad, UnitGraphic;

{$R *.dfm}

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
 Close;
end;

procedure TForm1.FormActivate(Sender: TObject);
 var i:integer;
begin
  //По умолчанию установить работу с обычным (классическим) объектом
 Flag:= false;
 //Имя Ini-файла сохранения параметров
 IniFileName:= GetCurrentDir+'\Riad.ini';
 //Создать обычный объект
 Riad:= TRiad.Create(IniFileName);
 //Считать данные из Ini-файла
 Riad.ReadFromIniFile;




end;

procedure TForm1.BitBtn1Click(Sender: TObject);
 var i:integer;
 begin


 end;



procedure TForm1.BitBtn4Click(Sender: TObject);
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
     //res_Ar := Riad.method_ejlera(0, 3, 0, 0, 1);
     res_Ar := Riad.method_ejlera(a, b, y0, h,n);
     //res_Ar := method_ejlera(a, b, y0, h,n);
     //Занесение данныхз из рассчитанного массива в протокол и
     //форммирование новой серии для построения графика
     for i := 1 to round(res_Ar[0, 1]) do
       begin
         Memo1.Lines.Add('X[' + IntToStr(i) + ']=' + FloatToStrF(res_Ar[i, 1], ffFixed, 4, 2) + ';   Y[' + IntToStr(i) + ']=' + FloatToStrF(res_Ar[i, 2], ffFixed, 8, 6));
         Chart1.Series[0].AddXY(res_Ar[i, 1], res_Ar[i, 2]);
       end;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
 FormGraphic.Show;
end;

procedure TForm1.N4Click(Sender: TObject);
Type
//Процедурный тип для вызова процедуры из DLL
TProc = procedure(AOwner:TComponent);
var
Handle : LongInt; //Дескриптор библиотеки
ShowAbout : TProc; //Переменая для вызова функции из DLLbegin

begin
//Получить значение дескриптора загруженной библиотеки
Handle:=LoadLibrary('About.dll');
//Проверить существование библиотеки
if Handle = 0 then
begin
ShowMessage('Библиотека не найдена : About.dll');
exit;
end;
//Получить адрес вызываемой функции
@ShowAbout:= GetProcAddress(Handle, PChar('ShowAbout'));
//Вызов функции, показывающей форму About
ShowAbout(Application);
FreeLibrary(Handle); //Выгрузка библиотеки

end;


procedure TForm1.PresentationClick(Sender: TObject);
var
name : string;
pw : TOleEnum;
begin
  //Запуск презетации
Name:= ExtractFileDir(Application.ExeName) + '\VremProc.pptx';
PowerPointApplication1.Activate;
PowerPointApplication1.Presentations.Open(Name, pw, pw, pw);
PowerPointApplication1.Presentations.Item(1).SlideShowSettings.Run;
//Другой способ запуска
// ShellExecute(Application.MainForm.Handle,PChar('Open'),
// PChar('Riad.pps'), NIL, PChar(''), sw_ShowNormal);
end;//TFormMain.PresentationClick

procedure TForm1.Word1Click(Sender: TObject);
begin //Отчет в Word
//ReportWord(StringGrid1);
end;//TFormMain.Word1Click

Procedure TForm1.ReportExcel(AStringGrid : TStringGrid);
//Отчет в Excel
var
Excel : variant;
WorkBook : variant; //Рабочая книга
i, j : integer;
begin
//Cоздать форму для графика
FormGraphic:= TFormGraphic.Create(Form1);
//Создать Соm-объект
Excel:= CreateOleObject('Excel.Application');
//Отключить реакцию на внешние события-для ускорения процесса передачи данных
Excel.Application.EnableEvents:= false;
//Добавить рабочую книгу
WorkBook:= Excel.WorkBooks.Add;
//Изменение ширины столбцов
for j:=0 to AStringGrid.ColCount do
WorkBook.WorkSheets[1].Columns[j+1].ColumnWidth:= 10;
//Вывод строки
WorkBook.WorkSheets[1].Cells[1,1]:= 'Отчет о колебаниях стержня';
//Заполнение ячеек таблицы Excel значениями из StringGrid
//Нумерация ячеек в Excel начинается с 1 и идет в формате строка-столбец
for i:= 1 to AStringGrid.RowCount + 1 do
for j:= 0 to AStringGrid.ColCount do
WorkBook.WorkSheets[1].Cells[i+1, j+1]:= AStringGrid.Cells[j, i-1];

//Вставит изображение графика в Excel
WorkBook.WorkSheets[1].Shapes.AddPicture(GetCurrentDir+'\PictureWord.bmp',
True, True, 0, (AStringGrid.RowCount+2)*12.5+10, FormGraphic.Chart1.Width*0.8,
FormGraphic.Chart1.Height*0.8);
//Уничтожить форму
FormGraphic.Release;
FormGraphic:= NIL;
//Показать Excel
Excel.Visible:=true;
end;//TFormMain.ReportExcel
Procedure TForm1.ReportWord(AStringGrid : TStringGrid);
//Отчет в Word
var
i,j,k : integer;
a,b,c : OleVariant;
wa : TWordApplication; //WordApplication
wd : TWordDocument; //WordDocument
begin
//Создать форму для графика
FormGraphic:= TFormGraphic.Create(Form1);
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
wd.Tables.Add(wd.Range(a), AStringGrid.RowCount,
AStringGrid.ColCount, EmptyParam, EmptyParam);
k:= 1;
//Перенести данные из StringGrid в таблицу
for i:= 1 to AStringGrid.RowCount do
for j:= 1 to AStringGrid.ColCount do
wd.Tables.Item(k).Cell(i,j).Range.Text:= AStringGrid.Cells[j-1, i-1];
//Загрузить изображение в Image
FormGraphic.Image1.Picture.LoadFromFile('PictureWord.bmp');
//Поместить изображение в буфер обмена
Clipboard.Assign(FormGraphic.Image1.Picture);
c:= Length(wd.Range.Text) - 1;
a:= c;
//Вставить изображение из буфера обмена
wa.Selection.Paste;
//Показать Word
wa.Visible:= true;
//Уничтожить форму
FormGraphic.Release;
FormGraphic:= NIL;
end;//TFormMain.ReportWord

procedure TForm1.Excel1Click(Sender: TObject);
begin
   //ReportExcel(StringGrid1);
 end;

procedure TForm1.SpeedButton2Click(Sender: TObject);

begin
 WinExec('hh.exe 1.chm',SW_SHOW);
end;

procedure TForm1.N6Click(Sender: TObject);
begin
 WinExec('hh.exe 1.chm',SW_SHOW);
end;

end.
