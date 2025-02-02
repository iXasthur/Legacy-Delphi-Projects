program Lab3_additional;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

const
  accuracy = 0.0001;



function f(x:real):real;
begin
  f:=cos(x) - sqr(x);
end;




function sign(x: double): integer;
begin
  if x < 0
    then sign := -1
    else if x > 0
      then sign := 1
      else sign := 0
end;




function secantMethod(startPos, endPos: real):real;
begin
writeln('SecantMethod value');


    while(abs(endPos - startPos) > accuracy) do
      begin
        startPos := endPos - (endPos - startPos) * f(endPos) / (f(endPos) - f(startPos));
        endPos := startPos + (startPos - endPos) * f(startPos) / (f(startPos) - f(endPos));
      end;
    writeln('    y=', endPos:0:10);
    writeln;
    secantMethod:=endPos;
end;



function bisectionalMethod(startPos, endPos: real):real;
var
  midPos: real;
begin
  writeln('BisectionalMethod value');

  if f(startPos)=0 then
  begin
    midPos:=startPos;
  end
    else
    if f(endPos)=0 then
    begin
      midPos:=endPos;
    end
      else
      begin
        while endPos-startPos>accuracy do
        begin
          midPos:=startPos + (endPos-startPos)/2;
          if sign(f(startPos))<>sign(f(midPos)) then
          begin
            endPos:=midPos;
          end
            else
            begin
              startPos:=midPos;
            end;
        end;
      end;


    writeln('    y=', midPos:0:10);
    writeln;
    bisectionalMethod:=midPos;
end;


var
  startPos, endPos: integer;
  y1, y2:real;
begin
//---------->var 18
startPos:=0;
endPos:=1;

y1:=secantMethod(startPos, endPos); // ����� ����
y2:=bisectionalMethod(startPos, endPos); // ����� ������� ������� �������


writeln('Comparison:');
if abs(y1-y2)<=accuracy then
begin
  writeln('    SecantMethod value = BisectionalMethod value');
end
  else if y1>y2 then
       begin
       writeln('    SecantMethod value > BisectionalMethod value');
       end
          else
            writeln('    SecantMethod value < BisectionalMethod value');
readln;
end.
