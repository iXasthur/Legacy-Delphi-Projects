program Lab6;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

const
  n = 16;

type
  TMatrix = array[1..n,1..n] of integer;
  TArray = array[1..(n*n)] of integer;

{
const
  matrix: TMatrix =
  (
   (11, 12, 13, 14),
   (21, 22, 23, 24),
   (31, 32, 33, 34),
   (41, 42, 43, 44)
  );
}



var
  matrix: TMatrix;

  ms: TArray;
  i, j, q, z, s:integer;
begin
//Matrix Inpup
for i := 1 to n do
  begin
    for j := 1 to n do
    begin
      matrix[i][j]:=random(80)+20;
      //readln(matrix[i][j]);
    end;
  end;


//Matrix Output
writeln('Matrix:');
for i:=1 to n do
begin
  for j:=1 to n do
    begin
      write(matrix[i][j]:3);
    end;

  writeln;
end;
writeln;



s:=1;
q:=0;
z:=0;
while s<=n*n do
begin
  z:=z+1;

  if z<=n then
  begin
    q:=q+1;

    j:=q;
    for i:=1 to q do
      begin
        ms[s]:=matrix[i][j-(i-1)];
        s:=s+1;
      end;
  end else
      begin
        q:=q-1;

        i:=n-q+1;
        for j:=n downto i do
         begin
           ms[s]:=matrix[i+abs(j-n)][j];
           s:=s+1;
         end;

      end;

  //writeln(s);
end;





writeln('Chain:');
for i:=1 to n*n do
begin
  write(ms[i]:3);
end;

writeln;
readln;
end.
