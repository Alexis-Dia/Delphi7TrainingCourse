1. ��� ��������� ������/������� ���� ������ 'View form'

2. ������ type ����� ��� ���������� ����. 
	type
  	    TIntegral= class
  	    private
    	         a: extended;

2.1. ������ var ����� ��� ���������� ���������� ������ ���� ����. 
	- ��� Unit
	- ��� ���������, �������

3. ��� ��������� �����, ������� ������ �������� ���:

unit Unit2;

interface

implementation

end.

4. ���������� ��������� � ����� ������:
	- ���������� ������ � interface -> type
		type
  			TIntegral= class
	- ���������� ��������� � ������ interface -> 
		  public
    			procedure SetField(Aa,Ab,Ah:extended; ASeries1: TLineSeries; ASeries2: TAreaSeries);
	- ���������� ��������� � ������ implementation
			procedure TIntegral.SetField(Aa,Ab,Ah:extended; ASeries1: TLineSeries; ASeries2: TAreaSeries);
			begin
			  a:=Aa;
			  b:=Ab;
			  h:=Ah;
			  Series1:= ASeries1;
			  Series2:= ASeries2;
			end;


5. �������� ������� ������ ������ � ����� ��� ���������:
	- ������������� � ������ Uses ����� Unit2 � ����� �������:
		uses
  		    Windows, Messages, SysUtils, Variants, Unit2;
	- ����� ������ type ����� ��������������� � ����� ������ var(���� ����� type):
		var
  			Integral: TIntegral;
	- ���������������� ������(���-��):
			Integral:=TIntegral.Create;	
	- ������� ����������� ���������:
		Integral.SetField(a,b,h,Series1,Series2);

6. ���������� ������� � ����� ������:
	- ���������� ������ � interface -> type
		type
  			TIntegral= class
	- ���������� ������� � ������ interface -> 
		  public
    			function  CalculateLeftRectangle():extended;
	- ���������� ������� � ������ implementation
				function TIntegral.CalculateLeftRectangle():extended;
				var
				  x,S:extended;
				begin
				  x:=a;
				  S:=0;
				  while x<=b do
				  begin
					S:=S+h*Integral(x);
					x:=x+h;
				  end;
				  result:=S;
				end;

7. �������� ������� ������ ������ � ����� ��� �������:
	- ������������� � ������ Uses ����� Unit2 � ����� �������:
		uses
  		    Windows, Messages, SysUtils, Variants, Unit2;
	- ����� ������ type ����� ��������������� � ����� ������ var(���� ����� type):
		var
  			Integral: TIntegral;
	- ���������������� ������(���-��):
			Integral:=TIntegral.Create;	
	- ������� ����������� �������:
			S:=Integral.CalculateLeftRectangle();

8. ��� ��������� ���� ������, ������ - ���� ���� Object Tree View


9. ��� ����������� ����� - TEdit (������ ab)
	��� ��������� ��� ��������:
		Edit1.Text:=FloatToStr(Sum);
  ������� ��� ����, ��������� �������.

10. ��� �������� ������-���� �������� �������� ��������, ����� �������� �� �������(�����������  Object Inspector), � �� ������� Event �������� ������������ ������, �������� ��� ���� - ���������� ���������.
















