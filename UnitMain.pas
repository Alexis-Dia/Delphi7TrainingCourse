unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
Dialogs, StdCtrls, Menus, ToolWin,  ComCtrls, XPMan, ImgList, Grids,
IniFiles, Clipbrd, WordXP, Math, ShellAPI, ExtCtrls, msppt8,
UCom_Tlb, ComObj,  MSPpt2000, PowerPointXP, Activex, OleServer,
  Buttons;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
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
    StringGrid1: TStringGrid;
    Label9: TLabel;
    Label10: TLabel;
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
IniFileName : string; //��� ����� �������������
procedure ReportExcel(AStringGrid : TStringGrid); //�������� ����� � Excel
procedure ReportWord (AStringGrid : TStringGrid); //�������� ����� � Word  
    { Public declarations }
  end;

var
  Form1: TForm1;
  Flag : bool; //���� ����������� ���� ������������� �������
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
  //�� ��������� ���������� ������ � ������� (������������) ��������
 Flag:= false;
 //��� Ini-����� ���������� ����������
 IniFileName:= GetCurrentDir+'\Riad.ini';
 //������� ������� ������
 Riad:= TRiad.Create(IniFileName);
 //������� ������ �� Ini-�����
 Riad.ReadFromIniFile;
 //���������� � ����� ������ � �������
 Riad.Table(StringGrid1);

 StringGrid1.Cells[0,0]:='�����' ;
 StringGrid1.Cells[1,0]:='�����(�)';
 StringGrid1.Cells[2,0]:='F{t} ��� w=1';
 StringGrid1.Cells[3,0]:='F{t} ��� w=3';
 StringGrid1.Cells[4,0]:='F{t} ��� w=5';
 for i:=1 to 201 do
  StringGrid1.Cells[0,i]:=IntToStr(i) ;
 for i:=0 to 201 do
  begin
 StringGrid1.Cells[1,i+1]:=FloatToStr(0.5*i)
   end;

 label10.Caption:='';
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
 var i:integer;
 begin
 Riad.SetW();
  //���������� � ����� ������ � �������
 Riad.Table(StringGrid1);

 end;



procedure TForm1.BitBtn4Click(Sender: TObject);
var i:integer;
begin
 for i:=0 to 201 do
  begin
 StringGrid1.Cells[2,i+1]:='';
 StringGrid1.Cells[3,i+1]:='';
 StringGrid1.Cells[4,i+1]:='';
   end;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
 FormGraphic.Show;
end;

procedure TForm1.N4Click(Sender: TObject);
Type
//����������� ��� ��� ������ ��������� �� DLL
TProc = procedure(AOwner:TComponent);
var
Handle : LongInt; //���������� ����������
ShowAbout : TProc; //��������� ��� ������ ������� �� DLLbegin

begin
//�������� �������� ����������� ����������� ����������
Handle:=LoadLibrary('About.dll');
//��������� ������������� ����������
if Handle = 0 then
begin
ShowMessage('���������� �� ������� : About.dll');
exit;
end;
//�������� ����� ���������� �������
@ShowAbout:= GetProcAddress(Handle, PChar('ShowAbout'));
//����� �������, ������������ ����� About
ShowAbout(Application);
FreeLibrary(Handle); //�������� ����������

end;


procedure TForm1.PresentationClick(Sender: TObject);
var
name : string;
pw : TOleEnum;
begin
  //������ ����������
Name:= ExtractFileDir(Application.ExeName) + '\VremProc.pptx';
PowerPointApplication1.Activate;
PowerPointApplication1.Presentations.Open(Name, pw, pw, pw);
PowerPointApplication1.Presentations.Item(1).SlideShowSettings.Run;
//������ ������ �������
// ShellExecute(Application.MainForm.Handle,PChar('Open'),
// PChar('Riad.pps'), NIL, PChar(''), sw_ShowNormal);
end;//TFormMain.PresentationClick

procedure TForm1.Word1Click(Sender: TObject);
begin //����� � Word
ReportWord(StringGrid1);
end;//TFormMain.Word1Click

Procedure TForm1.ReportExcel(AStringGrid : TStringGrid);
//����� � Excel
var
Excel : variant;
WorkBook : variant; //������� �����
i, j : integer;
begin
//C������ ����� ��� �������
FormGraphic:= TFormGraphic.Create(Form1);
//������� ��m-������
Excel:= CreateOleObject('Excel.Application');
//��������� ������� �� ������� �������-��� ��������� �������� �������� ������
Excel.Application.EnableEvents:= false;
//�������� ������� �����
WorkBook:= Excel.WorkBooks.Add;
//��������� ������ ��������
for j:=0 to AStringGrid.ColCount do
WorkBook.WorkSheets[1].Columns[j+1].ColumnWidth:= 10;
//����� ������
WorkBook.WorkSheets[1].Cells[1,1]:= '����� � ���������� �������';
//���������� ����� ������� Excel ���������� �� StringGrid
//��������� ����� � Excel ���������� � 1 � ���� � ������� ������-�������
for i:= 1 to AStringGrid.RowCount + 1 do
for j:= 0 to AStringGrid.ColCount do
WorkBook.WorkSheets[1].Cells[i+1, j+1]:= AStringGrid.Cells[j, i-1];

//������� ����������� ������� � Excel
WorkBook.WorkSheets[1].Shapes.AddPicture(GetCurrentDir+'\PictureWord.bmp',
True, True, 0, (AStringGrid.RowCount+2)*12.5+10, FormGraphic.Chart1.Width*0.8,
FormGraphic.Chart1.Height*0.8);
//���������� �����
FormGraphic.Release;
FormGraphic:= NIL;
//�������� Excel
Excel.Visible:=true;
end;//TFormMain.ReportExcel
Procedure TForm1.ReportWord(AStringGrid : TStringGrid);
//����� � Word
var
i,j,k : integer;
a,b,c : OleVariant;
wa : TWordApplication; //WordApplication
wd : TWordDocument; //WordDocument
begin
//������� ����� ��� �������
FormGraphic:= TFormGraphic.Create(Form1);
//������� com-������
wa:= TWordApplication.Create(Form1);
//������������ � ������� Word
wa.Connect;
//�������� ����� ��������
wa.Documents.Add(EmptyParam, EmptyParam, EmptyParam, EmptyParam);
wd:= TWordDocument.Create(Form1);
wd.ConnectTo(wa.ActiveDocument);
//�������� �������� ������������
wa.Options.CheckSpellingAsYouType:=False;
//�������� �������� ����������
wa.Options.CheckGrammarAsYouType:=False;
a:= 0;
b:= 0;
wd.Range.InsertAfter('�����');
c:= Length(wd.Range.Text) - 1;
a:= c;
b:= c + 10;
//�������� �������
wd.Tables.Add(wd.Range(a), AStringGrid.RowCount,
AStringGrid.ColCount, EmptyParam, EmptyParam);
k:= 1;
//��������� ������ �� StringGrid � �������
for i:= 1 to AStringGrid.RowCount do
for j:= 1 to AStringGrid.ColCount do
wd.Tables.Item(k).Cell(i,j).Range.Text:= AStringGrid.Cells[j-1, i-1];
//��������� ����������� � Image
FormGraphic.Image1.Picture.LoadFromFile('PictureWord.bmp');
//��������� ����������� � ����� ������
Clipboard.Assign(FormGraphic.Image1.Picture);
c:= Length(wd.Range.Text) - 1;
a:= c;
//�������� ����������� �� ������ ������
wa.Selection.Paste;
//�������� Word
wa.Visible:= true;
//���������� �����
FormGraphic.Release;
FormGraphic:= NIL;
end;//TFormMain.ReportWord

procedure TForm1.Excel1Click(Sender: TObject);
begin
   ReportExcel(StringGrid1);
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
