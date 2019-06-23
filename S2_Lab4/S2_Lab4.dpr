program S2_Lab4;

uses
  Vcl.Forms,
  WeightUnit in 'WeightUnit.pas' {MainFormW},
  GuitarUnit in 'GuitarUnit.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainFormW, MainFormW);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
