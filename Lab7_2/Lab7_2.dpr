program Lab7_2;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

type
  TString = String;


procedure deleteSpaces(var sentence: TString);
begin
  sentence:=trim(sentence);
  {
  while pos('  ', sentence)>0 do
  begin
    sentence:=stringReplace(sentence, '  ', ' ', [rfReplaceAll]);
  end;
  }
  while pos('  ', sentence) > 0 do
  begin
    delete(sentence,pos('  ', sentence),1);
  end;
end;


function editWord(savedWord: TString): TString;
var
  j: integer;
  check: boolean;
begin
  check:= true;
  j:=length(savedWord);


  while (check=true) and (j>1) do
  begin
    if savedWord[1]=savedWord[j] then
    begin
      delete(savedWord, j, 1);
      delete(savedWord, 1, 1);
      j:=j-2;
    end else
        begin
          check:=false;
        end;



  end;




  editWord:=savedWord+' ';
end;


function editString(s: TString): TString;
var
  i: integer;
  savedWord: TString;
  buffString: TString;
begin
  i:=1;
  buffString:='';
  while i<=length(s) do
  begin
    savedWord:='';

    while (i<=length(s)) and (s[i]<>' ') do
    begin
      savedWord:=savedWord+s[i];
      i:=i+1;
    end;
    i:=i+1;

    buffString:=concat(buffString, editWord(savedWord));




  end;

  deleteSpaces(buffString);
  editString:=buffString;
end;


var
  sentence: TString;
begin
  writeln('Input string:');
  readln(sentence);

  writeln;
  writeln('Source string:');
  writeln('''',sentence,'''');
  writeln;

  deleteSpaces(sentence);


  writeln('Trimmed string:');
  writeln('''',sentence,'''');
  writeln;


  sentence:=editString(sentence);


  writeln;
  writeln('Edited string:');
  writeln('''',sentence,'''');
  writeln;

  readln;
end.
