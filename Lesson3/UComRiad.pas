unit UComRiad;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
Windows, ActiveX, Classes, ComObj, Chart, Grids, Math, SysUtils, IniFiles,
UCom_Tlb, ExtCtrls, Messages, ComServ, Dialogs, Graphics, UnitMain;

type
TRiad = class(TComObject, IComRiad)
protected
IniFile : TIniFile; //������ Ini-�����
w : integer;
arr: Dat_Ar;//������ ��� �������� �������� ������� � ������

public
Procedure Create(AIniFileName : string); stdcall;
Destructor Destroy;
procedure WriteToIniFile; stdcall; //������ � Ini-����
procedure ReadFromIniFile; stdcall; //������ �� Ini-�����
function GetW : integer; stdcall; //�������� w
procedure SetW; stdcall; //���������� w
procedure SaveToWord; //������ � Excel
procedure SaveToExcel; //������ � Excel
procedure ShowPresentation; //������ �����������
procedure BuildTable(AStringGrid:TStringGrid; res_Ar:Dat_Ar); stdcall; //��������� ������
procedure BuildGraphic(AChart:TChart; res_Ar:Dat_Ar); stdcall; //��������� �������
function SelectedOption(x, y: real): real;
function MethodEjlera(a, b, y0, h: real; n: integer): Dat_Ar; stdcall;//������� �����
function MmethodEjlera(a, b, y0, h: real; n: integer): Dat_Ar; stdcall;//���������������� �����
private

end;

implementation

Procedure TRiad.Create(AIniFileName : string);
  begin
    //������� ������ Ini-�����
    IniFile:= TIniFile.Create(AIniFileName);
  end;//TRod.Create

Destructor TRiad.Destroy;
  begin //�� ������������
  //������� �� Heap ������ Ini-�����
  if Assigned(IniFile) then
    begin
    IniFile.Free;
    IniFile:= NIL;
    end;
  end;//TRod.Create

procedure TRiad.WriteToIniFile;
  //������ � Ini-����
  begin
    IniFile.WriteInteger('Parameters', 'W', W);
    IniFile.UpdateFile;//������� ������ � ������ ����� �� ����
  end;//TRiad.WriteToIniFile

//������ �� Ini-�����
procedure TRiad.ReadFromIniFile;
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
      //Form1.Label10.Caption:='1';
      w:=1;
    end
    else if Form1.RadioGroup1.ItemIndex =1 then
      begin
        //Form1.label10.Caption:='3';
        w:=3;
      end
    else
      begin
        //Form1.label10.Caption:='5';
        w:=5;
    end;
  end;//TRiad.SetW

procedure TRiad.SaveToWord;
  begin
  end;

procedure TRiad.SaveToExcel;
  begin
  end;

//������ �����������
procedure TRiad.ShowPresentation;
  begin
  end;

procedure TRiad.BuildTable(AStringGrid:TStringGrid; res_Ar:Dat_Ar);
//���������� ����
var
  j: integer;
begin

end;//TRiad.Graphic1

procedure TRiad.BuildGraphic(AChart :TChart; res_Ar:Dat_Ar);
//���������� �������
var
  i,n: integer;
begin
    AChart.Series[0].Clear; //�������� Series[0]
    //res_Ar := method_ejlera(a, b, y0, h,n);
    //��������� ������� �� ������������� ������� � �������� �
    //������������� ����� ����� ��� ���������� �������
    for i := 1 to round(res_Ar[0, 1]) do
      begin
        AChart.Series[0].AddXY(res_Ar[i, 1], res_Ar[i, 2]);
      end;
end;//TRiad.Graphic1

 //����������� ������� ���������������� ���������
function TRiad.SelectedOption(x, y: real): real;
begin
     //�������� �������� ��������� �������
     //f := x + cos(y/sqrt(5));
     //f:= x + exp(x) - 1;
     selectedOption:=exp(x)+sin(x)-sqrt(x);
end;

//������� ����� ������
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
    MethodEjlera := res_Ar;
end;

//���������������� ����� ������
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
         //��������� ������ �������� �������� �� �������� ������
         xr:= res_Ar[i-1, 1] + h/2;//����������� ��������� �����
         //������ �������� ������� � ���� �����
         yr:= res_Ar[i-1, 2] + (h/2) * selectedOption(res_Ar[i-1, 1], res_Ar[i-1, 2]);
         //������ � ��������� ����� �������� � ������
         res_Ar[i, 1] := res_Ar[i-1, 1] + h;
         //� ���� ������� ������ ������� ����� ����������� �������� � ���������� �����
         res_Ar[i, 2] := res_Ar[i-1, 2] + h * selectedOption(xr, yr);
         xn := xn + h;
       end;
    res_Ar[0, 1] := i;
    MmethodEjlera := res_Ar;
end;

initialization
TComObjectFactory.Create(ComServer, TRiad, Class_ServerRiad,
'ServerRiad', '', ciMultiInstance, tmApartment);
end.


