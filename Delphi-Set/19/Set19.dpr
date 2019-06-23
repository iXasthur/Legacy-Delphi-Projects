program Set19;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

const
  minChar = '�';
  maxChar = '�';

type
  TString = String;
  TSet = Set of minChar..maxChar;

const
  deaf�onsonants = ['�', '�', '�', '�', '�', '�', '�', '�', '�'];
  deafSet: TSet = deaf�onsonants;






procedure inputStr(var s: TString; q: Integer);
begin
  case q of
    1:
      begin
        writeln('Please input string:');
        readln(s);
        writeln;
      end;
    else
      begin
        s:='�������,��������,������,�������,�������,���.';
//        s:='a��,���,���,���,���.';
      end;
  end;
end;



procedure performTask(initS:string);
var
  c: AnsiChar;
  s: AnsiString;
  buff,X,U: TSet;
  i,count:integer;
begin
  X:=[];
  s:=AnsiString(initS);

  write('������ ���������:');
  for c := minChar to maxChar do
  begin
    U:=U+[c];
    if c in deafSet then
    begin
      write(c:2);
    end;
  end;
  writeln;
  writeln;

  writeln('��������� ������:');
  writeln(s);
  writeln;

  writeln('������ ��������� �����, ������� �� ������ ������ � ���� �����:');



  i:=0;
  while i<length(s)-1 do
  begin
    i:=i+1;
    c:=s[i];
    if c=',' then
    begin
      i:=i+1;
      c:=s[i];
    end;
    X:=X+[c];
  end;

  X:=X-(U-deafSet);

  for c := minChar to maxChar do
  begin
    if c in X then
    begin
      count:=0;
      i:=1;

      while i<=length(s)-1 do
      begin
        buff:=[];

        while s[i]<>',' do
        begin
          buff:=buff+[s[i]];
          i:=i+1;
        end;

        if not(c in buff) then
        begin
          count:=count+1;
        end;
        i:=i+1;
      end;

      if count=1 then
      begin
        write(c:2);
      end;

    end;
  end;
end;




var
  s: TString;
begin
  inputStr(s,0);
  performTask(s);
  readln;
end.
