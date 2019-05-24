library MyServer;

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
  ComServ,
  UComRiad in 'UComRiad.pas',
  UCom_Tlb in 'UCom_Tlb.pas',
  Classes,
  MyServer_TLB in 'MyServer_TLB.pas';

exports
DllGetClassObject,
DllCanUnloadNow,
DllRegisterServer,
DllUnregisterServer;

{$R *.TLB}

{$R *.res}

begin
end.
