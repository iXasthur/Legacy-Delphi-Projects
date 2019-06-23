program ASMI;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

const
  n=10;

type
  TArray = array[1..n] of integer;

var
  arr:TArray;
  i,c,z:integer;
begin
  randomize;

  c:=n;
//  for i:=1 to n do
//  begin
//    arr[i]:=random(20)-5;
//    write(arr[i]:3);
//  end;

  for i:=1 to n do
  begin
    write(i,': ');
    readln(arr[i]);
  end;
  writeln;

  for i:=1 to n do
  begin
    write(arr[i]:3);
  end;
  writeln;

  asm
    xor ecx,ecx
    mov ecx,dword[c]
    mov ebx,0
    @L:
    cmp dword[arr+ebx],0
    jge @End
    mov dword[arr+ebx],0
    inc [z]
    @End:
    add ebx,4
    loop @L
  end;

  for i:=1 to n do
  begin
    write(arr[i]:3);
  end;
  writeln;
  writeln('Amount of changes: ',z);
  readln;
end.
