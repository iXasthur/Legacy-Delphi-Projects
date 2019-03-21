program S2_Lab1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  SysUtils;

const
  n = 1000;


type
  TRec = Record
    p1:integer;
    p2:string[15];
    p3:boolean;
  end;
  TArr = array[1..n] of TRec;
  TSearchPh = string[15];






procedure fillArray(var arr:TArr);
var
  i: integer;
begin
  for i:=1 to n do
  begin
    with arr[i] do
    begin
      p1:=random(200);
      p2:='my_test_' + IntToStr(i);
      p3:=false;
    end;
  end;
end;




procedure outputArray(arr:TArr);
var
  i:integer;
begin
for i:=1 to n do
  with arr[i] do
  begin
    write('p1:  ', p1:4);
    write('   p2:  ', p2:10);
    writeln('   p3:  ', p3);
  end;
end;




procedure swapRec(var arr:TArr; i:integer);
var
  saveRec: TRec;
begin
  saveRec:= arr[i];
  arr[i]:=arr[i+1];
  arr[i+1]:=saveRec;
end;




procedure sortArrayByStr(var arr:TArr);
var
  i: integer;
  check: boolean;
begin
  check:=false;

  while check= false do
  begin
    check:= true;

    for i:=1 to n-1 do
    begin
      if arr[i].p2 > arr[i+1].p2 then
      begin
        swapRec(arr, i);
        check:=false;
      end;
    end;
  end;
end;


procedure sortArrayByNums(var arr:TArr);
var
  i: integer;
  check: boolean;
begin
  check:=false;

  while check= false do
  begin
    check:= true;

    for i:=1 to n-1 do
    begin
      if arr[i].p1 > arr[i+1].p1 then
      begin
        swapRec(arr, i);
        check:=false;
      end;
    end;
  end;
end;




function createBlocksStr(var arr: TArr; str:TSearchPh; var pos1, pos2: integer):boolean;
var
  i, lengthOfBlock: integer;
  check: boolean;
begin
  createBlocksStr:=false;

  lengthOfBlock:= trunc(sqrt(pos2-pos1));
  //writeln('Block size: ', lengthOfBlock);
  i:=pos1+lengthOfBlock;
  check:=false;

  while (check = false) do
  begin
    if i>=pos2 then
    begin
      check:=true;
      lengthOfBlock:=pos2-(i-lengthOfBlock);
      i:=pos2;
    end;

    arr[i].p3:=true;

    if arr[i].p2=str then
    begin
      check:=true;
      pos2:=i;

      writeln('Value has been found:');
      with arr[i] do
      begin
        write('p1:  ', p1:4);
        write('   p2:  ', p2:10);
        writeln('   p3:  ', p3);
      end;

      createBlocksStr:=true;
    end else
        if arr[i].p2>str then
        begin
          check:=true;
          pos2:=i;
          pos1:=pos2-lengthOfBlock;
          //writeln('New poses:',pos1,' ', pos2);

        end;

    i:=i+lengthOfBlock;
  end;

end;



procedure searchInArrayByStr(var arr: TArr; str: TSearchPh);
var
  pos1, pos2: integer;
  check: Boolean;
begin
//  str:='my_test_99';
  //writeln('Search result:');

  check:=false;
  pos1:=0;
  pos2:=n;


  if (str<=arr[n].p2) and (str>=arr[1].p2) then
  begin
    repeat
      check:=createBlocksStr(arr, str, pos1, pos2);
    until ((pos2-pos1)<=1) or (check = true);

  end else
      begin
        check:=false;
      end;


  if check = false then
  begin
    writeln('Value don''t exist');
  end;


end;


function createBlocksNum(var arr: TArr; num:integer; var pos1, pos2: integer):boolean;
var
  i, q1, q2, lengthOfBlock: integer;
  check: boolean;
begin
  createBlocksNum:=false;

  lengthOfBlock:= trunc(sqrt(pos2-pos1));
  //writeln('Block size: ', lengthOfBlock);
  i:=pos1+lengthOfBlock;
  check:=false;

  while (check = false) do
  begin
    if i>=pos2 then
    begin
      check:=true;
      lengthOfBlock:=pos2-(i-lengthOfBlock);
      i:=pos2;
    end;

    arr[i].p3:=true;

    if arr[i].p1=num then
    begin
      check:=true;
      pos2:=i;

      writeln('Values has been found:');
      q1:=i;
      q2:=i;


      while (q1>1) and (arr[q1-1].p1=arr[pos2].p1) do
      begin
        arr[q1-1].p3:=true;
        if arr[q1-1].p1=arr[pos2].p1 then
        begin
          q1:=q1-1;
        end;
      end;


      while (q2<n) and (arr[q2+1].p1=arr[pos2].p1) do
      begin
        arr[q2+1].p3:=true;
        if arr[q2+1].p1=arr[pos2].p1 then
        begin
          q2:=q2+1;
        end;
      end;

      for i := q1 to q2 do
      begin
        with arr[i] do
        begin
          write('p1:  ', p1:4);
          write('   p2:  ', p2:10);
          writeln('   p3:  ', p3);
        end;
      end;

      createBlocksNum:=true;
    end else
        if arr[i].p1>num then
        begin
          check:=true;
          pos2:=i;
          pos1:=pos2-lengthOfBlock;
          //writeln('New poses:',pos1,' ', pos2);

        end;

    i:=i+lengthOfBlock;
  end;

end;



procedure searchInArrayByNum(var arr: TArr; num: integer);
var
  pos1, pos2: integer;
  check: Boolean;
begin
  check:=false;
  pos1:=0;
  pos2:=n;


  if (num<=arr[n].p1) and (num>=arr[1].p1) then
  begin
    repeat
      check:=createBlocksNum(arr, num, pos1, pos2);
    until ((pos2-pos1)<=1) or (check = true);

  end else
      begin
        check:=false;
      end;


  if check = false then
  begin
    writeln('Value don''t exist');
  end;
end;







function countTrue(arr: TArr):integer;
var
  i, s:integer;
begin
  s:=0;

  for i:=1 to n do
  begin
    if arr[i].p3=true then
    begin
      s:=s+1;
    end;
  end;

  countTrue:=s;
end;



procedure resetTrue(var arr: TArr);
var
  i:integer;
begin

  for i:=1 to n do
  begin
    arr[i].p3:=false;
  end;
end;




var
  arr: TArr;
  phraseToSearchFor: TSearchPh;
  i, numToSearchFor: integer;
begin
  randomize;

  writeln('Press <Enter> to generate array and output it');
  readln;


  fillArray(arr);
  writeln('Initial array:');
  outputArray(arr);


  writeln;
  writeln;
  writeln('Press <Enter> to output sorted by string array');
  readln;

  writeln;
  writeln;
  writeln('Sorted array(by String):');

  sortArrayByStr(arr);
  outputArray(arr);


  writeln;
  writeln;
  write('Enter string to search for: ');

  readln(phraseToSearchFor);
  searchInArrayByStr(arr, phraseToSearchFor);

//  for i := -1 to n+1 do
//  begin
//    phraseToSearchFor:='my_test_'+inttostr(i);
//    write(i,' ');
//    searchInArray(arr, phraseToSearchFor);
//  end;

  writeln;
  writeln;
  writeln('Press <Enter> to output edited array');
  readln;

  writeln;
  writeln;
  writeln('Edited array:');

  outputArray(arr);

  writeln;
  writeln('Amount of TRUEs: ', countTrue(arr));

  resetTrue(arr);

  writeln;
  writeln;
  writeln('Press <Enter> to sort array by numbers and output it');
  readln;
  //--------------------------


  writeln;
  writeln;
  writeln('Sorted array(by Numbers):');

  sortArrayByNums(arr);
  outputArray(arr);

  writeln;
  writeln;
  write('Enter number to search for: ');

  readln(numToSearchFor);
  searchInArrayByNum(arr, numToSearchFor);

  writeln;
  writeln;
  writeln('Press <Enter> to output edited array');
  readln;

  writeln;
  writeln;
  writeln('Edited array:');

  outputArray(arr);

  writeln;
  writeln('Amount of TRUEs: ', countTrue(arr));


  writeln;
  writeln;
  writeln('Press <Enter> to exit');
  readln;
end.

