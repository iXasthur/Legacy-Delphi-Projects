program Lab7_1;

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

function findLastWord(s: TString): TString;
var
  i: integer;
  saveChar: char;
  save: TString;
begin
  i:=length(s);

  while (i>0) and (s[i]<>' ') do
  begin
    save:=save+s[i];
    i:=i-1;
  end;

  for i:=1 to length(save) div 2 do
  begin
    saveChar:=save[i];
    save[i]:=save[length(save)+1-i];
    save[length(save)+1-i]:=saveChar;
  end;


  findLastWord:=save;
end;



procedure deleteWordsFromString(var s: TString; lastWord: TString);
var
  check: Boolean;
  savedWord: TString;
  i: Integer;
begin
  check:= true;
  i:=1;

  while i<=length(s) do
  begin
    savedWord:='';

    while (i<=length(s)) and (s[i]<>' ') do
    begin
      savedWord:=savedWord+s[i];
      i:=i+1;
    end;
    i:=i+1;

    //writeln(savedWord);
    //writeln('   i-',i);

    if (savedWord=lastWord) then
    begin
      delete(s,(i-1)-length(savedWord), length(savedWord));
      i:=i-length(savedWord);
      //writeln('   di-',i);
    end;


  end;


end;



procedure countSymbols(var s: TString);
var
  savedWord: TString;
  savedChar: char;
  i, q: Integer;
begin
  writeln('Words and unique symbols:');
  i:=1;

  while i<=length(s) do
  begin
    savedWord:='';

    while (i<=length(s)) and (s[i]<>' ') do
    begin
      savedWord:=savedWord+s[i];
      i:=i+1;
    end;
    i:=i+1;

    writeln(savedWord);
    while length(savedWord)>0 do
    begin
      q:=0;
      savedChar:=savedWord[1];
      while pos(savedChar, savedWord)>0 do
      begin
        q:=q+1;
        delete(savedWord,pos(savedChar, savedWord), 1);
      end;

      writeln(savedChar:4,' - ',q);
    end;




  end;


end;


function wordIsUnique(s:TString; savedWord: TString): Boolean;
begin
  wordIsUnique:=false;

  if pos(savedWord, s, length(savedWord)+2)=0 then
  begin
    wordIsUnique:=true;
  end;


end;


procedure findUniqueWords(s: TString);
var
  savedWord: TString;
  i, q: Integer;
  uniqueWordFound: Boolean;
begin
  writeln('Unique words:');
  i:=1;
  uniqueWordFound:= false;

  while length(s)>0 do
  begin
    savedWord:='';

    while (i<=length(s)) and (s[i]<>' ') do
    begin
      savedWord:=savedWord+s[i];
      i:=i+1;
    end;
    i:=1;

    if wordIsUnique(s, savedWord)=true then
    begin
      uniqueWordFound:= true;
      writeln(savedWord:4);
    end;

    deleteWordsFromString(s, savedWord);
    deleteSpaces(s);




  end;

  if uniqueWordFound=false then
  begin
    writeln('There is no unique words in the string!');
  end;

end;



procedure doPartOne(var s1: TString; lastWord: TString);
begin
  deleteWordsFromString(s1, lastWord);
  deleteSpaces(s1);
  writeln('''',s1,'''');

  if s1<>'' then
  begin
    countSymbols(s1);
  end else
      begin
        writeln('The string in empty!');
      end;


  writeln;
end;



procedure doPartTwo(var s2: TString; lastWord: TString);
begin
  deleteWordsFromString(s2, lastWord);
  deleteSpaces(s2);
  writeln('''',s2,'''');

  if s2<>'' then
  begin
    findUniqueWords(s2);
  end else
      begin
        writeln('The string is empty!');
      end;



end;


var
  lastWord, sentence, s1, s2: TString;
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


  s1:=copy(sentence, 1, length(sentence));
  s2:=copy(sentence, 1, length(sentence));

  lastWord:=findLastWord(sentence);
  writeln('Last Word:');
  writeln('''',lastWord,'''');
  writeln;
  writeln;

  writeln('First task:');
  doPartOne(s1, lastWord);

  writeln('Second task:');
  doPartTwo(s2, lastWord);


  readln;
end.
