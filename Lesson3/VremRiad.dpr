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
//Процедурный тип для функции, вызываемой из DLL
 TProc=procedure(AOwner:TComponent);
 Var
 Handle : LongWord; //Дескриптор DLL
 ShowPrompt : tproc; //Переменная для функции
//*******************************************
 {$R *.res}

begin
//*****Загрузка библиотеки и показ заставки******//
Handle:= LoadLibrary('Prompt.dll');
if Handle <> 0 then
begin
//Получить адрес функции из библиотеки
@ShowPrompt:= GetProcAddress(Handle, PChar('ShowPrompt'));
ShowPrompt(Application); //Показать заставку
FreeLibrary(Handle); //Удалить библиотеку
end
else ShowMessage('Не найдена библиотека Prompt.dll');
//***********************************************//

 Application.CreateForm(TForm1, Form1);
 Application.Run;
end.
