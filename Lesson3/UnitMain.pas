unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
Dialogs, StdCtrls, Menus, ToolWin,  ComCtrls, XPMan, ImgList, Grids, IniFiles,
Clipbrd, WordXP, Math, ShellAPI, ExtCtrls, msppt8, UCom_Tlb, ComObj,  MSPpt2000,
PowerPointXP, Activex, OleServer, TeeProcs, TeEngine, Chart, Series,
Buttons, DBGrids, ActnMan, ActnCtrls;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Chart1: TChart;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Excel1: TSpeedButton;
    EXcel2: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Presentation: TSpeedButton;
    PowerPointApplication1: TPowerPointApplication;
    RadioGroup1: TRadioGroup;
    Series1: TLineSeries;
    StringGrid1: TStringGrid;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label8: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N9: TMenuItem;
    Word1: TSpeedButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Excel1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure PresentationClick(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Word1Click(Sender: TObject);

  private
  w: integer;
    { Private declarations }
  public
    IniFileName : string; //��� ����� �������������
    { Public declarations }
end;

var
  Form1: TForm1;
  Flag : bool; //���� ����������� ���� ������������� �������
  const x=1;
  const P=500;
  
implementation

uses UnitRiad;

{$R *.dfm}

procedure TForm1.BitBtn3Click(Sender: TObject);
  begin
    Close;
  end;

procedure TForm1.FormActivate(Sender: TObject);
 var i, n:integer;
  a, b, y0, h: real;
  begin
    //�� ��������� ���������� ������ � ������� (������������) ��������
    Flag:= false;
    //��� Ini-����� ���������� ����������
    IniFileName:= GetCurrentDir+'\Riad.ini';
    //������� ������� ������
    Riad:= TRiad.Create(IniFileName);
    //������� ������ �� Ini-�����
    Riad.ReadFromIniFile;
    //�������������
    StringGrid1.Cells[0,0]:='������' ;
    StringGrid1.Cells[1,0]:='X';
    StringGrid1.Cells[2,0]:='Y';
  end;

procedure TForm1.BitBtn1Click(Sender: TObject);
  var
    a, b, y0, h: real;
    res_Ar: Dat_Ar;
    i,n: integer;
    r, w1: integer;
  begin
    w1 := Riad.GetW();
    if (w1=1) or (w1=2) or (w1=3) then
      begin
        //��������� ������ �� �����
        a := StrToFloat(Edit1.Text);
        b := StrToFloat(Edit2.Text);
        y0 := StrToFloat(Edit3.Text);
        h := StrToFloat(Edit4.Text);
        n:= round(abs(b-a)/h);
        //������� ��������� � ������ ��� �������
        Chart1.Series[0].Clear;
        res_Ar := Riad.MmethodEjlera(a, b, y0, h,n);
        //��������� ������� �� ������������� ������� � �������� �
        //������������� ����� ����� ��� ���������� �������
        Riad.BuildGraphic(Chart1, res_Ar);
        Riad.BuildTable(StringGrid1, res_Ar);
      end
    else
      begin
        MessageDlg(Pchar('�� ������� �������!!!'),mtError,[mbOk],0);
      end
  end;

procedure TForm1.BitBtn2Click(Sender: TObject);
  var
    a, b, y0, h: real;
    res_Ar: Dat_Ar;
    i,n: integer;
    r, w1: integer;
  begin
    w1 := Riad.GetW();
    if (w1=1) or (w1=2) or (w1=3) then
      begin
        //��������� ������ �� �����
        a := StrToFloat(Edit1.Text);
        b := StrToFloat(Edit2.Text);
        y0 := StrToFloat(Edit3.Text);
        h := StrToFloat(Edit4.Text);
        n:= round(abs(b-a)/h);
        //������� ��������� � ������ ��� �������
        Chart1.Series[0].Clear;
        res_Ar := Riad.MethodEjlera(a, b, y0, h,n);
        //��������� ������� �� ������������� ������� � �������� �
        //������������� ����� ����� ��� ���������� �������
        Riad.BuildGraphic(Chart1, res_Ar);
        Riad.BuildTable(StringGrid1, res_Ar);
      end
    else
      begin
        MessageDlg(Pchar('�� ������� �������!!!'),mtError,[mbOk],0);
      end
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

//����� � Word
procedure TForm1.Word1Click(Sender: TObject);
  begin
    Riad.SaveToWord();
  end;

//����� � Excel
procedure TForm1.Excel1Click(Sender: TObject);
  begin
    Riad.SaveToExcel();
  end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
  begin
    WinExec('hh.exe help.chm',SW_SHOW);
  end;

procedure TForm1.N6Click(Sender: TObject);
  begin
    WinExec('hh.exe help.chm',SW_SHOW);
  end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
  begin
    Riad.SetW();
  end;

end.
