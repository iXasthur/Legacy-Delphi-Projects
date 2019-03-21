program S2_Lab3;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;


const
  F_1a=1.0;
  F_1b=2.2;

  F_2a=0.6;
  F_2b=1.0;

  F_3a=0.2;
  F_3b=1.2;

  F_4a=0.6;
  F_4b=1.4;

  e1 = 1/100;
  e2 = 1/1000;



type
  TFunc = function(x: Real):Real;

function F_1(x: real):real;
begin
  F_1:=sqrt(1.5*x+0.6)/(1.6+sqrt(0.8*x*x+2));
end;

function F_2(x: real):real;
begin
  F_2:=cos(0.6*x*x+0.4)/(1.4+sin(x+0.7)*sin(x+0.7));
end;

function F_3(x: real):real;
begin
  F_3:=1/sqrt(x*x+1);
end;

function F_4(x: real):real;
begin
  F_4:=cos(x)/(x+1);
end;



procedure RecIntCalc(f:tfunc; a,b:real; var n_1,n_2:Integer; var i1_2,i2_2:real);
var k:integer;
    razn,i2_1,i1_1,h,sum:real;
begin
  i1_2:=0;
  n_1:=0;
  repeat
    sum:=0;
    i1_1:=i1_2;
    n_1:=n_1+5;
    h:=(b-a)/n_1;
    for k:=0 to n_1-1 do
    begin
      sum:=sum+f(a+k*h+h/2);
    end;
    i1_2:=h*sum;
    Razn:=i1_2-i1_1;
  until abs(razn)<e1;

  n_2:=n_1;
  i2_2:=i1_2;

  repeat
    sum:=0;
    i2_1:=i2_2;
    n_2:=n_2+5;
    h:=(b-a)/n_2;
    for k:=0 to n_2-1 do
    begin
      sum:=sum+f(a+k*h+h/2);
    end;
    i2_2:=h*sum;
    Razn:=i2_2-i2_1;
  until abs(razn)<e2
end;



procedure TrapIntCalc(f: TFunc; a, b: Real; var N1, N2: Integer; var Integral_Eps1, Integral_Eps2: Real);

var
  i: Integer;
  h, Height, x: Real;
  LastIntegral, NextIntegral: Real;

begin
  N1 := 5;
  h := (b - a) / N1;

  NextIntegral := ((f(a) - f(b)) / 2) * h;

  repeat
    LastIntegral := NextIntegral;

    Height := (f(a) + f(b)) / 2;

    h := (b - a) / N1;
    for i := 1 to (N1 - 1) do
      begin
        x := a + i * h;
        Height := Height + f(x);
      end;

    NextIntegral := Height * h;
    N1 := N1 + 5;
  until (abs(NextIntegral - LastIntegral) < E1);

  Integral_Eps1 := NextIntegral;
  N2 := N1;

  repeat
    h := (b - a) / N2;

    Height := (f(a) + f(b)) / 2;

    LastIntegral := NextIntegral;

    for i := 1 to (N2 - 1) do
      begin
        x := a + i * h;
        Height := Height + f(x);
      end;

    NextIntegral := Height * h;

    N2 := N2 + 5;
  until (abs(NextIntegral - LastIntegral) < E2);

  Integral_Eps2 := NextIntegral;
end;








var
  n_1,n_2,i: integer;
  i_1,i_2, a, b:real;
  F: TFunc;
begin
  writeln('-------------------------------------------------------------------------------');
  writeln('|             |          1st method           |           2nd method          |');
  writeln('|             |---------------------------------------------------------------|');
  writeln('|             |     e=',e1:0:2,'    |    e=',e2:0:3,'    |     e=',e1:0:2,'    |    e=',e2:0:3,'    |');
  writeln('|             |---------------------------------------------------------------|');
  writeln('|             |  value  |  N  |  value  |  N  |  value  |  N  |  value  |  N  |');
  writeln('-------------------------------------------------------------------------------');

  for i:= 1 to 4 do
  begin
    case i of
      1:
        begin
          F:=F_1;
          a:=F_1a;
          b:=F_1b;
        end;
      2:
        begin
          F:=F_2;
          a:=F_2a;
          b:=F_2b;
        end;
      3:
        begin
          F:=F_3;
          a:=F_3a;
          b:=F_3b;
        end;
      4:
        begin
          F:=F_4;
          a:=F_4a;
          b:=F_4b;
        end;
    end;

    RecIntCalc(F,a,b,n_1,n_2,i_1,i_2);

    writeln('|             |         |     |         |     |         |     |         |     |');
    write('| Integral ',i,'  | ',i_1:0:5,' |',n_1:4,' | ',i_2:0:5,' |',n_2:4,' |');

    TrapIntCalc(F,a,b,n_1,n_2,i_1,i_2);
    writeln(' ',i_1:0:5,' |',n_1:4,' | ',i_2:0:5,' |',n_2:4,' |');
    writeln('|             |         |     |         |     |         |     |         |     |');
    writeln('-------------------------------------------------------------------------------');
  end;


  readln;
end.
