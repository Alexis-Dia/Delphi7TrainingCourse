unit InterfaceUnit;

{$WARN SYMBOL_PLATFORM OFF}

interface

type
  ISmpCom = interface
  ['{6A872EB9-1927-4522-8571-D2C842BC5974}']
  function Tangent(Angle: Double): Double; stdcall;
  {Declare ISmpCom methods here}
  end;

SmpComImpl = class(TInterfacedObject, ISmpCom)
  protected
  public
    function Tangent(Angle: Double): Double; stdcall;
  end;

implementation

uses ComServ;

function SmpComImpl.Tangent(Angle: Double): Double;

begin
Result:=Sin(Angle)/Cos(Angle);
end;

end.
