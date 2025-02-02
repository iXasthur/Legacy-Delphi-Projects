program Lab2;

{$APPTYPE CONSOLE}

{$R *.res}

uses
System.SysUtils;



procedure calcY(x:real);
var
  n1, n2, k, n:Integer;
  y, saveSum: real;
begin
  n1:=10;
  n2:=15;

  for n := n1 to n2 do
    begin
      saveSum:=0;
      y:=sqrt(exp(x*ln(n))+1);

      for k := 1 to n do
        begin
        saveSum:=saveSum+(exp((1/5)*ln(x)) + cos(k*n/5))/(k - ln(x));
        end;
      
      y:=y+saveSum;
      writeln('n=',n,' x=',x:0:2,' f=',y:0:5);
    end;
end;






var
  pogr, x1, x2, dx, x:Real;

begin
  x1:=0.6;
  x2:=1.1;
  dx:=0.25;
  pogr:=dx/1000;

  x:=x1;
  while x<=x2+pogr do
  begin
    calcY(x);
    x:= x+dx;
    writeln;
  end;

  writeln('Press <Enter> to exit');
  readln;
end.
