program Lab2_additional;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;
var
  z: integer;
  x, x1, x2, y, dx: real;
begin
  x1:=0.5;
  x2:=0.8;
  dx:=0.05;

  x:=x1;

  while x<=(x2+dx/1000) do
  begin
  write('x=',x:0:2);
  z:=12;
  y:=z+1;

  //calcY
  while z>0 do
  begin
      y:=z+(sqr((z mod 2) + (z div 2))*(x-1))/y;
      z:=z-1;
  end;
  y:=(x-1)/y;

  writeln('  y=',y:0:5);
  x:=x+dx;
  end;


  writeln('Press <Enter> to exit');
  readln;
end.
