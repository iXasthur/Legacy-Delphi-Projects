program Lab1;

procedure calcY(x,pogr:real);
      var y, a, b:real;
begin
  if x>pogr then begin
      //calculate 1/sqrt(x)
      y:=1/sqrt(x);


      //calculate a
      a:= 0.2 + sin(x);
      if a> -pogr then begin
        //calculate b
        if (cos(pi*x/2)>-pogr) and (cos(pi*x/2)<pogr) then begin
                b:=0;
           end
           else if (cos(pi*x/2)>0) then begin
             b:=exp(1/3*ln(cos(pi*x/2)));
             end
           else begin
             b:=-1*exp(1/3*ln(-1*cos(pi*x/2)));
           end;

      //calculate y
      y:= y + ln(a)*ln(a)*b;
      writeln('x: ',x:0:3,'  y: ', y:0:5);
      end else
      begin
        writeln('x: ',x:0:3,'  y: Error:  0.2+sin(x)<0 =',a:0:5);
      end;
  end else
  begin
     writeln('x: ',x:0:3,'  y: Error: sqrt(x)<=0 =',x:0:5);
  end;
  end;





var
  x1, x2, x, k: real;
begin
  //pogr:=0.00001;
  //var12


  writeln;
  write('Input x1: ');
  readln(x1);

  write('Input x2: ');
  readln(x2);

  write('Input k: ');
  readln(k);



  if ((x1<x2) and (k<0)) or ((x1>x2) and (k>0)) or (k=0) then begin
    writeln('Invalid input: Error ((x1<x2) and (k<0)) or ((x1>x2) and (k>0)) or (k=0) ');
    writeln;

    k:=abs(k);
    calcY(x1,k/1000);
  end else
  begin
  x:=x1;
  k:=abs(k);


  if x1<x2 then begin
     while x<(x2 - k/1000) do begin
           calcY(x,k/1000);
           x:=x+k;
     end;
  end
  else begin
        while x>(x2 + k/1000) do begin
              calcY(x,k/1000);
              x:=x-k;
        end;
  end;
  end;

  calcY(x2,k/1000);
  writeln;
  writeln('Press <Enter> to exit');
  readln;
end.




//dop 12
