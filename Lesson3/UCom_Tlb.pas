unit UCom_Tlb;
interface
uses Chart, Grids, StdCtrls,  ExtCtrls, Messages, Dialogs;
const
Class_ServerRiad: TGUID = '{1CB7B26E-5BAF-4BA7-8F17-EA174D7CD750}';
type
  Dat_Ar = array[0..1000, 1..2] of real;
Type
IComRiad = interface
['{1326DD83-DB3E-4054-9572-CFB9EAE3FE95}']
Procedure Create(AIniFileName : string); stdcall;
procedure WriteToIniFile; stdcall; //������ � Ini-����
procedure ReadFromIniFile; stdcall; //������ �� Ini-�����
function Getw : integer; stdcall; //�������� w
procedure Setw; stdcall; //���������� w
procedure SaveToWord; //������ � Word
procedure SaveToExcel; //������ � Excel
procedure BuildTable(AStringGrid:TStringGrid; res_Ar:Dat_Ar); stdcall; //��������� ������
procedure BuildGraphic(AChart:TChart; res_Ar:Dat_Ar); stdcall; //��������� �������
function SelectedOption(x, y: real): real; //������� �����
function MethodEjlera(a, b, y0, h: real; n: integer): Dat_Ar; stdcall;//������� �����
function MmethodEjlera(a, b, y0, h: real; n: integer): Dat_Ar; stdcall;//���������������� �����

end;
implementation
end.


