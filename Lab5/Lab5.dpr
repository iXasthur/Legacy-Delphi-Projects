program Lab5;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

const
  n=2000;

type
  TArray = array[1..n] of integer;


procedure swap(var ms: TArray; i:integer);
var
  save: integer;
begin
  save:=ms[i];
  ms[i]:=ms[i+1];
  ms[i+1]:=save;
end;


procedure reverse(var ms:TArray; size:integer);
var
  i, save:integer;
begin
  for i:=1 to (size div 2) do
    begin
      save:=ms[i];
      ms[i]:=ms[size+1-i];
      ms[size+1-i]:=save;
    end;
end;



procedure improvedBubbleSort(var ms: TArray; count: integer);
var
  i, swapCount, comparisonCount: integer;
  swapped: boolean;
begin
  swapped:= true;
  swapCount:=0;
  comparisonCount:=0;

  while swapped = true do
  begin
    swapped:=false;

    for i:=1 to (count-1) do
      begin
        if ms[i]>ms[i+1] then
        begin
          swap(ms, i);
          swapped:=true;
          swapCount:=swapCount + 1;
        end;
        comparisonCount:=comparisonCount + 1;
      end;
  end;


  write(comparisonCount:10,'|':4,swapCount:10,'|':4);
end;


procedure insertionSort(var ms: TArray; count: integer);
var
  i, j, save, swapCount, comparisonCount, swapped: integer;
begin
  swapCount:=0;
  comparisonCount:=0;


  for i:= 2 to count do begin
    j:= i;
    save := ms[i];


    while (j > 1) and (ms[j-1] > save) do
      begin
        ms[j]:= ms[j-1];
        j:=j-1;
        swapCount:=swapCount + 1;
        comparisonCount:=comparisonCount + 1;
      end;


    swapCount:=swapCount + 1;
    comparisonCount:=comparisonCount + 1;
    ms[j]:= save;


  end;



  write(comparisonCount:10,'|':4,swapCount:10,'|':4);
end;




procedure createTabletSegment(var ms1, ms2: TArray; s: integer);
begin


  write('|', s:5,'el, unsorted  |');
  improvedBubbleSort(ms1, s);
  insertionSort(ms2, s);

  writeln;
  writeln('|-------------------|-------------|-------------|-------------|-------------|');



  write('|', s:5,'el, sorted    |');
  improvedBubbleSort(ms1, s);
  insertionSort(ms2, s);

  writeln;
  writeln('|-------------------|-------------|-------------|-------------|-------------|');


  write('|', s:5,'el, reverse   |');
  reverse(ms1, s);
  improvedBubbleSort(ms1, s);
  reverse(ms2, s);
  insertionSort(ms2, s);

  writeln;
  writeln('|-------------------|-------------|-------------|-------------|-------------|');
end;









var
  i: integer;
  msInitial, ms1, ms2: TArray;
begin
  //randomize;

  writeln('-----------------------------------------------------------------------------');
  writeln('|                   |    Improved BubbleSort    |       InsertionSort       |');
  writeln('|     ArrayType     |---------------------------|---------------------------|');
  writeln('|                   | Comparisons |    Swaps    | Comparisons |    Swaps    |');
  writeln('|-------------------|-------------|-------------|-------------|-------------|');


  for i:=1 to n do
  begin
    msInitial[i]:=random(100);
  end;


  ms1:=msInitial;
  ms2:=msInitial;
  createTabletSegment(ms1, ms2, 10);


  ms1:=msInitial;
  ms2:=msInitial;
  createTabletSegment(ms1, ms2, 100);


  ms1:=msInitial;
  ms2:=msInitial;
  createTabletSegment(ms1, ms2, 2000);

  readln;
end.
