unit FComUnit1;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, ActiveX, Classes, ComObj, ComLibrary_TLB, StdVcl;

type
  TCom2 = class(TTypedComObject, ICom2)
  protected
    function FCom(xr, yr1, yr2, yr3: Single): Single; stdcall;
    {Declare ICom2 methods here}
  end;

implementation

uses ComServ;

function TCom2.FCom(xr, yr1, yr2, yr3: Single): Single;
begin
  Result:=5*xr-sqrt(abs(yr1))+23*yr2/yr3; 
end;

initialization
  TTypedComObjectFactory.Create(ComServer, TCom2, Class_Com2,
    ciMultiInstance, tmApartment);
end.
