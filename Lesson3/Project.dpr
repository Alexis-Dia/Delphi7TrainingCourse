program Project;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  InterfaceUnit in 'ComObjectProject\InterfaceUnit.pas' {SmpCom: CoClass},
  Unit2 in 'Unit2.pas' {Frame2: TFrame},
  Unit3 in 'Unit3.pas' {Frame3: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
