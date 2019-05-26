library Prompt;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,
  Classes,
  Windows,
  UnitPrompt in 'UnitPrompt.pas' {FormPrompt};

{$R *.res}
//Показать заставку
procedure ShowPrompt(AOwner:TComponent);
var
Time:extended;
Form:TFormPrompt;
begin
Form:=TFormPrompt.Create(AOwner);      //Создать форму
Time:=GetTickCount/1000;         //Запомнить время
Form.Show;               //Показать форму
Form.Repaint;               //Перерисовать форму
//Пока не вышел лимит времени - ничего не делать
while GetTickCount/1000<Time+4 do;
Form.Close;               //Закрыть форму
Form.Free;               //Уничтожить форму
end;

exports ShowPrompt;

begin
end.
