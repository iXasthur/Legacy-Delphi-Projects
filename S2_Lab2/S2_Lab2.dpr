program S2_Lab2;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;


const
  n = 100;
  currentYear = 2019;

type
  //--RECORDS
  TFirmRec = Record
    id: integer;

    title: String[15];
    vacancy: String[15];
    salary: integer;
    amountOfVacationDay: integer;

    higherEducationRequirement: Boolean;
    minAge: integer;
    maxAge: integer;
    experience: integer;
  End;

  TCandidateRec = Record
    id: integer;

    name: String[15];
    lastName: String[15];
    middleName: String[15];

    dateOfBirth: String[15];
    higherEducation: Boolean;
    speciality: String[15];
    careerObjective: String[15];
    minSalary: integer;
  End;
  //--


  //--LIST
  TFirmListAdr = ^TFirmListElement;
  TCandidateListAdr = ^TCandidateListElement;

  TFirmListElement = Record
    data: TFirmRec;
    next: TFirmListAdr;
  End;

  TCandidateListElement = Record
    data: TCandidateRec;
    next: TCandidateListAdr;
  End;
  //--

  TFirmFile = File of TFirmRec;
  TCandidateFile = File of TCandidateRec;

  TPFArray = array of TFirmListAdr;
  TPCArray = array of TCandidateListAdr;

//-----------------------------------------------------







//+
procedure readFirmsFromFile(var f: TFirmFile; var firmHead: TFirmListAdr);
var
  i: integer;
  firmElement, A: TFirmListAdr;
begin
  reset(f);

  if not eof(f) then
  begin
    writeln;
    writeln('Reading from firms file!');
    if firmHead=nil then
    begin
      new(firmHead);
      firmHead.next:=nil;

      firmElement:=firmHead;
      read(f,firmElement.data);

      while not eof(f) do
      begin
        new(firmElement.next);
        firmElement:=firmElement.next;
        firmElement.next:=nil;
        read(f,firmElement.data);
      end;
    end else
        begin
          //writeln;
          writeln('(Updating list!)');

          while firmHead.next<>nil do
          begin
            dispose(firmHead.next);
            firmHead.next:=firmHead.next.next;
          end;
          dispose(firmHead.next);
          dispose(firmHead);


          new(firmHead);
          firmHead.next:=nil;

          firmElement:=firmHead;
          read(f,firmElement.data);

          while not eof(f) do
          begin
            new(firmElement.next);
            firmElement:=firmElement.next;
            firmElement.next:=nil;
            read(f,firmElement.data);
          end;
        end;
  end;

end;

//+
procedure readCandidatesFromFile(var f: TCandidateFile; var candidateHead: TCandidateListAdr);
var
  i: integer;
  candidateElement: TCandidateListAdr;
begin
  reset(f);
  if not eof(f) then
  begin
    writeln;
    writeln('Reading from candidates file!');
    if candidateHead=nil then
    begin
      new(candidateHead);
      candidateHead.next:=nil;

      candidateElement:=candidateHead;
      read(f,candidateElement.data);

      while not eof(f) do
      begin
        new(candidateElement.next);
        candidateElement:=candidateElement.next;
        candidateElement.next:=nil;
        read(f,candidateElement.data);
      end;
    end else
        begin
          writeln('(Updating list!)');

          while candidateHead.next<>nil do
          begin
            dispose(candidateHead.next);
            candidateHead.next:=candidateHead.next.next;
          end;
          dispose(candidateHead.next);
          dispose(candidateHead);


          new(candidateHead);
          candidateHead.next:=nil;

          candidateElement:=candidateHead;
          read(f,candidateElement.data);

          while not eof(f) do
          begin
            new(candidateElement.next);
            candidateElement:=candidateElement.next;
            candidateElement.next:=nil;
            read(f,candidateElement.data);
          end;
        end;
  end;
end;

//+
procedure readFromFiles(var firmFile: TFirmFile; var firmListHead: TFirmListAdr ;var candidateFile: TCandidateFile; var candidateListHead: TCandidateListAdr);
var
  s: integer;
  rdyToExit: Boolean;
begin
  rdyToExit:=false;

  writeln;
  writeln;
  writeln('--Read Menu');
  writeln('1. Read from firms file');
  writeln('2. Read from candidates file');
  writeln('3. Read from both');
  writeln('4. Exit');
  writeln;

  while rdyToExit=false do
  begin
    write('->');
    readln(s);

    case s of
    1:
      begin
        readFirmsFromFile(firmFile, firmListHead);

        rdyToExit:=true;
      end;
    2:
      begin
        readCandidatesFromFile(candidateFile, candidateListHead);

        rdyToExit:=true;
      end;
    3:
      begin
        readFirmsFromFile(firmFile, firmListHead);
        readCandidatesFromFile(candidateFile, candidateListHead);

        rdyToExit:=true;
      end;
    4:
      begin

        rdyToExit:=true;
      end;

    else
      begin
        writeln('Invalid input');
      end;
    end;
  end;

  writeln;
  writeln;
end;

//+
procedure outputArray(firmHead:TFirmListAdr; candidatesHead:TCandidateListAdr);
var
  s, i: integer;
  rdyToExit: Boolean;

  firmElement: TFirmListAdr;
  candidateElement: TCandidateListAdr;
begin
  rdyToExit:=false;

  writeln;
  writeln;
  writeln('--Output Menu');
  writeln('1. Output firms and vacancies');
  writeln('2. Output candidates');
  writeln('3. Exit');
  writeln;




  while rdyToExit=false do
  begin
    write('->');
    readln(s);

    case s of
    1:
      begin
        firmElement:=firmHead;

        if firmHead = nil then
        begin
          writeln('Array is empty!');
        end else
            begin
              writeln('Output:');
              writeln('ID':5,'TITLE':15,'VACANCY':20,'SALARY':10,'VACATION':15,'H.EDU':15,'AGE':10,'EXP':10);

              while firmElement<>nil do
              begin
                with firmElement.data do
                begin
                  writeln(id:5,title:15,vacancy:20,salary:10,amountOfVacationDay:15,higherEducationRequirement:15,(intToStr(minAge)+'-'+intToStr(maxAge)):10,experience:10);
                end;
                firmElement:=firmElement.next;
              end;

              writeln;
            end;

        rdyToExit:=true;
      end;
    2:
      begin
        candidateElement:=candidatesHead;

        if candidatesHead = nil then
        begin
          writeln('Array is empty!');
        end else
            begin
              writeln('Output:');
              writeln('ID':5,'NAME':15,'LAST-NAME':15,'MIDDLE-NAME':15,'BIRTHDAY':15,'H.EDU':10,'SPEC':20,'C.OBG':20,'MIN-SALARY':15);

              while candidateElement<>nil do
              begin
                with candidateElement.data do
                begin
                  writeln(id:5,name:15,lastName:15,middleName:15,dateOfBirth:15,higherEducation:10,speciality:20,careerObjective:20,minSalary:15);

                end;
                candidateElement:=candidateElement.next;
              end;

              writeln;
            end;

        rdyToExit:=true;
      end;
    3:
      begin
        writeln('Going to Main Menu');
        rdyToExit:=true;
      end;

    else
      begin
        writeln('Invalid input');
      end;
    end;
  end;

  writeln;
  writeln;
end;

//+
procedure addToArray(var firmHead:TFirmListAdr; var candidatesHead:TCandidateListAdr);
var
  i, s, c, maxID1, maxID2: integer;
  rdyToExit: Boolean;

  firmElement: TFirmListAdr;
  candidateElement: TCandidateListAdr;
begin
  rdyToExit:=false;
  maxID1:=0;
  maxID2:=0;

  writeln;
  writeln;
  writeln('--Add Menu');
  writeln('1. Add firm with vacancy');
  writeln('2. Add candidate');
  writeln('3. Exit');
  writeln;

  while rdyToExit=false do
  begin
    write('->');
    readln(s);

    case s of
    1:
      begin
        if firmHead=nil then
        begin
          new(firmHead);
          firmHead.next:=nil;
          firmElement:=firmHead;
          maxID1:=1;
        end else
            begin
              firmElement:=firmHead;

              while firmElement.next<>nil do
              begin
                firmElement:=firmElement.next;

                if maxID1<firmElement.data.id then
                begin
                  maxID1:=firmElement.data.id;
                end;
              end;

              if maxID1=0 then
              begin
                inc(maxID1);
              end;

              inc(maxID1);



              new(firmElement.next);
              firmElement:=firmElement.next;
              firmElement.next:=nil;
            end;



        with firmElement.data do
        begin
          id:=maxID1;

          writeln('ID: ',id);

          writeln('Please input firm title');
          readln(title);

          writeln('Please input vacancy');
          readln(vacancy);

          writeln('Please input future salary');
          readln(salary);

          writeln('Please input amount of vacation days');
          readln(amountOfVacationDay);

          writeln('Please input 1 if higher education is required');
          readln(c);

          if c=1 then
          begin
            higherEducationRequirement:=true;
          end else
              begin
                higherEducationRequirement:=false;
              end;


          writeln('Please input min age');
          readln(minAge);

          writeln('Please input max age');
          readln(maxAge);

          writeln('Please required experience in years');
          readln(experience);

        end;

        rdyToExit:=true;
      end;
    2:
      begin


        if candidatesHead=nil then
        begin
          new(candidatesHead);
          candidatesHead.next:=nil;
          candidateElement:=candidatesHead;
          maxID2:=1;
        end else
            begin
              candidateElement:=candidatesHead;

              while candidateElement.next<>nil do
              begin
                candidateElement:=candidateElement.next;

                if maxID2<candidateElement.data.id then
                begin
                  maxID2:=candidateElement.data.id;
                end;
              end;

              if maxID2=0 then
              begin
                inc(maxID2);
              end;

              inc(maxID2);



              new(candidateElement.next);
              candidateElement:=candidateElement.next;
              candidateElement.next:=nil;
            end;



        with candidateElement.data do
        begin
          id:=maxID2;

          writeln('ID: ',id);

          writeln('Please input name');
          readln(name);

          writeln('Please input last name');
          readln(lastName);

          writeln('Please input middle name');
          readln(middleName);

          writeln('Please input date of birth (DD.MM.YYYY)');
          readln(dateOfBirth);

          writeln('Please input 1 if higher education is acquired');
          readln(c);

          if c=1 then
          begin
            higherEducation:=true;
          end else
              begin
                higherEducation:=false;
              end;

          writeln('Please input speciality');
          readln(speciality);

          writeln('Please input wanted vacancy');
          readln(careerObjective);

          writeln('Please input min salary');
          readln(minSalary);
        end;

        rdyToExit:=true;
      end;
    3:
      begin

        rdyToExit:=true;
      end;

    else
      begin
        writeln('Invalid input');
      end;
    end;
  end;

  writeln;
  writeln;
end;

//+
procedure sortFirms(var firmHead:TFirmListAdr);
var
  s, i: integer;
  rdyToExit: Boolean;
  saveRec: TFirmRec;
  check: boolean;

  A,B, firmElement: TFirmListAdr;
begin
  rdyToExit:=false;
  check:=false;

  writeln;
  writeln;
  writeln('--Sort Firms Menu');
  writeln('1. Sort by id');
  writeln('2. Sort by title');
  writeln('3. Sort by salary');
  writeln('4. Exit');
  writeln;

  while rdyToExit=false do
  begin
    write('->');
    readln(s);

    case s of
    1:
      begin

        if firmHead.next.next<>nil then
        begin
          while check=false do
          begin
            check:=true;
            firmElement:=firmHead;


            while firmElement.next.next<>nil do
            begin
              if firmElement.next.data.id>firmElement.next.next.data.id then
              begin

                A:=firmElement.next;
                B:=firmElement.next.next;


                A.next:=B.next;
                B.next:=A;


                firmElement.next:=B;


                check:=false;
              end;
                firmElement:=firmElement.next;
            end;
          end;

        end;


        rdyToExit:=true;
      end;
    2:
      begin
        if firmHead.next.next<>nil then
        begin
          while check=false do
          begin
            check:=true;
            firmElement:=firmHead;


            while firmElement.next.next<>nil do
            begin
              if firmElement.next.data.title>firmElement.next.next.data.title then
              begin

                A:=firmElement.next;
                B:=firmElement.next.next;


                A.next:=B.next;
                B.next:=A;


                firmElement.next:=B;


                check:=false;
              end;
                firmElement:=firmElement.next;
            end;
          end;

        end;


        rdyToExit:=true;
      end;
    3:
      begin
        if firmHead.next.next<>nil then
        begin
          while check=false do
          begin
            check:=true;
            firmElement:=firmHead;


            while firmElement.next.next<>nil do
            begin
              if firmElement.next.data.salary>firmElement.next.next.data.salary then
              begin

                A:=firmElement.next;
                B:=firmElement.next.next;


                A.next:=B.next;
                B.next:=A;


                firmElement.next:=B;


                check:=false;
              end;
                firmElement:=firmElement.next;
            end;
          end;

        end;


        rdyToExit:=true;
      end;
    4:
      begin

        rdyToExit:=true;
      end;

    else
      begin
        writeln('Invalid input');
      end;
    end;
  end;

  writeln;
  writeln;
end;

//+
procedure sortCandidates(var candidatesHead:TCandidateListAdr);
var
  s, i: integer;
  rdyToExit: Boolean;
  saveRec: TCandidateRec;
  check: boolean;

  A,B,candidateElement: TCandidateListAdr;
begin
  rdyToExit:=false;
  check:=false;

  writeln;
  writeln;
  writeln('--Sort Candidates Menu');
  writeln('1. Sort by id');
  writeln('2. Sort by full name');
  writeln('3. Sort by min salary');
  writeln('4. Exit');
  writeln;

  while rdyToExit=false do
  begin
    write('->');
    readln(s);

    case s of
    1:
      begin

        if candidatesHead.next.next<>nil then
        begin
          while check=false do
          begin
            check:=true;
            candidateElement:=candidatesHead;


            while candidateElement.next.next<>nil do
            begin
              if candidateElement.next.data.id>candidateElement.next.next.data.id then
              begin

                A:=candidateElement.next;
                B:=candidateElement.next.next;


                A.next:=B.next;
                B.next:=A;


                candidateElement.next:=B;


                check:=false;
              end;
                candidateElement:=candidateElement.next;
            end;
          end;

        end;

        rdyToExit:=true;
      end;
    2:
      begin

        if candidatesHead.next.next<>nil then
        begin
          while check=false do
          begin
            check:=true;
            candidateElement:=candidatesHead;


            while candidateElement.next.next<>nil do
            begin
              if (candidateElement.next.data.name+candidateElement.next.data.lastName+candidateElement.next.data.middleName)>(candidateElement.next.next.data.name+candidateElement.next.next.data.lastName+candidateElement.next.next.data.middleName) then
              begin

                A:=candidateElement.next;
                B:=candidateElement.next.next;


                A.next:=B.next;
                B.next:=A;


                candidateElement.next:=B;


                check:=false;
              end;
                candidateElement:=candidateElement.next;
            end;
          end;

        end;


        rdyToExit:=true;
      end;
    3:
      begin

        if candidatesHead.next.next<>nil then
        begin
          while check=false do
          begin
            check:=true;
            candidateElement:=candidatesHead;


            while candidateElement.next.next<>nil do
            begin
              if candidateElement.next.data.minSalary>candidateElement.next.next.data.minSalary then
              begin

                A:=candidateElement.next;
                B:=candidateElement.next.next;


                A.next:=B.next;
                B.next:=A;


                candidateElement.next:=B;


                check:=false;
              end;
                candidateElement:=candidateElement.next;
            end;
          end;

        end;



        rdyToExit:=true;
      end;
    4:
      begin

        rdyToExit:=true;
      end;

    else
      begin
        writeln('Invalid input');
      end;
    end;
  end;

  writeln;
  writeln;
end;

//+
procedure sortArray(var firmHead:TFirmListAdr; var candidatesHead:TCandidateListAdr);
var
  s: integer;
  rdyToExit: Boolean;

  F:TFirmListAdr;
  C:TCandidateListAdr;
begin
  rdyToExit:=false;

  writeln;
  writeln;
  writeln('--Sort Menu');
  writeln('1. Sort firms');
  writeln('2. Sort candidates');
  writeln('3. Exit');
  writeln;

  while rdyToExit=false do
  begin
    write('->');
    readln(s);

    case s of
    1:
      begin
        if firmHead <> nil then
        begin
          new(F);
          F.next:=firmHead;

          sortFirms(F);

          firmHead:=F.next;
          dispose(F);
        end else
            begin
              writeln('Array is empty');
            end;

        rdyToExit:=true;
      end;
    2:
      begin
        if candidatesHead <> nil then
        begin

          new(C);
          C.next:=candidatesHead;

          sortCandidates(C);

          candidatesHead:=C.next;
          dispose(C);

        end else
            begin
              writeln('Array is empty');
            end;

        rdyToExit:=true;
      end;
    3:
      begin

        rdyToExit:=true;
      end;

    else
      begin
        writeln('Invalid input');
      end;
    end;
  end;

  writeln;
  writeln;
end;

//+
procedure searchFirm(firmHead:TFirmListAdr);
var
  s, i, c, g: integer;
  rdyToExit: Boolean;
  saveRec: TFirmRec;
  check: boolean;
  q: string[15];

  firmElement: TFirmListAdr;
begin
  rdyToExit:=false;
  check:=false;

  writeln;
  writeln;
  writeln('--Search Firms Menu');
  writeln('1. Search by id');
  writeln('2. Search by title');
  writeln('3. Search by vacancy');
  writeln('4. Search by salary');
  writeln('5. Exit');
  writeln;

  while rdyToExit=false do
  begin
    write('->');
    readln(s);

    case s of
    1:
      begin
        writeln('Please input ID to search for');
        readln(c);
        writeln;
        writeln('Search results:');
        writeln('ID':5,'TITLE':15,'VACANCY':20,'SALARY':10,'VACATION':15,'H.EDU':15,'AGE':10,'EXP':10);

        firmElement:=firmHead;
        while firmElement<>nil do
        begin
          if firmElement.data.id=c then
          begin
            with firmElement.data do
            begin
              writeln(id:5,title:15,vacancy:20,salary:10,amountOfVacationDay:15,higherEducationRequirement:15,(intToStr(minAge)+'-'+intToStr(maxAge)):10,experience:10);
            end;

          end;

          firmElement:=firmElement.next;
        end;



        rdyToExit:=true;
      end;
    2:
      begin
        writeln('Please input title of firm to search for');
        readln(q);
        writeln;
        writeln('Search results:');
        writeln('ID':5,'TITLE':15,'VACANCY':20,'SALARY':10,'VACATION':15,'H.EDU':15,'AGE':10,'EXP':10);


        firmElement:=firmHead;
        while firmElement<>nil do
        begin
          if firmElement.data.title=q then
          begin
            with firmElement.data do
            begin
              writeln(id:5,title:15,vacancy:20,salary:10,amountOfVacationDay:15,higherEducationRequirement:15,(intToStr(minAge)+'-'+intToStr(maxAge)):10,experience:10);
            end;

          end;

          firmElement:=firmElement.next;
        end;


        rdyToExit:=true;
      end;
    3:
      begin
        writeln('Please input vacancy search for');
        readln(q);
        writeln;
        writeln('Search results:');
        writeln('ID':5,'TITLE':15,'VACANCY':20,'SALARY':10,'VACATION':15,'H.EDU':15,'AGE':10,'EXP':10);


        firmElement:=firmHead;
        while firmElement<>nil do
        begin
          if firmElement.data.vacancy=q then
          begin
            with firmElement.data do
            begin
              writeln(id:5,title:15,vacancy:20,salary:10,amountOfVacationDay:15,higherEducationRequirement:15,(intToStr(minAge)+'-'+intToStr(maxAge)):10,experience:10);
            end;

          end;

          firmElement:=firmElement.next;
        end;


        rdyToExit:=true;
      end;
    4:
      begin
        writeln('Please input minimum salary');
        readln(c);

        writeln('Please input maximum salary');
        readln(g);
        writeln;
        writeln('Search results:');
        writeln('ID':5,'TITLE':15,'VACANCY':20,'SALARY':10,'VACATION':15,'H.EDU':15,'AGE':10,'EXP':10);


        if c<=g then
        begin
          firmElement:=firmHead;
          while firmElement<>nil do
          begin
            if (firmElement.data.salary>=c) and (firmElement.data.salary<=g) then
            begin
              with firmElement.data do
              begin
                writeln(id:5,title:15,vacancy:20,salary:10,amountOfVacationDay:15,higherEducationRequirement:15,(intToStr(minAge)+'-'+intToStr(maxAge)):10,experience:10);
              end;

            end;

            firmElement:=firmElement.next;
          end;
        end else
            begin
              writeln('Invalid input');
            end;


        rdyToExit:=true;
      end;
    5:
      begin

        rdyToExit:=true;
      end;

    else
      begin
        writeln('Invalid input');
      end;
    end;
  end;

  writeln;
  writeln;
end;

//+
procedure searchCandidates(candidatesHead:TCandidateListAdr);
var
  s, i, c, g: integer;
  rdyToExit: Boolean;
  saveRec: TCandidateRec;
  check: boolean;
  q: String[45];
  z: String[15];

  candidateElement: TCandidateListAdr;
begin
  rdyToExit:=false;
  check:=false;

  writeln;
  writeln;
  writeln('--Search Candidates Menu');
  writeln('1. Search by id');
  writeln('2. Search by full name');
  writeln('3. Search by name');
  writeln('4. Search by higher education');
  writeln('5. Search by wanted vacancy');
  writeln('6. Search by salary');
  writeln('7. Exit');
  writeln;

  while rdyToExit=false do
  begin
    write('->');
    readln(s);

    case s of
    1:
      begin

        writeln('Please input ID to search for');
        readln(c);
        writeln;
        writeln('Search results:');
        writeln('ID':5,'NAME':15,'LAST-NAME':15,'MIDDLE-NAME':15,'BIRTHDAY':15,'H.EDU':10,'SPEC':20,'C.OBG':20,'MIN-SALARY':15);


        candidateElement:=candidatesHead;
        while candidateElement<>nil do
        begin
          if candidateElement.data.id=c then
          begin
            with candidateElement.data do
            begin
              writeln(id:5,name:15,lastName:15,middleName:15,dateOfBirth:15,higherEducation:10,speciality:20,careerObjective:20,minSalary:15);
            end;

          end;

          candidateElement:=candidateElement.next;
        end;

        rdyToExit:=true;
      end;
    2:
      begin
        writeln('Please input full name to search for');
        readln(q);
        writeln;
        writeln('Search results:');
        writeln('ID':5,'NAME':15,'LAST-NAME':15,'MIDDLE-NAME':15,'BIRTHDAY':15,'H.EDU':10,'SPEC':20,'C.OBG':20,'MIN-SALARY':15);

        candidateElement:=candidatesHead;
        while candidateElement<>nil do
        begin
          if (candidateElement.data.name+' '+candidateElement.data.lastName+' '+candidateElement.data.middleName)=q then
          begin
            with candidateElement.data do
            begin
              writeln(id:5,name:15,lastName:15,middleName:15,dateOfBirth:15,higherEducation:10,speciality:20,careerObjective:20,minSalary:15);
            end;

          end;

          candidateElement:=candidateElement.next;
        end;

        rdyToExit:=true;
      end;
    3:
      begin
        writeln('Please input name to search for');
        readln(q);
        writeln;
        writeln('Search results:');
        writeln('ID':5,'NAME':15,'LAST-NAME':15,'MIDDLE-NAME':15,'BIRTHDAY':15,'H.EDU':10,'SPEC':20,'C.OBG':20,'MIN-SALARY':15);

        candidateElement:=candidatesHead;
        while candidateElement<>nil do
        begin
          if candidateElement.data.name=q then
          begin
            with candidateElement.data do
            begin
              writeln(id:5,name:15,lastName:15,middleName:15,dateOfBirth:15,higherEducation:10,speciality:20,careerObjective:20,minSalary:15);
            end;

          end;

          candidateElement:=candidateElement.next;
        end;

        rdyToExit:=true;
      end;
    4:
      begin
        check:=false;

        writeln('Please input 1 to search for TRUE, else - FALSE');
        readln(c);

        if c=1 then
        begin
          check:=true;
        end;


        writeln('Search results:');
        writeln('ID':5,'NAME':15,'LAST-NAME':15,'MIDDLE-NAME':15,'BIRTHDAY':15,'H.EDU':10,'SPEC':20,'C.OBG':20,'MIN-SALARY':15);

        candidateElement:=candidatesHead;
        while candidateElement<>nil do
        begin
          if candidateElement.data.higherEducation=check then
          begin
            with candidateElement.data do
            begin
              writeln(id:5,name:15,lastName:15,middleName:15,dateOfBirth:15,higherEducation:10,speciality:20,careerObjective:20,minSalary:15);
            end;

          end;

          candidateElement:=candidateElement.next;
        end;

        rdyToExit:=true;
      end;
    5:
      begin
        writeln('Please input career objective to search for');
        readln(z);
        writeln;
        writeln('Search results:');
        writeln('ID':5,'NAME':15,'LAST-NAME':15,'MIDDLE-NAME':15,'BIRTHDAY':15,'H.EDU':10,'SPEC':20,'C.OBG':20,'MIN-SALARY':15);

        candidateElement:=candidatesHead;
        while candidateElement<>nil do
        begin
          if candidateElement.data.careerObjective=z then
          begin
            with candidateElement.data do
            begin
              writeln(id:5,name:15,lastName:15,middleName:15,dateOfBirth:15,higherEducation:10,speciality:20,careerObjective:20,minSalary:15);
            end;

          end;

          candidateElement:=candidateElement.next;
        end;

        rdyToExit:=true;
      end;
    6:
      begin
        writeln('Please input maximum salary you ready to pay');
        readln(c);
        writeln;
        writeln('Search results:');
        writeln('ID':5,'NAME':15,'LAST-NAME':15,'MIDDLE-NAME':15,'BIRTHDAY':15,'H.EDU':10,'SPEC':20,'C.OBG':20,'MIN-SALARY':15);

        candidateElement:=candidatesHead;
        while candidateElement<>nil do
        begin
          if candidateElement.data.minSalary<=c then
          begin
            with candidateElement.data do
            begin
              writeln(id:5,name:15,lastName:15,middleName:15,dateOfBirth:15,higherEducation:10,speciality:20,careerObjective:20,minSalary:15);
            end;

          end;

          candidateElement:=candidateElement.next;
        end;

        rdyToExit:=true;
      end;
    7:
      begin

        rdyToExit:=true;
      end;

    else
      begin
        writeln('Invalid input');
      end;
    end;
  end;

  writeln;
  writeln;
end;

//+
procedure searchInArray(firmHead:TFirmListAdr; candidatesHead:TCandidateListAdr);
var
  s: integer;
  rdyToExit: Boolean;
begin
  rdyToExit:=false;

  writeln;
  writeln;
  writeln('--Search Menu');
  writeln('1. Search for firm with vacancy');
  writeln('2. Search for candidate');
  writeln('3. Exit');
  writeln;

  while rdyToExit=false do
  begin
    write('->');
    readln(s);

    case s of
    1:
      begin
      if firmHead <> nil then
      begin
        searchFirm(firmHead);
      end else
          begin
            writeln('Array is empty');
          end;
        rdyToExit:=true;
      end;
    2:
      begin
        if candidatesHead <> nil then
        begin
          searchCandidates(candidatesHead);
        end else
            begin
              writeln('Array is empty');
            end;

        rdyToExit:=true;
      end;
    3:
      begin

        rdyToExit:=true;
      end;

    else
      begin
        writeln('Invalid input');
      end;
    end;
  end;

  writeln;
  writeln;
end;

//+
procedure removeFromArray(var firmHead:TFirmListAdr; var candidatesHead:TCandidateListAdr);
var
  s, id, i: integer;
  rdyToExit, check: Boolean;
  q: String[15];

  firmElement: TFirmListAdr;
  candidateElement: TCandidateListAdr;

  firmArray: TPFArray;
  candidateArray: TPCArray;



begin
  rdyToExit:=false;
  check:=true;

  writeln;
  writeln;
  writeln('--Removal Menu');
  writeln('1. Remove firm by title');
  writeln('2. Remove candidate by name');
  writeln;
  writeln('3. Remove firm by id');
  writeln('4. Remove candidate by id');
  writeln;
  writeln('5. Remove ALL firms');
  writeln('6. Remove ALL candidates');
  writeln;
  writeln('7. Exit');
  writeln;

  while rdyToExit=false do
  begin
    write('->');
    readln(s);

    case s of
    1:
      begin
        if firmHead<>nil then
        begin

          writeln('Please input title of firm to search for');
          readln(q);
          writeln;
          writeln('Search results:');
          writeln('ID':5,'TITLE':15,'VACANCY':20,'SALARY':10,'VACATION':15,'H.EDU':15,'AGE':10,'EXP':10);


          firmElement:=firmHead;
          while firmElement<>nil do
          begin
            if firmElement.data.title=q then
            begin
              with firmElement.data do
              begin
                setLength(firmArray, length(firmArray)+1);
                firmArray[length(firmArray)-1]:=firmElement;
              end;

            end;

            firmElement:=firmElement.next;
          end;


          for i:=0 to length(firmArray)-1 do
          begin
            with firmArray[i].data do
            begin
              writeln(i+1:5,title:15,vacancy:20,salary:10,amountOfVacationDay:15,higherEducationRequirement:15,(intToStr(minAge)+'-'+intToStr(maxAge)):10,experience:10);
            end;
          end;


          if length(firmArray)>0 then
          begin
            writeln;
            writeln('Please input ID of firm to delete');
            readln(id);


            //---------------------
            if (id>=1) and (id<=length(firmArray)) then
            begin
              id:=firmArray[id-1].data.id;

              check:=false;
              firmElement:= firmHead;

              if firmElement.data.id=id then
              begin
                check:=true;
              end;


              while (firmElement.next<>nil) and (check<>true) do
              begin
                if firmElement.next.data.id=id then
                begin
                  check:=true;
                end else
                    begin
                      firmElement:=firmElement.next;
                    end;
              end;


              if check=true then
              begin


                if firmElement=firmHead then
                begin

                  if firmHead.next=nil then
                  begin
                    writeln;
                    writeln('Deleting firm with ID = ',firmElement.data.id);
                    writeln('ID':5,'TITLE':15,'VACANCY':20,'SALARY':10,'VACATION':15,'H.EDU':15,'AGE':10,'EXP':10);
                    with firmElement.data do
                    begin
                      writeln(id:5,title:15,vacancy:20,salary:10,amountOfVacationDay:15,higherEducationRequirement:15,(intToStr(minAge)+'-'+intToStr(maxAge)):10,experience:10);
                    end;

                    dispose(firmHead.next);
                    firmHead:=nil;
                  end else
                        if id=firmHead.data.id then
                        begin
                          writeln;
                          writeln('Deleting firm with ID = ',firmElement.data.id);
                          writeln('ID':5,'TITLE':15,'VACANCY':20,'SALARY':10,'VACATION':15,'H.EDU':15,'AGE':10,'EXP':10);
                          with firmElement.data do
                          begin
                            writeln(id:5,title:15,vacancy:20,salary:10,amountOfVacationDay:15,higherEducationRequirement:15,(intToStr(minAge)+'-'+intToStr(maxAge)):10,experience:10);
                          end;

                          dispose(firmHead);
                          firmHead:=firmHead.next;
                        end else
                              if id<>firmHead.data.id then
                              begin
                                writeln;
                                writeln('Deleting firm with ID = ',firmElement.next.data.id);
                                writeln('ID':5,'TITLE':15,'VACANCY':20,'SALARY':10,'VACATION':15,'H.EDU':15,'AGE':10,'EXP':10);
                                with firmElement.next.data do
                                begin
                                  writeln(id:5,title:15,vacancy:20,salary:10,amountOfVacationDay:15,higherEducationRequirement:15,(intToStr(minAge)+'-'+intToStr(maxAge)):10,experience:10);
                                end;

                                dispose(firmHead.next);
                                firmHead.next:=firmHead.next.next;
                              end;




                end else
                    begin
                      writeln;
                      writeln('Deleting firm with ID = ',firmElement.next.data.id);
                      writeln('ID':5,'TITLE':15,'VACANCY':20,'SALARY':10,'VACATION':15,'H.EDU':15,'AGE':10,'EXP':10);
                      with firmElement.next.data do
                      begin
                        writeln(id:5,title:15,vacancy:20,salary:10,amountOfVacationDay:15,higherEducationRequirement:15,(intToStr(minAge)+'-'+intToStr(maxAge)):10,experience:10);
                      end;

                      dispose(firmElement.next);
                      firmElement.next:=firmElement.next.next;
                    end;






                writeln;
                writeln('Firm has beed deleted successfully');
              end else
                  begin
                    writeln;
                    writeln('Invalid input');
                  end;



            end else
                begin
                  writeln;
                  writeln('Invalid input, going to main menu');
                end;
          end else
              begin
                writeln('Nothing to delete!');
              end;










        end else
            begin
              writeln;
              writeln('Array is empty');
            end;


        rdyToExit:=true;
      end;
    2:
      begin

        if candidatesHead<>nil then
        begin

          writeln('Please input name of candidate to search for');
          readln(q);
          writeln;
          writeln('Search results:');
          writeln('ID':5,'NAME':15,'LAST-NAME':15,'MIDDLE-NAME':15,'BIRTHDAY':15,'H.EDU':10,'SPEC':20,'C.OBG':20,'MIN-SALARY':15);

          candidateElement:=candidatesHead;
          while candidateElement<>nil do
          begin
            if candidateElement.data.name=q then
            begin
              with candidateElement.data do
              begin
                setLength(candidateArray, length(candidateArray)+1);
                candidateArray[length(candidateArray)-1]:=candidateElement;
              end;

            end;

            candidateElement:=candidateElement.next;
          end;


          for i:=0 to length(candidateArray)-1 do
          begin
            with candidateArray[i].data do
            begin
              writeln(i+1:5,name:15,lastName:15,middleName:15,dateOfBirth:15,higherEducation:10,speciality:20,careerObjective:20,minSalary:15);
            end;
          end;


          if length(candidateArray)>0 then
          begin
            writeln;
            writeln('Please input ID of candidate to delete');
            readln(id);


            //--------------
            if (id>=1) and (id<=length(candidateArray)) then
            begin
                id:=candidateArray[id-1].data.id;

                check:=false;
                candidateElement:=candidatesHead;

                if candidateElement.data.id=id then
                begin
                  check:=true;
                end;


                while (candidateElement.next<>nil) and (check<>true) do
                begin
                  if candidateElement.next.data.id=id then
                  begin
                    check:=true;
                  end else
                      begin
                        candidateElement:=candidateElement.next;
                      end;
                end;



                if check=true then
                begin

                  if candidateElement=candidatesHead then
                  begin

                    if candidatesHead.next=nil then
                    begin
                      writeln;
                      writeln('Deleting candidate with ID = ',candidateElement.data.id);
                      writeln('ID':5,'NAME':15,'LAST-NAME':15,'MIDDLE-NAME':15,'BIRTHDAY':15,'H.EDU':10,'SPEC':20,'C.OBG':20,'MIN-SALARY':15);
                      with candidateElement.data do
                      begin
                        writeln(id:5,name:15,lastName:15,middleName:15,dateOfBirth:15,higherEducation:10,speciality:20,careerObjective:20,minSalary:15);
                      end;

                      dispose(candidatesHead.next);
                      candidatesHead:=nil;
                    end else
                          if id=candidatesHead.data.id then
                          begin
                            writeln;
                            writeln('Deleting candidate with ID = ',candidateElement.data.id);
                            writeln('ID':5,'NAME':15,'LAST-NAME':15,'MIDDLE-NAME':15,'BIRTHDAY':15,'H.EDU':10,'SPEC':20,'C.OBG':20,'MIN-SALARY':15);
                            with candidateElement.data do
                            begin
                              writeln(id:5,name:15,lastName:15,middleName:15,dateOfBirth:15,higherEducation:10,speciality:20,careerObjective:20,minSalary:15);
                            end;

                            dispose(candidatesHead);
                            candidatesHead:=candidatesHead.next;
                          end else
                                if id<>candidatesHead.data.id then
                                begin
                                  writeln;
                                  writeln('Deleting candidate with ID = ',candidateElement.next.data.id);
                                  writeln('ID':5,'NAME':15,'LAST-NAME':15,'MIDDLE-NAME':15,'BIRTHDAY':15,'H.EDU':10,'SPEC':20,'C.OBG':20,'MIN-SALARY':15);
                                  with candidateElement.next.data do
                                  begin
                                    writeln(id:5,name:15,lastName:15,middleName:15,dateOfBirth:15,higherEducation:10,speciality:20,careerObjective:20,minSalary:15);
                                  end;

                                  dispose(candidatesHead.next);
                                  candidatesHead.next:=candidatesHead.next.next;
                                end;




                  end else
                      begin
                        writeln;
                        writeln('Deleting candidate with ID = ',candidateElement.next.data.id);
                        writeln('ID':5,'NAME':15,'LAST-NAME':15,'MIDDLE-NAME':15,'BIRTHDAY':15,'H.EDU':10,'SPEC':20,'C.OBG':20,'MIN-SALARY':15);
                        with candidateElement.next.data do
                        begin
                          writeln(id:5,name:15,lastName:15,middleName:15,dateOfBirth:15,higherEducation:10,speciality:20,careerObjective:20,minSalary:15);
                        end;

                        dispose(candidateElement.next);
                        candidateElement.next:=candidateElement.next.next;
                      end;





                  writeln;
                  writeln('Candidate has beed deleted successfully');
                end else
                    begin
                      writeln;
                      writeln('Invalid input');
                    end;








            end else
                begin
                  writeln;
                  writeln('Invalid input, going to main menu');
                end;
          end else
              begin
                writeln('Nothing to delete!');
              end;










        end else
            begin
              writeln;
              writeln('Array is empty');
            end;


        rdyToExit:=true;
      end;
    3:
      begin
        writeln;
        writeln('Please input ID of firm to delete');
        readln(id);


        if firmHead<>nil then
        begin
          check:=false;
          firmElement:= firmHead;

          if firmElement.data.id=id then
          begin
            check:=true;
          end;


          while (firmElement.next<>nil) and (check<>true) do
          begin
            if firmElement.next.data.id=id then
            begin
              check:=true;
            end else
                begin
                  firmElement:=firmElement.next;
                end;
          end;


          if check=true then
          begin


            if firmElement=firmHead then
            begin

              if firmHead.next=nil then
              begin
                writeln;
                writeln('Deleting firm with ID = ',firmElement.data.id);
                writeln('ID':5,'TITLE':15,'VACANCY':20,'SALARY':10,'VACATION':15,'H.EDU':15,'AGE':10,'EXP':10);
                with firmElement.data do
                begin
                  writeln(id:5,title:15,vacancy:20,salary:10,amountOfVacationDay:15,higherEducationRequirement:15,(intToStr(minAge)+'-'+intToStr(maxAge)):10,experience:10);
                end;

                dispose(firmHead.next);
                firmHead:=nil;
              end else
                    if id=firmHead.data.id then
                    begin
                      writeln;
                      writeln('Deleting firm with ID = ',firmElement.data.id);
                      writeln('ID':5,'TITLE':15,'VACANCY':20,'SALARY':10,'VACATION':15,'H.EDU':15,'AGE':10,'EXP':10);
                      with firmElement.data do
                      begin
                        writeln(id:5,title:15,vacancy:20,salary:10,amountOfVacationDay:15,higherEducationRequirement:15,(intToStr(minAge)+'-'+intToStr(maxAge)):10,experience:10);
                      end;

                      dispose(firmHead);
                      firmHead:=firmHead.next;
                    end else
                          if id<>firmHead.data.id then
                          begin
                            writeln;
                            writeln('Deleting firm with ID = ',firmElement.next.data.id);
                            writeln('ID':5,'TITLE':15,'VACANCY':20,'SALARY':10,'VACATION':15,'H.EDU':15,'AGE':10,'EXP':10);
                            with firmElement.next.data do
                            begin
                              writeln(id:5,title:15,vacancy:20,salary:10,amountOfVacationDay:15,higherEducationRequirement:15,(intToStr(minAge)+'-'+intToStr(maxAge)):10,experience:10);
                            end;

                            dispose(firmHead.next);
                            firmHead.next:=firmHead.next.next;
                          end;




            end else
                begin
                  writeln;
                  writeln('Deleting firm with ID = ',firmElement.next.data.id);
                  writeln('ID':5,'TITLE':15,'VACANCY':20,'SALARY':10,'VACATION':15,'H.EDU':15,'AGE':10,'EXP':10);
                  with firmElement.next.data do
                  begin
                    writeln(id:5,title:15,vacancy:20,salary:10,amountOfVacationDay:15,higherEducationRequirement:15,(intToStr(minAge)+'-'+intToStr(maxAge)):10,experience:10);
                  end;

                  dispose(firmElement.next);
                  firmElement.next:=firmElement.next.next;
                end;






            writeln;
            writeln('Firm has beed deleted successfully');
          end else
              begin
                writeln;
                writeln('Invalid input');
              end;
        end else
            begin
              writeln;
              writeln('Array is empty');
            end;


        rdyToExit:=true;
      end;
    4:
      begin
        writeln;
        writeln('Please input ID of candidate to delete');
        readln(id);

        if candidatesHead<>nil then
        begin
          check:=false;
          candidateElement:=candidatesHead;

          if candidateElement.data.id=id then
          begin
            check:=true;
          end;


          while (candidateElement.next<>nil) and (check<>true) do
          begin
            if candidateElement.next.data.id=id then
            begin
              check:=true;
            end else
                begin
                  candidateElement:=candidateElement.next;
                end;
          end;



          if check=true then
          begin

            if candidateElement=candidatesHead then
            begin

              if candidatesHead.next=nil then
              begin
                writeln;
                writeln('Deleting candidate with ID = ',candidateElement.data.id);
                writeln('ID':5,'NAME':15,'LAST-NAME':15,'MIDDLE-NAME':15,'BIRTHDAY':15,'H.EDU':10,'SPEC':20,'C.OBG':20,'MIN-SALARY':15);
                with candidateElement.data do
                begin
                  writeln(id:5,name:15,lastName:15,middleName:15,dateOfBirth:15,higherEducation:10,speciality:20,careerObjective:20,minSalary:15);
                end;

                dispose(candidatesHead.next);
                candidatesHead:=nil;
              end else
                    if id=candidatesHead.data.id then
                    begin
                      writeln;
                      writeln('Deleting candidate with ID = ',candidateElement.data.id);
                      writeln('ID':5,'NAME':15,'LAST-NAME':15,'MIDDLE-NAME':15,'BIRTHDAY':15,'H.EDU':10,'SPEC':20,'C.OBG':20,'MIN-SALARY':15);
                      with candidateElement.data do
                      begin
                        writeln(id:5,name:15,lastName:15,middleName:15,dateOfBirth:15,higherEducation:10,speciality:20,careerObjective:20,minSalary:15);
                      end;

                      dispose(candidatesHead);
                      candidatesHead:=candidatesHead.next;
                    end else
                          if id<>candidatesHead.data.id then
                          begin
                            writeln;
                            writeln('Deleting candidate with ID = ',candidateElement.next.data.id);
                            writeln('ID':5,'NAME':15,'LAST-NAME':15,'MIDDLE-NAME':15,'BIRTHDAY':15,'H.EDU':10,'SPEC':20,'C.OBG':20,'MIN-SALARY':15);
                            with candidateElement.next.data do
                            begin
                              writeln(id:5,name:15,lastName:15,middleName:15,dateOfBirth:15,higherEducation:10,speciality:20,careerObjective:20,minSalary:15);
                            end;

                            dispose(candidatesHead.next);
                            candidatesHead.next:=candidatesHead.next.next;
                          end;




            end else
                begin
                  writeln;
                  writeln('Deleting candidate with ID = ',candidateElement.next.data.id);
                  writeln('ID':5,'NAME':15,'LAST-NAME':15,'MIDDLE-NAME':15,'BIRTHDAY':15,'H.EDU':10,'SPEC':20,'C.OBG':20,'MIN-SALARY':15);
                  with candidateElement.next.data do
                  begin
                    writeln(id:5,name:15,lastName:15,middleName:15,dateOfBirth:15,higherEducation:10,speciality:20,careerObjective:20,minSalary:15);
                  end;

                  dispose(candidateElement.next);
                  candidateElement.next:=candidateElement.next.next;
                end;





            writeln;
            writeln('Candidate has beed deleted successfully');
          end else
              begin
                writeln;
                writeln('Invalid input');
              end;
        end else
            begin
              writeln;
              writeln('Array is empty');
            end;

        rdyToExit:=true;
      end;
    5:
      begin
        if firmHead<>nil then
        begin
          writeln('Clearing firms!');

          while firmHead.next<>nil do
          begin
            dispose(firmHead.next);
            firmHead.next:=firmHead.next.next;
          end;
          dispose(firmHead.next);
          dispose(firmHead);

          firmHead:=nil;
        end else
            begin
              writeln;
              writeln('Array is empty');
            end;

        rdyToExit:=true;
      end;
     6:
      begin

        if candidatesHead<>nil then
        begin
          writeln('Clearing candidates!');

          while candidatesHead.next<>nil do
          begin
              dispose(candidatesHead.next);
              candidatesHead.next:=candidatesHead.next.next;
          end;
          dispose(candidatesHead.next);
          dispose(candidatesHead);

          candidatesHead:=nil;
        end else
            begin
              writeln;
              writeln('Array is empty');
            end;


        rdyToExit:=true;
      end;
    7:
      begin

        rdyToExit:=true;
      end;

    else
      begin
        writeln('Invalid input');
      end;
    end;
  end;

  writeln;
  writeln;
end;

//+
procedure editArray(var firmHead:TFirmListAdr; var candidatesHead:TCandidateListAdr);
var
  s, s1, i, id, c: integer;
  rdyToExit, rdyToExit1, menuIsShown1, check: Boolean;

  firmElement: TFirmListAdr;
  candidateElement: TCandidateListAdr;

  firmArray: TPFArray;
  candidateArray: TPCArray;

  q:String[15];
begin
  rdyToExit:=false;
  check:=false;

  writeln;
  writeln;
  writeln('--Edit Menu');
  writeln('1. Edit firm by title');
  writeln('2. Edit candidate by name');
  writeln;
  writeln('3. Edit firm by id');
  writeln('4. Edit candidate by id');
  writeln;
  writeln('5. Exit');
  writeln;

  while rdyToExit=false do
  begin
    write('->');
    readln(s);

    case s of
    1:
      begin
      if firmHead<>nil then
        begin

          writeln('Please input title of firm to search for');
          readln(q);
          writeln;
          writeln('Search results:');
          writeln('ID':5,'TITLE':15,'VACANCY':20,'SALARY':10,'VACATION':15,'H.EDU':15,'AGE':10,'EXP':10);


          firmElement:=firmHead;
          while firmElement<>nil do
          begin
            if firmElement.data.title=q then
            begin
              with firmElement.data do
              begin
                setLength(firmArray, length(firmArray)+1);
                firmArray[length(firmArray)-1]:=firmElement;
              end;

            end;

            firmElement:=firmElement.next;
          end;


          for i:=0 to length(firmArray)-1 do
          begin
            with firmArray[i].data do
            begin
              writeln(i+1:5,title:15,vacancy:20,salary:10,amountOfVacationDay:15,higherEducationRequirement:15,(intToStr(minAge)+'-'+intToStr(maxAge)):10,experience:10);
            end;
          end;


          if length(firmArray)>0 then
          begin
            writeln;
            writeln('Please input ID of firm to edit');
            readln(id);


            //---------------------
            if (id>=1) and (id<=length(firmArray)) then
            begin
              id:=firmArray[id-1].data.id;

              check:=false;
              firmElement:= firmHead;

              if firmElement.data.id=id then
              begin
                check:=true;
              end;


              while (firmElement.next<>nil) and (check<>true) do
              begin
                firmElement:=firmElement.next;

                if firmElement.data.id=id then
                begin
                  check:=true;
                end;

              end;


              if check=true then
              begin
                writeln;
                writeln('Editing firm with ID = ',firmElement.data.id);
                writeln('ID':5,'TITLE':15,'VACANCY':20,'SALARY':10,'VACATION':15,'H.EDU':15,'AGE':10,'EXP':10);
                with firmElement.data do
                begin
                  writeln(id:5,title:15,vacancy:20,salary:10,amountOfVacationDay:15,higherEducationRequirement:15,(intToStr(minAge)+'-'+intToStr(maxAge)):10,experience:10);
                end;




                rdyToExit1:=false;
                menuIsShown1:=false;
                while rdyToExit1=false do
                begin
                  if menuIsShown1=false then
                  begin
                    writeln;
                    writeln;
                    writeln('--What do you want to edit?');
                    writeln('1. Entire record');
                    writeln('2. Title');
                    writeln('3. Vacancy');
                    writeln('4. Salary');
                    writeln('5. Amount of vacation days');
                    writeln('6. Higher education requirement');
                    writeln('7. Age');
                    writeln('8. Experience');
                    writeln('9. Exit');
                    writeln;

                    menuIsShown1:=true;
                  end;


                  write('->');
                  readln(s1);
                  case s1 of
                  1:
                    begin
                      with firmElement.data do
                      begin

                        writeln('Please input firm title');
                        readln(title);

                        writeln('Please input vacancy');
                        readln(vacancy);

                        writeln('Please input future salary');
                        readln(salary);

                        writeln('Please input amount of vacation days');
                        readln(amountOfVacationDay);

                        writeln('Please input 1 if higher education is required');
                        readln(c);

                        if c=1 then
                        begin
                          higherEducationRequirement:=true;
                        end else
                            begin
                              higherEducationRequirement:=false;
                            end;


                        writeln('Please input min age');
                        readln(minAge);

                        writeln('Please input max age');
                        readln(maxAge);

                        writeln('Please required experience in years');
                        readln(experience);

                      end;

                      menuIsShown1:=false;
                    end;
                  2:
                    begin
                      with firmElement.data do
                      begin
                        writeln('Please input firm title');
                        readln(title);
                      end;

                      menuIsShown1:=false;
                    end;
                  3:
                    begin
                      with firmElement.data do
                      begin
                        writeln('Please input vacancy');
                        readln(vacancy);
                      end;

                      menuIsShown1:=false;
                    end;
                  4:
                    begin
                      with firmElement.data do
                      begin
                        writeln('Please input future salary');
                        readln(salary);
                      end;

                      menuIsShown1:=false;
                    end;
                  5:
                    begin
                      with firmElement.data do
                      begin
                        writeln('Please input amount of vacation days');
                        readln(amountOfVacationDay);
                      end;

                      menuIsShown1:=false;
                    end;
                  6:
                    begin
                      with firmElement.data do
                      begin
                        writeln('Please input 1 if higher education is required');
                        readln(c);

                        if c=1 then
                        begin
                          higherEducationRequirement:=true;
                        end else
                            begin
                              higherEducationRequirement:=false;
                            end;
                      end;
                      menuIsShown1:=false;
                    end;
                  7:
                    begin
                      with firmElement.data do
                      begin
                        writeln('Please input min age');
                        readln(minAge);

                        writeln('Please input max age');
                        readln(maxAge);
                      end;

                      menuIsShown1:=false;
                    end;
                  8:
                    begin
                      with firmElement.data do
                      begin
                        writeln('Please required experience in years');
                        readln(experience);
                      end;

                      menuIsShown1:=false;
                    end;
                  9:
                    begin
                      rdyToExit1:=true;
                      menuIsShown1:=false;
                    end
                  else
                    begin
                      writeln('Invalid input');
                    end;
                  end;
                end;



                writeln;
                writeln('Firm has beed edited successfully');
                writeln('ID':5,'TITLE':15,'VACANCY':20,'SALARY':10,'VACATION':15,'H.EDU':15,'AGE':10,'EXP':10);
                with firmElement.data do
                begin
                  writeln(id:5,title:15,vacancy:20,salary:10,amountOfVacationDay:15,higherEducationRequirement:15,(intToStr(minAge)+'-'+intToStr(maxAge)):10,experience:10);
                end;
              end else
                  begin
                    writeln;
                    writeln('Invalid input');
                  end;


            end else
                begin
                  writeln;
                  writeln('Invalid input, going to main menu');
                end;
          end else
              begin
                writeln('Nothing to delete!');
              end;










        end else
            begin
              writeln;
              writeln('Array is empty');
            end;



        rdyToExit:=true;
      end;
    2:
      begin
        if candidatesHead<>nil then
        begin

          writeln('Please input name of candidate to search for');
          readln(q);
          writeln;
          writeln('Search results:');
          writeln('ID':5,'NAME':15,'LAST-NAME':15,'MIDDLE-NAME':15,'BIRTHDAY':15,'H.EDU':10,'SPEC':20,'C.OBG':20,'MIN-SALARY':15);

          candidateElement:=candidatesHead;
          while candidateElement<>nil do
          begin
            if candidateElement.data.name=q then
            begin
              with candidateElement.data do
              begin
                setLength(candidateArray, length(candidateArray)+1);
                candidateArray[length(candidateArray)-1]:=candidateElement;
              end;

            end;

            candidateElement:=candidateElement.next;
          end;


          for i:=0 to length(candidateArray)-1 do
          begin
            with candidateArray[i].data do
            begin
              writeln(i+1:5,name:15,lastName:15,middleName:15,dateOfBirth:15,higherEducation:10,speciality:20,careerObjective:20,minSalary:15);
            end;
          end;


          if length(candidateArray)>0 then
          begin
            writeln;
            writeln('Please input ID of candidate to edit');
            readln(id);


            //--------------
            if (id>=1) and (id<=length(candidateArray)) then
            begin
              id:=candidateArray[id-1].data.id;

              check:=false;
              candidateElement:=candidatesHead;

              if candidateElement.data.id=id then
              begin
                check:=true;
              end;


              while (candidateElement.next<>nil) and (check<>true) do
              begin
                candidateElement:=candidateElement.next;

                if candidateElement.data.id=id then
                begin
                  check:=true;
                end;

              end;



              if check=true then
              begin
                writeln;
                writeln('Editing candidate with ID = ',candidateElement.data.id);
                writeln('ID':5,'NAME':15,'LAST-NAME':15,'MIDDLE-NAME':15,'BIRTHDAY':15,'H.EDU':10,'SPEC':20,'C.OBG':20,'MIN-SALARY':15);
                with candidateElement.data do
                begin
                  writeln(id:5,name:15,lastName:15,middleName:15,dateOfBirth:15,higherEducation:10,speciality:20,careerObjective:20,minSalary:15);
                end;


                rdyToExit1:=false;
                menuIsShown1:=false;
                while rdyToExit1=false do
                begin
                  if menuIsShown1=false then
                  begin
                    writeln;
                    writeln;
                    writeln('--What do you want to edit?');
                    writeln('1. Entire record');
                    writeln('2. Name');
                    writeln('3. Last name');
                    writeln('4. Middle name');
                    writeln('5. Date of birth');
                    writeln('6. Higher education');
                    writeln('7. Speciality');
                    writeln('8. Career objective');
                    writeln('9. Min salary');
                    writeln('10. Exit');
                    writeln;

                    menuIsShown1:=true;
                  end;


                  write('->');
                  readln(s1);
                  case s1 of
                  1:
                    begin
                      with candidateElement.data do
                      begin
                        writeln('Please input name');
                        readln(name);

                        writeln('Please input last name');
                        readln(lastName);

                        writeln('Please input middle name');
                        readln(middleName);

                        writeln('Please input date of birth (DD.MM.YYYY)');
                        readln(dateOfBirth);

                        writeln('Please input 1 if higher education is acquired');
                        readln(c);

                        if c=1 then
                        begin
                          higherEducation:=true;
                        end else
                            begin
                              higherEducation:=false;
                            end;

                        writeln('Please input speciality');
                        readln(speciality);

                        writeln('Please input wanted vacancy');
                        readln(careerObjective);

                        writeln('Please input min salary');
                        readln(minSalary);

                      end;

                      menuIsShown1:=false;
                    end;
                  2:
                    begin
                      with candidateElement.data do
                      begin
                        writeln('Please input name');
                        readln(name);

                      end;

                      menuIsShown1:=false;
                    end;
                  3:
                    begin
                      with candidateElement.data do
                      begin
                        writeln('Please input last name');
                        readln(lastName);

                      end;

                      menuIsShown1:=false;
                    end;
                  4:
                    begin
                      with candidateElement.data do
                      begin
                        writeln('Please input middle name');
                        readln(middleName);

                      end;

                      menuIsShown1:=false;
                    end;
                  5:
                    begin
                      with candidateElement.data do
                      begin
                        writeln('Please input date of birth (DD.MM.YYYY)');
                        readln(dateOfBirth);

                      end;

                      menuIsShown1:=false;
                    end;
                  6:
                    begin
                      with candidateElement.data do
                      begin
                        writeln('Please input 1 if higher education is acquired');
                        readln(c);

                        if c=1 then
                        begin
                          higherEducation:=true;
                        end else
                            begin
                              higherEducation:=false;
                            end;
                      end;

                      menuIsShown1:=false;
                    end;
                  7:
                    begin
                      with candidateElement.data do
                      begin
                        writeln('Please input speciality');
                        readln(speciality);

                      end;

                      menuIsShown1:=false;
                    end;
                  8:
                    begin
                      with candidateElement.data do
                      begin
                        writeln('Please input wanted vacancy');
                        readln(careerObjective);

                      end;

                      menuIsShown1:=false;
                    end;
                  9:
                    begin
                      with candidateElement.data do
                      begin
                        writeln('Please input min salary');
                        readln(minSalary);

                      end;

                      menuIsShown1:=false;
                    end;
                  10:
                    begin
                      rdyToExit1:=true;
                      menuIsShown1:=false;
                    end
                  else
                    begin
                      writeln('Invalid input');
                    end;
                  end;
                end;



                writeln;
                writeln('Candidate has beed edited successfully');
                writeln('ID':5,'NAME':15,'LAST-NAME':15,'MIDDLE-NAME':15,'BIRTHDAY':15,'H.EDU':10,'SPEC':20,'C.OBG':20,'MIN-SALARY':15);
                with candidateElement.data do
                begin
                  writeln(id:5,name:15,lastName:15,middleName:15,dateOfBirth:15,higherEducation:10,speciality:20,careerObjective:20,minSalary:15);
                end;
              end else
                  begin
                    writeln;
                    writeln('Invalid input');
                  end;

            end else
                begin
                  writeln;
                  writeln('Invalid input, going to main menu');
                end;
          end else
              begin
                writeln('Nothing to delete!');
              end;










        end else
            begin
              writeln;
              writeln('Array is empty');
            end;



        rdyToExit:=true;
      end;
    3:
      begin
        writeln;
        writeln('Please input ID of firm to edit');
        readln(id);

        if firmHead<>nil then
        begin
          check:=false;
          firmElement:= firmHead;

          if firmElement.data.id=id then
          begin
            check:=true;
          end;


          while (firmElement.next<>nil) and (check<>true) do
          begin
            firmElement:=firmElement.next;

            if firmElement.data.id=id then
            begin
              check:=true;
            end;

          end;


          if check=true then
          begin
            writeln;
            writeln('Editing firm with ID = ',firmElement.data.id);
            writeln('ID':5,'TITLE':15,'VACANCY':20,'SALARY':10,'VACATION':15,'H.EDU':15,'AGE':10,'EXP':10);
            with firmElement.data do
            begin
              writeln(id:5,title:15,vacancy:20,salary:10,amountOfVacationDay:15,higherEducationRequirement:15,(intToStr(minAge)+'-'+intToStr(maxAge)):10,experience:10);
            end;




            rdyToExit1:=false;
            menuIsShown1:=false;
            while rdyToExit1=false do
            begin
              if menuIsShown1=false then
              begin
                writeln;
                writeln;
                writeln('--What do you want to edit?');
                writeln('1. Entire record');
                writeln('2. Title');
                writeln('3. Vacancy');
                writeln('4. Salary');
                writeln('5. Amount of vacation days');
                writeln('6. Higher education requirement');
                writeln('7. Age');
                writeln('8. Experience');
                writeln('9. Exit');
                writeln;

                menuIsShown1:=true;
              end;


              write('->');
              readln(s1);
              case s1 of
              1:
                begin
                  with firmElement.data do
                  begin

                    writeln('Please input firm title');
                    readln(title);

                    writeln('Please input vacancy');
                    readln(vacancy);

                    writeln('Please input future salary');
                    readln(salary);

                    writeln('Please input amount of vacation days');
                    readln(amountOfVacationDay);

                    writeln('Please input 1 if higher education is required');
                    readln(c);

                    if c=1 then
                    begin
                      higherEducationRequirement:=true;
                    end else
                        begin
                          higherEducationRequirement:=false;
                        end;


                    writeln('Please input min age');
                    readln(minAge);

                    writeln('Please input max age');
                    readln(maxAge);

                    writeln('Please required experience in years');
                    readln(experience);

                  end;

                  menuIsShown1:=false;
                end;
              2:
                begin
                  with firmElement.data do
                  begin
                    writeln('Please input firm title');
                    readln(title);
                  end;

                  menuIsShown1:=false;
                end;
              3:
                begin
                  with firmElement.data do
                  begin
                    writeln('Please input vacancy');
                    readln(vacancy);
                  end;

                  menuIsShown1:=false;
                end;
              4:
                begin
                  with firmElement.data do
                  begin
                    writeln('Please input future salary');
                    readln(salary);
                  end;

                  menuIsShown1:=false;
                end;
              5:
                begin
                  with firmElement.data do
                  begin
                    writeln('Please input amount of vacation days');
                    readln(amountOfVacationDay);
                  end;

                  menuIsShown1:=false;
                end;
              6:
                begin
                  with firmElement.data do
                  begin
                    writeln('Please input 1 if higher education is required');
                    readln(c);

                    if c=1 then
                    begin
                      higherEducationRequirement:=true;
                    end else
                        begin
                          higherEducationRequirement:=false;
                        end;
                  end;
                  menuIsShown1:=false;
                end;
              7:
                begin
                  with firmElement.data do
                  begin
                    writeln('Please input min age');
                    readln(minAge);

                    writeln('Please input max age');
                    readln(maxAge);
                  end;

                  menuIsShown1:=false;
                end;
              8:
                begin
                  with firmElement.data do
                  begin
                    writeln('Please required experience in years');
                    readln(experience);
                  end;

                  menuIsShown1:=false;
                end;
              9:
                begin
                  rdyToExit1:=true;
                  menuIsShown1:=false;
                end
              else
                begin
                  writeln('Invalid input');
                end;
              end;
            end;



            writeln;
            writeln('Firm has beed edited successfully');
            writeln('ID':5,'TITLE':15,'VACANCY':20,'SALARY':10,'VACATION':15,'H.EDU':15,'AGE':10,'EXP':10);
            with firmElement.data do
            begin
              writeln(id:5,title:15,vacancy:20,salary:10,amountOfVacationDay:15,higherEducationRequirement:15,(intToStr(minAge)+'-'+intToStr(maxAge)):10,experience:10);
            end;
          end else
              begin
                writeln;
                writeln('Invalid input');
              end;
        end else
            begin
              writeln;
              writeln('Array is empty');
            end;


        rdyToExit:=true;
      end;
    4:
      begin
        writeln;
        writeln('Please input ID of candidate to edit');
        readln(id);

        if candidatesHead<>nil then
        begin
          check:=false;
          candidateElement:=candidatesHead;

          if candidateElement.data.id=id then
          begin
            check:=true;
          end;


          while (candidateElement.next<>nil) and (check<>true) do
          begin
            candidateElement:=candidateElement.next;

            if candidateElement.data.id=id then
            begin
              check:=true;
            end;

          end;



          if check=true then
          begin
            writeln;
            writeln('Editing candidate with ID = ',candidateElement.data.id);
            writeln('ID':5,'NAME':15,'LAST-NAME':15,'MIDDLE-NAME':15,'BIRTHDAY':15,'H.EDU':10,'SPEC':20,'C.OBG':20,'MIN-SALARY':15);
            with candidateElement.data do
            begin
              writeln(id:5,name:15,lastName:15,middleName:15,dateOfBirth:15,higherEducation:10,speciality:20,careerObjective:20,minSalary:15);
            end;


            rdyToExit1:=false;
            menuIsShown1:=false;
            while rdyToExit1=false do
            begin
              if menuIsShown1=false then
              begin
                writeln;
                writeln;
                writeln('--What do you want to edit?');
                writeln('1. Entire record');
                writeln('2. Name');
                writeln('3. Last name');
                writeln('4. Middle name');
                writeln('5. Date of birth');
                writeln('6. Higher education');
                writeln('7. Speciality');
                writeln('8. Career objective');
                writeln('9. Min salary');
                writeln('10. Exit');
                writeln;

                menuIsShown1:=true;
              end;


              write('->');
              readln(s1);
              case s1 of
              1:
                begin
                  with candidateElement.data do
                  begin
                    writeln('Please input name');
                    readln(name);

                    writeln('Please input last name');
                    readln(lastName);

                    writeln('Please input middle name');
                    readln(middleName);

                    writeln('Please input date of birth (DD.MM.YYYY)');
                    readln(dateOfBirth);

                    writeln('Please input 1 if higher education is acquired');
                    readln(c);

                    if c=1 then
                    begin
                      higherEducation:=true;
                    end else
                        begin
                          higherEducation:=false;
                        end;

                    writeln('Please input speciality');
                    readln(speciality);

                    writeln('Please input wanted vacancy');
                    readln(careerObjective);

                    writeln('Please input min salary');
                    readln(minSalary);

                  end;

                  menuIsShown1:=false;
                end;
              2:
                begin
                  with candidateElement.data do
                  begin
                    writeln('Please input name');
                    readln(name);

                  end;

                  menuIsShown1:=false;
                end;
              3:
                begin
                  with candidateElement.data do
                  begin
                    writeln('Please input last name');
                    readln(lastName);

                  end;

                  menuIsShown1:=false;
                end;
              4:
                begin
                  with candidateElement.data do
                  begin
                    writeln('Please input middle name');
                    readln(middleName);

                  end;

                  menuIsShown1:=false;
                end;
              5:
                begin
                  with candidateElement.data do
                  begin
                    writeln('Please input date of birth (DD.MM.YYYY)');
                    readln(dateOfBirth);

                  end;

                  menuIsShown1:=false;
                end;
              6:
                begin
                  with candidateElement.data do
                  begin
                    writeln('Please input 1 if higher education is acquired');
                    readln(c);

                    if c=1 then
                    begin
                      higherEducation:=true;
                    end else
                        begin
                          higherEducation:=false;
                        end;
                  end;

                  menuIsShown1:=false;
                end;
              7:
                begin
                  with candidateElement.data do
                  begin
                    writeln('Please input speciality');
                    readln(speciality);

                  end;

                  menuIsShown1:=false;
                end;
              8:
                begin
                  with candidateElement.data do
                  begin
                    writeln('Please input wanted vacancy');
                    readln(careerObjective);

                  end;

                  menuIsShown1:=false;
                end;
              9:
                begin
                  with candidateElement.data do
                  begin
                    writeln('Please input min salary');
                    readln(minSalary);

                  end;

                  menuIsShown1:=false;
                end;
              10:
                begin
                  rdyToExit1:=true;
                  menuIsShown1:=false;
                end
              else
                begin
                  writeln('Invalid input');
                end;
              end;
            end;



            writeln;
            writeln('Candidate has beed edited successfully');
            writeln('ID':5,'NAME':15,'LAST-NAME':15,'MIDDLE-NAME':15,'BIRTHDAY':15,'H.EDU':10,'SPEC':20,'C.OBG':20,'MIN-SALARY':15);
            with candidateElement.data do
            begin
              writeln(id:5,name:15,lastName:15,middleName:15,dateOfBirth:15,higherEducation:10,speciality:20,careerObjective:20,minSalary:15);
            end;
          end else
              begin
                writeln;
                writeln('Invalid input');
              end;
        end else
            begin
              writeln;
              writeln('Array is empty');
            end;


        rdyToExit:=true;
      end;
    5:
      begin

        rdyToExit:=true;
      end;

    else
      begin
        writeln('Invalid input');
      end;
    end;
  end;

  writeln;
  writeln;
end;

//+
procedure specialFuncs(firmHead:TFirmListAdr; candidatesHead:TCandidateListAdr);
var
  s, i, j, c, v, q: integer;
  rdyToExit, ageCheck, eduCheck, check: Boolean;

  f1name: String;
  f1: TextFile;

  firmElement,firmElement1: TFirmListAdr;
  candidateElement: TCandidateListAdr;
begin
  f1name:= 'A1.txt';

  assignFile(f1, f1name);

  rewrite(f1);

  rdyToExit:=false;

  writeln;
  writeln;
  writeln('--Special Functions Menu');
  writeln('1. Find candidates for firms');
  writeln('2. Show deficit specialities');
  writeln('3. Exit');
  writeln;

  while rdyToExit=false do
  begin
    write('->');
    readln(s);

    case s of
    1:
    begin
        firmElement:= firmHead;
        candidateElement:= candidatesHead;


        if (firmHead<>nil) and (candidatesHead<>nil) then
        begin
          while (firmElement<>nil) do
          begin
            writeln;
            writeln;
            writeln;
            writeln;
            writeln;
            writeln('----------------------------------------------------------------------------------------------------------------------------------');
            writeln('FIRM:');
            writeln('ID':5,'TITLE':15,'AGE':15,'VACATION':15,'EXP':15,'H.EDU':10,'VACANCY':40,'SALARY':15);


            writeln(f1);
            writeln(f1);
            writeln(f1);
            writeln(f1);
            writeln(f1);
            writeln(f1,'----------------------------------------------------------------------------------------------------------------------------------');
            writeln(f1,'FIRM:');
            writeln(f1,'ID':5,'TITLE':15,'AGE':15,'VACATION':15,'EXP':15,'H.EDU':10,'VACANCY':40,'SALARY':15);

            with firmElement.data do
            begin
              writeln(id:5,title:15,(intToStr(minAge)+'-'+intToStr(maxAge)):15,amountOfVacationDay:15,experience:15,higherEducationRequirement:10,vacancy:40,salary:15);
              writeln(f1, id:5,title:15,(intToStr(minAge)+'-'+intToStr(maxAge)):15,amountOfVacationDay:15,experience:15,higherEducationRequirement:10,vacancy:40,salary:15);
            end;
            writeln('----------------------------------------------------------------------------------------------------------------------------------');
            writeln;
            writeln('CANDIDATES:');
            writeln('ID':5,'NAME':15,'LAST-NAME':15,'MIDDLE-NAME':15,'BIRTHDAY':15,'H.EDU':10,'SPEC':20,'C.OBG':20,'MIN-SALARY':15);

            writeln(f1,'----------------------------------------------------------------------------------------------------------------------------------');
            writeln(f1);
            writeln(f1,'CANDIDATES:');
            writeln(f1,'ID':5,'NAME':15,'LAST-NAME':15,'MIDDLE-NAME':15,'BIRTHDAY':15,'H.EDU':10,'SPEC':20,'C.OBG':20,'MIN-SALARY':15);


              candidateElement:= candidatesHead;

              while (candidateElement<>nil) do
              begin
                if (length(candidateElement.data.dateOfBirth)=10) and (currentYear-StrToInt(candidateElement.data.dateOfBirth[7]+candidateElement.data.dateOfBirth[8]+candidateElement.data.dateOfBirth[9]+candidateElement.data.dateOfBirth[10])>=firmElement.data.minAge) and (currentYear-StrToInt(candidateElement.data.dateOfBirth[7]+candidateElement.data.dateOfBirth[8]+candidateElement.data.dateOfBirth[9]+candidateElement.data.dateOfBirth[10])<=firmElement.data.maxAge) then
                begin
                  ageCheck:=true;
                end else
                    begin
                      ageCheck:=false;
                    end;

                if firmElement.data.higherEducationRequirement = true then
                begin
                  if candidateElement.data.higherEducation = true then
                  begin
                    eduCheck:=true;
                  end else
                      begin
                        eduCheck:=false;
                      end;

                end else
                    begin
                      eduCheck:=true;
                    end;

                if ((firmElement.data.vacancy=candidateElement.data.speciality) or (firmElement.data.vacancy=candidateElement.data.careerObjective)) and (eduCheck) and (firmElement.data.salary >= candidateElement.data.minSalary) and (ageCheck) then
                begin
                  with candidateElement.data do
                  begin
                    writeln(id:5,name:15,lastName:15,middleName:15,dateOfBirth:15,higherEducation:10,speciality:20,careerObjective:20,minSalary:15);
                    writeln(f1,id:5,name:15,lastName:15,middleName:15,dateOfBirth:15,higherEducation:10,speciality:20,careerObjective:20,minSalary:15);

                  end;
                end;


                candidateElement:=candidateElement.next;
              end;



            writeln('----------------------------------------------------------------------------------------------------------------------------------');
            writeln(f1,'----------------------------------------------------------------------------------------------------------------------------------');

            firmElement:= firmElement.next;
          end;

        end else
            begin
              writeln('Array is empty');
            end;

        writeln;
        writeln;
        writeln;
        writeln;
        writeln('--Special Functions Menu');
        writeln('1. Find candidates for firms');
        writeln('2. Show deficit specialities');
        writeln('3. Exit');
        writeln;

        //rdyToExit:=true;
      end;
    2:
      begin
        firmElement:= firmHead;
        firmElement1:= firmHead;
        candidateElement:= candidatesHead;

        writeln(f1);
        writeln(f1);
        writeln(f1);
        writeln(f1);
        writeln('DEFICITE SPECIALITIES:');
        writeln(f1, 'DEFICITE SPECIALITIES:');
        if (firmHead<>nil) and (candidatesHead<>nil) then
        begin

          while (firmElement<>nil) do
          begin
            check:=true;
            firmElement1:=firmHead;
            candidateElement:= candidatesHead;


            if firmElement<>nil then
            begin
              while (firmElement1<>firmElement) do
              begin
                if firmElement.data.vacancy=firmElement1.data.vacancy then
                begin
                  check:=false;
                end;


                firmElement1:=firmElement1.next;
              end;
            end;


            if (check=true) then
            begin
              c:=0;
              v:=0;


              while (firmElement1<>nil) do
              begin
                if firmElement.data.vacancy=firmElement1.data.vacancy then
                begin
                  v:=v+1;
                end;

                firmElement1:=firmElement1.next;
              end;

              //writeln('v - ',v);

              while (candidateElement<>nil) do
              begin
                if firmElement.data.vacancy=candidateElement.data.speciality then
                begin
                  c:=c+1;
                end;

                candidateElement:=candidateElement.next;
              end;

              if (c/v)<=0.1 then
              begin
                //write (firmElement.data.id, '  ');
                writeln(firmElement.data.vacancy);
                writeln(f1,firmElement.data.vacancy);
              end;
            end;

            firmElement:=firmElement.next;
          end;

        end else
            begin
              writeln('Array is empty!');
            end;


        writeln;
        writeln;
        writeln;
        writeln;
        writeln('--Special Functions Menu');
        writeln('1. Find candidates for firms');
        writeln('2. Show deficit specialities');
        writeln('3. Exit');
        writeln;
        //rdyToExit:=true;
      end;
    3:
      begin

        rdyToExit:=true;
      end;

    else
      begin
        writeln('Invalid input');
      end;
    end;
  end;


  closeFile(f1);
  writeln;
  writeln;
end;








//-----------------MAIN_MENU-----------------

function createMenu(var firmFile: TFirmFile; var candidateFile: TCandidateFile):Integer;
var
  i, s: integer;

//  firmArray: TFirmArray;
//  candidateArray: TCandidateArray;

  firmListHead: TFirmListAdr;
  candidateListHead: TCandidateListAdr;

  firmElement: TFirmListAdr;
  candidateElement: TCandidateListAdr;

  rdyToExit: Boolean;
  menuIsShown: Boolean;
begin
  rdyToExit:=false;
  menuIsShown:=false;


  firmListHead:=nil;
  candidateListHead:=nil;


  while rdyToExit=false do
  begin
    if menuIsShown=false then
    begin
      writeln;
      writeln;
      writeln('--Main Menu');
      writeln('1. Read from file');
      writeln('2. Output array');
      writeln('3. Sort array');
      writeln('4. Search in array');
      writeln('5. Add to array');
      writeln('6. Remove from array');
      writeln('7. Edit data');
      writeln('8. Special functions');
      writeln('9. Exit without saving');
      writeln('10. Save and exit');
      writeln;

      menuIsShown:=true;
    end;


    write('->');
    readln(s);
    case s of
    1:
      begin
        //+
        menuIsShown:=false;
        readFromFiles(firmFile, firmListHead, candidateFile, candidateListHead);
      end;
    2:
      begin
        menuIsShown:=false;
        outputArray(firmListHead, candidateListHead);
      end;
    3:
      begin
        menuIsShown:=false;
        sortArray(firmListHead, candidateListHead);
      end;
    4:
      begin
        menuIsShown:=false;
        searchInArray(firmListHead, candidateListHead);
      end;
    5:
      begin
        menuIsShown:=false;
        addToArray(firmListHead, candidateListHead);
      end;
    6:
      begin
        menuIsShown:=false;
        removeFromArray(firmListHead, candidateListHead);
      end;
    7:
      begin
        menuIsShown:=false;
        editArray(firmListHead, candidateListHead);
      end;
    8:
      begin
        menuIsShown:=false;
        specialFuncs(firmListHead, candidateListHead);
      end;
    9:
      begin
        menuIsShown:=false;
        writeln;

        closeFile(firmFile);
        closeFile(candidateFile);



        if firmListHead<>nil then
        begin
          writeln('Clearing firms!');

          while firmListHead.next<>nil do
          begin
            dispose(firmListHead.next);
            firmListHead.next:=firmListHead.next.next;
          end;
          dispose(firmListHead.next);
          dispose(firmListHead);

          firmListHead:=nil;
        end else
            begin
              writeln;
              writeln('Array is empty');
            end;


        if candidateListHead<>nil then
        begin
          writeln('Clearing candidates!');

          while candidateListHead.next<>nil do
          begin
            dispose(candidateListHead.next);
            candidateListHead.next:=candidateListHead.next.next;
          end;
          dispose(candidateListHead.next);
          dispose(candidateListHead);

          candidateListHead:=nil;
        end else
            begin
              writeln;
              writeln('Array is empty');
            end;


        rdyToExit:=true;
      end;
    10:
      begin
        firmElement:= firmListHead;
        candidateElement:= candidateListHead;
        rewrite(firmFile);
        rewrite(candidateFile);

        
        writeln('Saved');
        if firmListHead<>nil then
        begin
          

          while firmElement<>nil do
          begin
            write(firmFile, firmElement.data);
            firmElement:=firmElement.next;
          end;

        end;

        if candidateListHead<>nil then
        begin
          

          while candidateElement<>nil do
          begin
            write(candidateFile, candidateElement.data);
            candidateElement:=candidateElement.next;
          end;
        end;


        menuIsShown:=false;
        writeln;

        closeFile(firmFile);
        closeFile(candidateFile);




        if firmListHead<>nil then
        begin
          writeln('Clearing firms!');

          while firmListHead.next<>nil do
          begin
            dispose(firmListHead.next);
            firmListHead.next:=firmListHead.next.next;
          end;
          dispose(firmListHead.next);
          dispose(firmListHead);

          firmListHead:=nil;
        end else
            begin
              writeln;
              writeln('Array is empty');
            end;


        if candidateListHead<>nil then
        begin
          writeln('Clearing candidates!');

          while candidateListHead.next<>nil do
          begin
            dispose(candidateListHead.next);
            candidateListHead.next:=candidateListHead.next.next;
          end;
          dispose(candidateListHead.next);
          dispose(candidateListHead);

          candidateListHead:=nil;
        end else
            begin
              writeln;
              writeln('Array is empty');
            end;


        rdyToExit:=true;
      end;

    else
      begin
        writeln('Invalid input');
      end;
    end;
  end;


  createMenu:=s;
end;











//----------MAIN----------
var
  q: integer;
  issueWithFiles, rdyToExit: Boolean;
  firmFileName: String;
  candidateFileName: String;

  firmFile: TFirmFile;
  candidateFile: TCandidateFile;
begin

  firmFileName:= 'FirmsAndVacancies.txt';
  candidateFileName:= 'Candidates.txt';


  issueWithFiles:=true;
  rdyToExit:=false;

  while rdyToExit=false do
  begin
    if fileExists(firmFileName) then
    begin
      assignFile(firmFile, firmFileName);
      reset(firmFile);
      writeln('Opened ', firmFileName);
      issueWithFiles:=false;
      rdyToExit:=true;
    end else
        begin
          writeln('File ''', firmFileName,''' don''t exist!');
          writeln('Fix:');
          writeln('1. Create new file');
          writeln('2. Change path');
          writeln('3. Exit');
          readln(q);

          case q of
          1:
            begin
              assignFile(firmFile, firmFileName);
              rewrite(firmFile);
              writeln('->File ''', firmFileName,''' has been created!');
              issueWithFiles:=false;
            end;
          2:
            begin
              writeln('Please input new path');
              readln(firmFileName);
              assignFile(firmFile, firmFileName);
              writeln;
            end;
          3:
            begin
              issueWithFiles:=false;
              rdyToExit:=true;
            end;
          end;

          writeln;
        end;
  end;



  rdyToExit:=false;

  while rdyToExit=false do
  begin
    if (fileExists(candidateFileName)) then
    begin
      assignFile(candidateFile, candidateFileName);
      reset(candidateFile);
      writeln('Opened ', candidateFileName);
      issueWithFiles:=false;
      rdyToExit:=true;
    end else
        begin
          issueWithFiles:=true;

          writeln('File ''', candidateFileName,''' don''t exist!');
          writeln('Fix:');
          writeln('1. Create new file');
          writeln('2. Change path');
          writeln('3. Exit');
          readln(q);


          case q of
          1:
            begin
              assignFile(candidateFile, candidateFileName);
              rewrite(candidateFile);
              writeln('->File ''', candidateFileName,''' has been created!');
              issueWithFiles:=false;
            end;
          2:
            begin
              writeln('Please input new path');
              readln(candidateFileName);
              assignFile(candidateFile, candidateFileName);
              writeln;
            end;
          3:
            begin
              rdyToExit:=true;
            end;
          end;


        end;
  end;

  q:=-1;

  if issueWithFiles=false then
  begin
    writeln;
    writeln('--------------------------------------------');
    q:=createMenu(firmFile, candidateFile);
  end else
      begin
        writeln;
        writeln;
        writeln('ERROR accessing files, press <Enter> to exit');
      end;


  writeln;
  writeln('Exit code: ', q);


  //AUTO-DELETE-FILES
//  writeln;
//  writeln('AUTO-DELETE INITIATED');
//  if fileExists(candidateFileName) then
//  begin
//    closeFile(candidateFile);
//    writeln(deletefile(candidateFileName),' ',candidateFileName);
//  end;
//
//  if fileExists(firmFileName) then
//  begin
//    closeFile(firmFile);
//    writeln(deletefile(firmFileName),' ',firmFileName);
//  end;
  //

  writeln;
  writeln;
  writeln('Press <Enter> to exit');


  readln;
end.
