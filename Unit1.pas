unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, TeeProcs, TeEngine, Chart, Series, Menus, ComObj;

type
  //������ ��� �������� �������� ������� � ������
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
    //������� �����
    function method_ejlera(a, b, y0, h: real; n: integer): Dat_Ar;
    //���������������� �����
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
   path:string; //���� � ���������
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
//����������� ������� ���������� �� *.dll
     procedure ShowForm;stdcall;
     external 'Project2.dll' name 'ShowDllForm'; //����������� ����� ����������
                                                 // � ����� �������
{$R *.dfm}
//����������� ������� ���������������� ���������
function TForm1.f(x, y: real): real;
begin
     //�������� �������� ��������� �������
     //f := x + cos(y/sqrt(5));
     //f:= x + exp(x) - 1;
     f:=exp(x)+sin(x)-sqrt(x);
end;
//������� �������� ������ �� ��������� � Excel
function SaveAsExcelFile(myMemo: TMemo; FileName: string): Boolean;
const
  xlWBATWorksheet = -4167;
var
  Row, n1, n2: Integer;
  curSt,stt: string;
  exRange,XLApp, Sheet: OLEVariant;
  today : TDateTime;
begin
  today := Now;//��������� ����
  Result := False;
  //������� ������ ����������
  XLApp  := CreateOleObject('Excel.Application');
  try
  //��������� ������� � �����
    XLApp.Visible := False;
    XLApp.Workbooks.Add(xlWBatWorkSheet);
    Sheet      := XLApp.Workbooks[1].WorkSheets[1];
    Sheet.Name := 'Create '+DateToStr(today);
    //������������ ���������� ��������
    Sheet.Columns[2].ColumnWidth:=25;
    Sheet.Columns[3].ColumnWidth:=25;
    Sheet.Cells[1,1] := '#';
    Sheet.Cells[1,2] := 'X';
    Sheet.Cells[1,3] := 'Y';
    //��������� ����� �� ���������
    exRange:= Sheet.Range[Sheet.Cells[1, 2],Sheet.Cells[myMemo.Lines.Count+1, 3]];
   exRange.NumberFormat := '0,000000';
   exRange.Value := exRange.Value;
   //���� �� ���������� ����� ��������� (Memo)
    for row := 0 to myMemo.Lines.Count - 1 do
        begin
         curSt:=myMemo.Lines[row];//�������� ���. ������
         n1:= pos('=',curSt);
         n2:= pos(';',curSt);
         stt:= copy (curSt,n1+1,n2-n1-1);//����������� �������� �
         Sheet.Cells[row + 2,1] := IntToStr(row);
         Sheet.Cells[row + 2,2] := StrToFloat(stt);
         delete(curSt,1,n2);
         n1:= pos('=',curSt);
         stt:= copy (curSt,n1+1,length(curSt));//����������� �������� �
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
//������� ����� ������
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
//���������������� ����� ������
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
         //��������� ������ �������� �������� �� �������� ������
         xr:= res_Ar[i-1, 1] + h/2;//����������� ��������� �����
         //������ �������� ������� � ���� �����
         yr:= res_Ar[i-1, 2] + (h/2) * f(res_Ar[i-1, 1], res_Ar[i-1, 2]);
         //������ � ��������� ����� �������� � ������
         res_Ar[i, 1] := res_Ar[i-1, 1] + h;
         //� ���� ������� ������ ������� ����� ����������� �������� � ���������� �����
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
//��������� ������ �� �����
     a := StrToFloat(Edit1.Text);
     b := StrToFloat(Edit2.Text);
     y0 := StrToFloat(Edit3.Text);
     h := StrToFloat(Edit4.Text);
     n:= round(abs(b-a)/h);
     //������� ��������� � ������ ��� �������
     Memo1.Clear;
     Chart1.Series[0].Clear;
     res_Ar := method_ejlera(a, b, y0, h,n);
     //��������� ������� �� ������������� ������� � �������� �
     //������������� ����� ����� ��� ���������� �������
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
     //��� ������ �������� ������ ���������� ����������������
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
 //���������� ��������� � �������� ����
  if (SaveDialog1.Execute) then
  Begin
   Memo1.Lines.SaveToFile(SaveDialog1.FileName);
  end;
end;

procedure TForm1.N3Click(Sender: TObject);
begin
  ShowForm;//����� ����� �� ���
end;

procedure TForm1.N1Click(Sender: TObject);
begin
//������ ������ � Excel
saveDialog2.InitialDir:= form1.path+'\data';  //����������� ���������� �� ���������
if (SaveDialog2.Execute) then
 begin
   if (SaveAsExcelFile(Memo1,savedialog2.FileName)= true)
   then
      ShowMessage ('������� ������������� � Excel:'+#13+
       savedialog2.FileName);
 end;      
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   path:= getcurrentdir;  //��������� ���� � ���������
end;

end.
