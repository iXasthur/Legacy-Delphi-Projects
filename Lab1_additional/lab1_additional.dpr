program lab1_additional;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;




function digitsAreEqual(num1, num2: Integer):boolean;
var
  s1, s2: string;
  i: integer;
begin
  digitsAreEqual:= false;
  s1:=IntToStr(num1);
  s2:=IntToStr(num2);

  if length(s1)=length(s2) then
    begin
      for i := 1 to length(s1) do
      begin
        if pos(s1[i],s2)>0 then delete(s2, pos(s1[i],s2), 1);
      end;

      if length(s2)=0 then digitsAreEqual:= true;
    end;
end;



function calcSumOfDigits(num :Integer):Integer;
var
  sum: Integer;
begin
  sum:=0;
  repeat
    sum := sum + (num mod 10);
    num := num div 10
  until num = 0;

  calcSumOfDigits:=sum;
end;


var
  num1, amountToFind, amountFound: Integer;

begin
  amountFound:= 0;
  amountToFind:= 20;

  write('Start Pos: ');
  readln(num1);

//  if num1<0 then num1:=1;

  writeln('-----PAIRS-----');
  
  while (num1<High(integer)) and (amountFound<amountToFind) do
    begin
        if (digitsAreEqual(num1,num1-calcSumOfDigits(num1))=true) and (num1>0) then
          begin
            writeln(num1:6,' - ',num1-calcSumOfDigits(num1));
            amountFound:= amountFound + 1;
          end
        else if (digitsAreEqual(num1,num1+calcSumOfDigits(num1))=true) and (num1<0) then
          begin
            writeln(num1:6,' - ',num1+calcSumOfDigits(num1));
              amountFound:= amountFound + 1;
          end;

        num1 := num1 + 1;
    end;

  writeln('---------------');  
  writeln('Press <Enter> to exit');
  readln;
end.
