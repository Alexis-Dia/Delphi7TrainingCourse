library ComLibrary;

uses
  ComServ,
  ComLibrary_TLB in 'ComLibrary_TLB.pas',
  XComUnit1 in 'XComUnit1.pas' {Com1: CoClass},
  FComUnit1 in 'FComUnit1.pas' {Com2: CoClass},
  ComProject_TLB in '..\..\..\..\..\Program Files\Borland\Delphi7\Imports\ComProject_TLB.pas';

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.TLB}

{$R *.RES}

begin
end.
