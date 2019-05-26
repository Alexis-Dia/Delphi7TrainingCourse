program VremRiad;

uses
  Forms,Windows,Classes,Dialogs,SysUtils,
  UnitMain in 'UnitMain.pas' {Form1},
  UnitRiad in 'UnitRiad.pas',
  UComRiad in 'UComRiad.pas',
  UCom_Tlb in 'UCom_Tlb.pas',
  VremRiad_TLB in 'VremRiad_TLB.pas';

{$R *.TLB}
//******************************************
Type
//����������� ��� ��� �������, ���������� �� DLL
 TProc=procedure(AOwner:TComponent);
 Var
 Handle : LongWord; //���������� DLL
 ShowPrompt : tproc; //���������� ��� �������
//*******************************************
 {$R *.res}

begin
//*****�������� ���������� � ����� ��������******//
Handle:= LoadLibrary('Prompt.dll');
if Handle <> 0 then
begin
//�������� ����� ������� �� ����������
@ShowPrompt:= GetProcAddress(Handle, PChar('ShowPrompt'));
ShowPrompt(Application); //�������� ��������
FreeLibrary(Handle); //������� ����������
end
else ShowMessage('�� ������� ���������� Prompt.dll');
//***********************************************//

 Application.CreateForm(TForm1, Form1);
 Application.Run;
end.
