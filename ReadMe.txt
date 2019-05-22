1. Для просмотра юнитов/классов есть кнопка 'View form'

2. Секция type нужна для объявление типа. 
	type
  	    TIntegral= class
  	    private
    	         a: extended;

2.1. Секция var нужна для объявление переменной какого либо типа. 
	- Для Unit
	- Для процедуры, функции

3. При генерации юнита, базовый скелет выглядит так:

unit Unit2;

interface

implementation

end.

4. Декларация процедуры в новом классе:
	- Объявление класса в interface -> type
		type
  			TIntegral= class
	- Объявление процедуры в секции interface -> 
		  public
    			procedure SetField(Aa,Ab,Ah:extended; ASeries1: TLineSeries; ASeries2: TAreaSeries);
	- Реализация процедуры в секции implementation
			procedure TIntegral.SetField(Aa,Ab,Ah:extended; ASeries1: TLineSeries; ASeries2: TAreaSeries);
			begin
			  a:=Aa;
			  b:=Ab;
			  h:=Ah;
			  Series1:= ASeries1;
			  Series2:= ASeries2;
			end;


5. Создание объекта нового класса и вызов его процедуры:
	- Импортировать в секцию Uses новый Unit2 с новым классом:
		uses
  		    Windows, Messages, SysUtils, Variants, Unit2;
	- После секции type нужно задекларировать в новой секции var(идет после type):
		var
  			Integral: TIntegral;
	- Инициализировать объект(где-то):
			Integral:=TIntegral.Create;	
	- Вызвать необходимую процедуру:
		Integral.SetField(a,b,h,Series1,Series2);

6. Декларация функции в новом классе:
	- Объявление класса в interface -> type
		type
  			TIntegral= class
	- Объявление функции в секции interface -> 
		  public
    			function  CalculateLeftRectangle():extended;
	- Реализация функции в секции implementation
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

7. Создание объекта нового класса и вызов его функции:
	- Импортировать в секцию Uses новый Unit2 с новым классом:
		uses
  		    Windows, Messages, SysUtils, Variants, Unit2;
	- После секции type нужно задекларировать в новой секции var(идет после type):
		var
  			Integral: TIntegral;
	- Инициализировать объект(где-то):
			Integral:=TIntegral.Create;	
	- Вызвать необходимую функцию:
			S:=Integral.CalculateLeftRectangle();

8. Для просмотра всех кнопок, вьюшек - юзай окно Object Tree View


9. Для отображения числа - TEdit (значок ab)
	Для установки ему значения:
		Edit1.Text:=FloatToStr(Sum);
  Кликнув два раза, создаться хэндлер.

10. Для привязки какого-либо видимого элемента хэндлера, нужно кликнуть на элемент(отобразится  Object Inspector), и во вкладке Event напротив необходимого ивента, кликнуть два раза - сгенерится процедура.
















