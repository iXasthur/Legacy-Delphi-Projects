program Set2;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

const
  n = 10;
  minNum = 1;
  maxNum = 100;

type
  TSet = Set of minNum..maxNum;


procedure createSet(var X:TSet;name:String);
var
  i,s: Integer;
  check1,check2: Boolean;
begin
  check1:=false;
  check2:=false;

  for i := 1 to n do
  begin
    repeat
      check1:=false;
      check2:=false;
      writeln('Please input ',i,' element of ',name,' set (',minNum,'<=s<=',maxNum,')');
      write('s=');
      readln(s);

      if (s>=minNum) and (s<=maxNum) then
      begin
        check1:=true;
        if not(s in X) then
        begin
          check2:=true;
          writeln('Successful!');
        end else
            begin
              writeln('Element is already is set');
            end;
      end else
          begin
            writeln('Element must me from ',minNum,' to ',maxNum);
          end;

      writeln;
    until check1 and check2;
    X:=X+[s];
  end;
end;


procedure outputSet(X:TSet;name:String);
var
  i,s: Integer;
begin
  writeln(name,':');
  for i := minNum to maxNum do
  begin
    if i in X then
    begin
      write(i:4);
    end;
  end;
  writeln;
end;


function calcY(X1,X2,X3:TSet):TSet;
begin
  calcY:=[];
  X1:=X1+X2;
  X2:=X2*X3;
  X1:=X1-X2;
  calcY:=X1;
end;

var
  X1,X2,X3: TSet;
  i,s:integer;

begin
  writeln('Y = (X1 + X2) - (X2 * X3)');
  writeln;

  randomize;
  X1:=[];
  X2:=[];
  X3:=[];

  createSet(X1,'X1');
  createSet(X2,'X2');
  createSet(X3,'X3');

  writeln('Y = (X1 + X2) - (X2 * X3)');
  writeln;

  outputSet(X1,'X1');
  outputSet(X2,'X2');
  outputSet(X3,'X3');

  X1:=calcY(X1,X2,X3);

  writeln;
  outputSet(X1,'Y');

  readln;
end.
