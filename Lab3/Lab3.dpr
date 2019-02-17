program Lab3;

{$APPTYPE CONSOLE}

{$R *.res}


uses
  System.SysUtils;




var
  count,k,q,i: integer;
  accuracy,x, y: real;
  check: boolean;

begin
  accuracy:=0.01;
  x:= -0.6;
  count:=1;

  writeln('---------------------------------------------------------------------');
  writeln('|       |        |     e=0.01     |    e=0.001     |    e=0.0001    |');
  writeln('|   x   |  f1(x) |--------------------------------------------------|');
  writeln('|       |        |  f2(x) |   N   |  f2(x) |   N   |  f2(x) |   N   |');
  writeln('---------------------------------------------------------------------');


  while count<=20 do
    begin
    //write(x:6:3);
    write('| ',x:5:2,' | ',ln(1+x):6:3,' | ');

    check:=true;
    k:=1;
    q:=-1;
    y:=0;


    for i := 1 to 3 do
    begin
      while check=true do
        begin
          if x<=0+0.05/1000 then
            begin
              y:= y - exp(k*ln(-x))/k;
            end
              else
                begin
                  q:=-q;
                  y:= y + q*exp(k*ln(x))/k;
                end;


          k:=k+1;
          if (abs(exp((k-1)*ln(abs(x)))/(k-1) - exp((k)*ln(abs(x)))/(k)))<accuracy then
            check:=false;


        end;

      write(y:6:3,' | ',(k-1):3,' | ':5);
      accuracy:=accuracy/10;
      check:=true;
    end;



    writeln;
    x:=x+0.05;
    count:=count+1;
    accuracy:=0.01;
    end;
  writeln('---------------------------------------------------------------------');


  readln;
end.
