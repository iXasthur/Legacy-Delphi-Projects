program Lab4;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

type
  TArray = array[1..40] of integer;


procedure swap(var ms: TArray; i:integer);
var
  save: integer;
begin
  save:=ms[i];
  ms[i]:=ms[i+1];
  ms[i+1]:=save;
end;



procedure sortArray(var ms: TArray);
var
  i: integer;
  swapped: boolean;
begin
  swapped:= true;

  while swapped = true do
  begin
    swapped:=false;
    for i:=1 to 39 do
      begin
        if (ms[i]<0) and (ms[i+1]>=0) then
        begin
          swap(ms, i);
          swapped:=true;
        end;
      end;
  end;
end;



var
  ms: TArray;
  i: integer;
begin
  randomize;

  writeln('Initial array:');
  for i:=1 to 40 do
    begin
      ms[i]:=random(20) - 10;;
      write(ms[i], ' ');
    end;
  writeln;
  writeln;

  sortArray(ms);

  writeln('Sorted array:');
  for i:=1 to 40 do
    begin
      write(ms[i], ' ');
    end;
  writeln;

  readln;
end.
