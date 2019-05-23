unit ComServer;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, ActiveX, Classes, ComObj, SimpleCOM_TLB, InterfaceUnit, StdVcl;

type
  TSimpleServer = class(TTypedComObject, ISmpCom)
  protected
  public
    function Tangent(Angle: Double): Double; stdcall;
  end;

const
  Class_MyCom: TGUID = '{E010DC5A-CE05-482A-B8D9-077D239F8596}';

implementation

uses ComServ;

function TSimpleServer.Tangent(Angle: Double): Double;

begin
Result:=Sin(Angle)/Cos(Angle) + 3;
end;

initialization
  TTypedComObjectFactory.Create(ComServer, TSimpleServer, Class_MyCom, ciMultiInstance, tmApartment);

end.
 