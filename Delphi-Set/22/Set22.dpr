program Set22;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

type
  TSetDigits = set of 0..9;

//const
//  Digits: TSetDigits = [0,1,2,3,4,5,6,7,8,9];


var
  N,i:Integer;
  X,U:TSetDigits;
begin
  N:=0;
  X:=[];
  for i := 0 to 9 do
  begin
    U:=U+[i];
  end;

  while N<=0 do
  begin
    writeln('Please input N (N>0)');
    readln(N);
    writeln;
  end;

  while N>0 do
  begin
    X:=X + [N mod 10];
    N:= N div 10;
  end;

  writeln('Digits that are not included in decimal entry of N in ascending order:');
  X:=U-X;
  for i := 0 to 9 do
  begin
    if i in X then
    begin
      write(i:2);
    end;
  end;
  readln;
end.
