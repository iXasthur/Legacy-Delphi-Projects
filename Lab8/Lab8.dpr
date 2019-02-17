program Lab8;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

const
  amountOfQuestions = 5;

type
  TQArray = array[1..amountOfQuestions] of String;

const
  maxPlayers = 10;
  questionArray:TQArray = ('Кто?','Какой внешне?','Встал и пошел куда?','С какой целью?','Кого встретил?');

type
  TGMatrix = array[1..5,1..maxPlayers] of string;


procedure fillingTheTablet(var GMatrix: TGMatrix; CurrPlayer: Integer);
var
  QuestionNum: Integer;

begin
  for QuestionNum := 1 to AmountOfQuestions do
    begin
      Writeln(questionArray[questionNum]);
      Readln(GMatrix[QuestionNum, CurrPlayer]);
    end;
end;





procedure change(var matrix:TGMatrix; playeramount:Integer);
var
  i, j, k: integer;
  temp: String;
begin
  for i:=1 to amountOfQuestions do
    for j:=1 to playeramount do
        begin
          k:=Random(playeramount)+1;

          temp:=matrix[i][j];
          matrix[i][j]:=matrix[i][k];
          matrix[i][k]:=temp;
        end;
end;


procedure lowerCaseRUS(var word: string);
var
  k: integer;
begin
  for k := 1 to length(word) do
    begin
      if (ord(word[k])<=ord(#1071)) and (ord(word[k])>=ord(#1040)) then
      begin
        word[k]:=chr(ord(word[k])+32);
      end;
    end;
end;









var
  playerAmount, currentPlayer, i, j: integer;
  gameMatrix: TGMatrix;
begin
  writeln('Введите кол-во игроков');
  readln(playerAmount);


  for currentPlayer:=1 to playerAmount do
  begin
    writeln;
    writeln('Игрок ', currentPlayer);
    fillingTheTablet(gameMatrix, currentPlayer);
  end;


  change(gameMatrix, playerAmount);




  writeln;
  for j:=1 to playerAmount do
  begin
    writeln('Сказка ', j);

    for i:=2 to amountOfQuestions do
    begin


        if i=3 then
        begin
          write(' встал и пошел');
        end;

        if i=5 then
        begin
          write(' и встретил');
        end;

        if i=2 then
        begin
          lowerCaseRUS(gameMatrix[1][j]);
          lowerCaseRUS(gameMatrix[i][j]);

          if (ord(gameMatrix[i][j][1])<=ord(#1103)) and (ord(gameMatrix[i][j][1])>=ord(#1072)) then
          begin
            gameMatrix[i][j][1]:=chr(ord(gameMatrix[i][j][1])-32);
          end;

          write(' ',gameMatrix[i][j]);
          write(' ',gameMatrix[1][j]);
        end else
          begin
            lowerCaseRUS(gameMatrix[i][j]);
            write(' ',gameMatrix[i][j]);
          end;


        if i=amountOfQuestions then
        begin
          write('.');
        end;

    end;


    writeln;
  end;
  writeln;




  readln;
end.
