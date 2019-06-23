program Permutations;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

const
  n=4;

type
  TArray = array[1..n] of integer;
  TFile = TextFile;



procedure swap(var arr:TArray; s1,s2:integer);
var
  q: integer;
begin
  q:=arr[s1];
  arr[s1]:=arr[s2];
  arr[s2]:=q;
end;


procedure outputPermutations(var F:TFile; var a:TArray; l:integer);
var
  i:integer;
begin
  if (l=n) then
  begin
    for i:=1 to n do
    begin
      write(a[i],' ');
      write(F,a[i],' ');
    end;

    writeln;
    writeln(F);
  end else
        begin
          for i := l to n do
          begin
            swap(a,i,l);
            outputPermutations(F,a,l+1);
            swap(a,i,l);
          end;
        end;
end;






var
  arr:TArray;
  i:integer;
  F:TFile;
begin
  writeln('Initial array:');
  assignFile(F,'List.txt');
  rewrite(F);

  for i:=1 to n do
  begin
    arr[i]:=i;
    write(arr[i],' ');
  end;

  writeln;
  writeln;
  writeln('Permutations:');
  outputPermutations(F,arr,1);

  closeFile(F);
  readln;
end.
