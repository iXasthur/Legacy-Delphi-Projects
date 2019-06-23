program Hanoi;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

type
    THanoi = (A, B, C);
    THanoiCount = array[1..3] of integer;

procedure move(t1,t2:THanoi;var count:THanoiCount);
begin
  write('Move disk form ');
  case t1 of
    A:
      begin
        write('A tower');
        dec(count[1]);
      end;
    B:
      begin
        write('B tower');
        dec(count[2]);
      end;
    C:
      begin
        write('C tower');
        dec(count[3]);
      end;
  end;
  write(' to ');
  case t2 of
    A:
      begin
        write('A tower');
        inc(count[1]);
      end;
    B:
      begin
        write('B tower');
        inc(count[2]);
      end;
    C:
      begin
        write('C tower');
        inc(count[3]);
      end;
  end;
  write('     ',count[1],'-',count[2],'-',count[3]);
  writeln;
end;


procedure HanoiTask(n: integer; A, B, C: THanoi; var count:THanoiCount);
begin
  if n = 1 then
  begin
    move(A,C,count)
  end else
      begin
        HanoiTask(n - 1, A, C, B, count);
        move(A,C,count);
        HanoiTask(n - 1, B, A, C, count)
      end;
end;





var
  n: integer;
  count: THanoiCount;
begin
  writeln('Please input amount of disks');
  readln(n);
  count[1]:=n;
  count[2]:=0;
  count[3]:=0;

  writeln;
  writeln('---------------------------------     A-B-C');
  writeln('                                      ',count[1],'-0-0');
  HanoiTask(n, A, B, C, count);

  readln;
end.
