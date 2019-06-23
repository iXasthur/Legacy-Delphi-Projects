unit WeightUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, GuitarUnit;

type
  TMainFormW = class(TForm)
    AnimationTimer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure AnimationTimerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;





type
  TStonePointArray = array[0..3] of TPoint;
  TCloudPointArray = array[0..3] of TPoint;
  TTreePointArray = array[0..6] of TPoint;
  TYStonesArray = array of integer;

const
  stoneAmount = 20;
  stoneSizeD = 1;
  stoneSizeIM = 10;

var
  MainFormW: TMainFormW;


implementation

{$R *.dfm}

procedure drawGrass(F: TForm);
var
  x,y,i,s,h:integer;
begin
  i:=0;

  with F do
    begin
    Canvas.Pen.Color:=clGreen;

    Canvas.MoveTo(0,height - (height div 3));
    x := Canvas.PenPos.x;
    while x<width do
    begin
      case i of
        0:
          begin
            s:=height div 500;
            h:=height div 110;
          end;
        1:
          begin
            s:=-(height div 70);
            h:=height div 130;
          end;
        2:
          begin
            s:=height div 100;
            h:=height div 140;
          end;
        3:
          begin
            s:=-(height div 300);
            h:=height div 90;

            i:=-1;
          end;
      end;

      Canvas.MoveTo(x,height - (height div 3));
      y:=canvas.PenPos.Y;

      canvas.LineTo(x+s,y-h);
      canvas.LineTo(x,y-h*2);
      inc(x,height div 300);
      inc(i);
    end;
  end;


end;


procedure drawGround(F: TForm);
var
  x,y:integer;
begin
  with F do
  begin
    Canvas.Brush.Color := clMoneyGreen;
    Canvas.FillRect(Rect(0,height - (height div 3),Width,Height));
  end;

end;


procedure drawUndergroundStones(F: TForm; yStone:TYStonesArray;p:TStonePointArray;x:integer);
var
  i,y: integer;
begin
  i:=0;

  with F do
  begin
      while x < width - canvas.PenPos.X do
      begin
        y:=yStone[i] + canvas.PenPos.Y;

        p[0]:=Point(x,y);
        p[1]:=Point(p[0].x - (height div (50*stoneSizeD)),p[0].y + (height div (125*stoneSizeD)));
        p[2]:=Point(p[1].x - (height div (75*stoneSizeD)),p[1].y + (height div (50*stoneSizeD)));
        p[3]:=Point(p[2].x + (height div (25*stoneSizeD)),p[2].y);


        Canvas.Polygon(p);
        x:=x + (width div stoneAmount);
        inc(i);
      end;
  end;
end;


procedure drawMountain(F: TForm; p:TStonePointArray;x:integer);
begin
  with F do
  begin
        p[0]:=Point(x,canvas.PenPos.Y - height div 125*stoneSizeIM - height div 50*stoneSizeIM);
        p[1]:=Point(p[0].x + (height div 50*stoneSizeIM),p[0].y + (height div 125*stoneSizeIM));
        p[2]:=Point(p[1].x + (height div 75*stoneSizeIM),p[1].y + (height div 50*stoneSizeIM));
        p[3]:=Point(p[2].x - (height div 25*stoneSizeIM),p[2].y);


        Canvas.Polygon(p);
  end;
end;


procedure drawStones(F: TForm; yStone:TYStonesArray);
var
  i,x,y:integer;
  p: TStonePointArray;
begin
  i:=0;

  with F do
  begin
//    Canvas.Pen.Color := clGray;
    Canvas.Brush.Color := clMedGray;
    Canvas.MoveTo(width div stoneAmount,height - (height div 3));
    x:=canvas.PenPos.X;


    drawUndergroundStones(F,yStone,p,x);
    x:=round(x/2);
    drawMountain(F,p,x);
  end;

end;


procedure drawClouds(F: TForm; xCloud:integer; p:TCloudPointArray);
var
  i:integer;
  pScr:TCloudPointArray;
begin
  with F do
  begin

    //Cloud 1
    Canvas.MoveTo(xCloud - 200,height div 10);
    for i:=0 to 3 do
    begin
      pScr[i].X:=canvas.PenPos.X + p[i].X;
      pScr[i].Y:=canvas.PenPos.Y + p[i].Y;
    end;

    Canvas.Polygon(pScr);

    //Cloud 2
    Canvas.MoveTo(width - 200 - xCloud,height div 5);
    for i:=0 to 3 do
    begin
      pScr[i].X:=canvas.PenPos.X + p[i].X;
      pScr[i].Y:=canvas.PenPos.Y + p[i].Y;
    end;

    Canvas.Polygon(pScr);

    //Cloud 3
    Canvas.MoveTo(round(xCloud*4/3),height div 3 - 50);
    for i:=0 to 3 do
    begin
      pScr[i].X:=canvas.PenPos.X + p[i].X;
      pScr[i].Y:=canvas.PenPos.Y + p[i].Y;
    end;

    Canvas.Polygon(pScr);

    end;
end;


procedure drawTree(F:TForm);
var
  pT: TTreePointArray;
  pL,pH: TPoint;
begin
  with F do
  begin
    canvas.Pen.Color:=clWebTan;
    canvas.Brush.Color:=clWebTan;
    pL:=point(width - width div 7, height - height div 3);
    pH:=point(pL.X, pL.Y - height div 15);
    canvas.Rectangle(pL.x - height div 40 ,pL.y,pH.x + height div 40,pH.y);

    canvas.Pen.Color:=clWebPink;
    canvas.Brush.Color:=clWebPink;
    pT[0].X:=pH.X - height div 11;
    pT[0].Y:=pH.Y;
    pT[1].X:=pH.X + height div 11;
    pT[1].Y:=pH.Y;

    pT[2].X:=pH.X + height div 27;
    pT[2].Y:=pT[1].Y - height div 12;
    pT[3].X:=pH.X + height div 12;
    pT[3].Y:=pT[2].Y;

    pT[4].X:=pH.X;
    pT[4].Y:=pT[3].Y - height div 9;

    pT[5].X:=pH.X - height div 12;
    pT[5].Y:=pT[2].Y;
    pT[6].X:=pH.X - height div 27;
    pT[6].Y:=pT[1].Y - height div 12;
    canvas.Polygon(pT);
  end;

end;


function DrawSitDownMan(F:TForm;x0,y0,manH,manW:Integer;var N:Integer):Integer;
begin
    DrawSitDownMan:=1;

    with F.Canvas do
    begin
      // Left foot
      MoveTo(x0 - Round(manW*0.4), y0);
      LineTo(x0 - Round(manW*0.3), y0);

      // Left leg
      LineTo(x0 - Round(manW*0.3), y0 - Round(manH*0.2));
      LineTo(x0, y0 - Round(manH*0.4) + Round(manH*0.01)*N);

      // Right foot
      MoveTo(x0 + Round(manW*0.4), y0);
      LineTo(x0 + Round(manW*0.3), y0);

      // Right leg
      LineTo(x0 + Round(manW*0.3), y0 - Round(manH*0.2));
      LineTo(x0, y0 - Round(manH*0.4) + Round(manH*0.01)*N);

      // Body
      LineTo(x0, y0 - Round(manH*0.8) + Round(manH*0.05)*N);

      // Head
      Ellipse(x0 - Round(manW*0.2), y0 - Round(manH*0.8) + Round(manH*0.05)*N - 2*Round(manW*0.2), x0 + Round(manW*0.2), y0 - Round(manH*0.8) + Round(manH*0.05)*N);

      // Left arm
      MoveTo(x0, y0 - Round(manH*0.8) + Round(manH*0.05)*N + Round(manH*0.08));
      LineTo(x0 - Round(ManW*0.5), y0 - Round(manH*0.5) + Round(manH*0.05)*N);
      LineTo(x0 - Round(ManW*0.5), y0 - Round(manH*0.3) + Round(manH*0.05)*N);

      // Right arm
      MoveTo(x0, y0 - Round(manH*0.8) + Round(manH*0.05)*N + Round(manH*0.08));
      LineTo(x0 + Round(ManW*0.5), y0 - Round(manH*0.5) + Round(manH*0.05)*N);
      LineTo(x0 + Round(ManW*0.5), y0 - Round(manH*0.3) + Round(manH*0.05)*N);

      // Barbell
      Pen.Color := clBlack;
      MoveTo(x0 - Round(manW*0.7), y0);
      LineTo(x0 + Round(manW*0.7), y0);

      // Weight
      Rectangle(x0 - manW, y0 - Round(manW*0.3), x0 - Round(manW*0.7), y0 + Round(manW*0.3));
      Rectangle(x0 + manW, y0 - Round(manW*0.3), x0 + Round(manW*0.7), y0 + Round(manW*0.3));
    end;

    if y0 - Round(manH*0.3) + Round(manH*0.05)*N < y0 then
    begin
      Inc(N)
    end else
        begin
          DrawSitDownMan:=2;
        end;
end;


function DrawStandUpMan(F:TForm;x0,y0,manH,manW:Integer;K:Integer; var N:Integer):Integer;
begin
    DrawStandUpMan:=2;

    with F.Canvas do
    begin
      // Left foot
      MoveTo(x0 - Round(manW*0.4), y0);
      LineTo(x0 - Round(manW*0.3), y0);

      // Left leg
      LineTo(x0 - Round(manW*0.3), y0 - Round(manH*0.2));
      LineTo(x0, y0 - Round(manH*0.4) + Round(manH*0.01)*N);

      // Right foot
      MoveTo(x0 + Round(manW*0.4), y0);
      LineTo(x0 + Round(manW*0.3), y0);

      // Right leg
      LineTo(x0 + Round(manW*0.3), y0 - Round(manH*0.2));
      LineTo(x0, y0 - Round(manH*0.4) + Round(manH*0.01)*N);

      // Body
      LineTo(x0, y0 - Round(manH*0.8) + Round(manH*0.05)*N);

      // Head
      Ellipse(x0 - Round(manW*0.2), y0 - Round(manH*0.8) + Round(manH*0.05)*N - 2*Round(manW*0.2), x0 + Round(manW*0.2), y0 - Round(manH*0.8) + Round(manH*0.05)*N);

      // Left arm
      MoveTo(x0, y0 - Round(manH*0.8) + Round(manH*0.05)*N + Round(manH*0.08));
      LineTo(x0 - Round(ManW*0.5), y0 - Round(manH*0.5) + Round(manH*0.05)*N);
      LineTo(x0 - Round(ManW*0.5), y0 - Round(manH*0.3) + Round(manH*0.05)*N);

      // Right arm
      MoveTo(x0, y0 - Round(manH*0.8) + Round(manH*0.05)*N + Round(manH*0.08));
      LineTo(x0 + Round(ManW*0.5), y0 - Round(manH*0.5) + Round(manH*0.05)*N);
      LineTo(x0 + Round(ManW*0.5), y0 - Round(manH*0.3) + Round(manH*0.05)*N);

      // Barbell
      Pen.Color := clBlack;
      MoveTo(x0 - Round(manW*0.7), y0 - Round(manH*0.05)*(K - N));
      LineTo(x0 + Round(manW*0.7), y0 - Round(manH*0.05)*(K - N));

      // Weight
      Rectangle(x0 - manW, y0 - Round(manW*0.3) - Round(manH*0.05)*(K - N), x0 - Round(manW*0.7), y0 + Round(manW*0.3) - Round(manH*0.05)*(K - N));
      Rectangle(x0 + manW, y0 - Round(manW*0.3) - Round(manH*0.05)*(K - N), x0 + Round(manW*0.7), y0 + Round(manW*0.3) - Round(manH*0.05)*(K - N));
    end;

  if N > 0 then
  begin
    Dec(N)
  end else
      begin
        N := 1;
        DrawStandUpMan:=3;
      end;
end;


function DrawWeightUp(F:TForm;x0,y0,manH,manW:Integer;K:Integer; var N:Integer):Integer;
begin
    DrawWeightUp:=3;

    with F.Canvas do
    begin
      // Left foot
      MoveTo(x0 - Round(manW*0.4), y0);
      LineTo(x0 - Round(manW*0.3), y0);

      // Left leg
      LineTo(x0 - Round(manW*0.3), y0 - Round(manH*0.2));
      LineTo(x0, y0 - Round(manH*0.4));

      // Right foot
      MoveTo(x0 + Round(manW*0.4), y0);
      LineTo(x0 + Round(manW*0.3), y0);

      // Right leg
      LineTo(x0 + Round(manW*0.3), y0 - Round(manH*0.2));
      LineTo(x0, y0 - Round(manH*0.4));

      // Body
      LineTo(x0, y0 - Round(manH*0.8));

      // Head
      Ellipse(x0 - Round(manW*0.2), y0 - Round(manH*0.8) - 2*Round(manW*0.2), x0 + Round(manW*0.2), y0 - Round(manH*0.8));

      // Left arm
      MoveTo(x0, y0 - Round(manH*0.8) + Round(manH*0.08));
      LineTo(x0 - Round(ManW*0.5), y0 - Round(manH*0.5) - Round(manH*0.05)*N);
      LineTo(x0 - Round(ManW*0.5), y0 - Round(manH*0.3) - Round(manH*0.09)*N);

      // Right arm
      MoveTo(x0, y0 - Round(manH*0.8) + Round(manH*0.08));
      LineTo(x0 + Round(ManW*0.5), y0 - Round(manH*0.5) - Round(manH*0.05)*N);
      LineTo(x0 + Round(ManW*0.5), y0 - Round(manH*0.3) - Round(manH*0.09)*N);

      // Barbell
      Pen.Color := clBlack;
      MoveTo(x0 - Round(manW*0.7), y0 - Round(manH*0.05)*K - Round(manH*0.085)*N);
      LineTo(x0 + Round(manW*0.7), y0 - Round(manH*0.05)*K - Round(manH*0.085)*N);

      // Weight
      Rectangle(x0 - manW, y0 - Round(manW*0.3) - Round(manH*0.05)*(K) - Round(manH*0.085)*N, x0 - Round(manW*0.7), y0 + Round(manW*0.3) - Round(manH*0.05)*(K) - Round(manH*0.085)*N);
      Rectangle(x0 + manW, y0 - Round(manW*0.3) - Round(manH*0.05)*(K) - Round(manH*0.085)*N, x0 + Round(manW*0.7), y0 + Round(manW*0.3) - Round(manH*0.05)*(K) - Round(manH*0.085)*N);
    end;

  if N < 10 then
  begin
    Inc(N)
  end else
      begin
        DrawWeightUp:=4;
      end;
end;


function DrawWeightDown(F:TForm;x0,y0,manH,manW:Integer;K:Integer; var N:Integer):Integer;
begin
    DrawWeightDown:=4;

    with F.Canvas do
    begin
      // Left foot
      MoveTo(x0 - Round(manW*0.4), y0);
      LineTo(x0 - Round(manW*0.3), y0);

      // Left leg
      LineTo(x0 - Round(manW*0.3), y0 - Round(manH*0.2));
      LineTo(x0, y0 - Round(manH*0.4));

      // Right foot
      MoveTo(x0 + Round(manW*0.4), y0);
      LineTo(x0 + Round(manW*0.3), y0);

      // Right leg
      LineTo(x0 + Round(manW*0.3), y0 - Round(manH*0.2));
      LineTo(x0, y0 - Round(manH*0.4));

      // Body
      LineTo(x0, y0 - Round(manH*0.8));

      // Head
      Ellipse(x0 - Round(manW*0.2), y0 - Round(manH*0.8) - 2*Round(manW*0.2), x0 + Round(manW*0.2), y0 - Round(manH*0.8));

      // Left arm
      MoveTo(x0, y0 - Round(manH*0.8) + Round(manH*0.08));
      LineTo(x0 - Round(ManW*0.5), y0 - Round(manH*0.5) - Round(manH*0.05)*N);
      LineTo(x0 - Round(ManW*0.5), y0 - Round(manH*0.3) - Round(manH*0.09)*N);

      // RIght arm
      MoveTo(x0, y0 - Round(manH*0.8) + Round(manH*0.08));
      LineTo(x0 + Round(ManW*0.5), y0 - Round(manH*0.5) - Round(manH*0.05)*N);
      LineTo(x0 + Round(ManW*0.5), y0 - Round(manH*0.3) - Round(manH*0.09)*N);

      // Barbell
      Pen.Color := clBlack;
      MoveTo(x0 - Round(manW*0.7), y0 - Round(manH*0.05)*K - Round(manH*0.085)*N);
      LineTo(x0 + Round(manW*0.7), y0 - Round(manH*0.05)*K - Round(manH*0.085)*N);

      // Weight
      Rectangle(x0 - manW, y0 - Round(manW*0.3) - Round(manH*0.05)*(K) - Round(manH*0.085)*N, x0 - Round(manW*0.7), y0 + Round(manW*0.3) - Round(manH*0.05)*(K) - Round(manH*0.085)*N);
      Rectangle(x0 + manW, y0 - Round(manW*0.3) - Round(manH*0.05)*(K) - Round(manH*0.085)*N, x0 + Round(manW*0.7), y0 + Round(manW*0.3) - Round(manH*0.05)*(K) - Round(manH*0.085)*N);
    end;

  if N > 0 then
  begin
    Dec(N)
  end else
      begin
        DrawWeightDown:=3;
      end;
end;


procedure drawCloudsMain(F:TForm;var xCloud:integer; p:TCloudPointArray);
begin
  with F do
  begin
    Canvas.Brush.Color:=clTeal;
    Canvas.Pen.Color:=clTeal;

    drawClouds(F,xCloud,p);

    if xCloud<(width+p[1].X + 100) then
    begin
      inc(xCloud);
    end else
        begin
          xCloud:=-200;
        end;
  end;
end;


procedure drawScore(F:TForm; manW,manH,score:integer);
begin
  with F do
  begin
    Canvas.Brush.Color:=clCream;
    Canvas.TextOut(width div 2 + manW div 2 + width div 20,height div 2 - height div 20,IntToStr(score));
  end;
end;


procedure drawGuitarMan(F:TForm; x,y:Integer);
var
  rad:Integer;
begin
  rad:=(F.Height) div 34;
  guitarUnit.MenStatic(F,x,y,rad);
  guitarUnit.Guitar(F,x,y,rad);
  guitarUnit.LeftHand(F,x,y,rad);
  guitarUnit.RightHand(F,x,y,rad);
  guitarUnit.HeadAndNeck(F,x,y,rad);
end;


procedure drawMan(F:TForm; var ManDrawLoop,N,K,score:Integer; manX,manY,manH,manW:Integer);
begin
  case ManDrawLoop of
    1:
      begin
        F.Canvas.Pen.Color := clRed;
        F.Canvas.Brush.Color:= clCream;
        ManDrawLoop:=DrawSitDownMan(F,manX,manY,manH,manW,N);
        K:=N;
      end;
    2:
      begin
        F.Canvas.Pen.Color := clRed;
        F.Canvas.Brush.Color:= clCream;
        ManDrawLoop:=DrawStandUpMan(F,manX,manY,manH,manW,K,N);
      end;
    3:
      begin
        F.Canvas.Pen.Color := clRed;
        F.Canvas.Brush.Color:= clCream;
        ManDrawLoop:=DrawWeightUp(F,manX,manY,manH,manW,K,N);

        if ManDrawLoop=4 then
        begin
          score:=score+1;
        end;
      end;
    4:
      begin
        F.Canvas.Pen.Color := clRed;
        F.Canvas.Brush.Color:= clCream;
        ManDrawLoop:=DrawWeightDown(F,manX,manY,manH,manW,K,N);
      end;
  end;
end;





//-----MAIN-----
var
  i, xCloud, K, manDrawLoop, manX, manY, manH, manW, N, score, gManX,gManY:Integer;
  ManSize: Real;
  p:TCloudPointArray;
  yStone: TYStonesArray;


procedure TMainFormW.FormCreate(Sender: TObject);
begin
  randomize;
  self.DoubleBuffered:=true;
  Self.Color:=clCream;

  Canvas.Font.Color := clBlack;
  Canvas.Font.Name := 'Segoe UI';
  Canvas.Font.Style := [];

  setLength(yStone,stoneAmount);
  for i:=0 to (length(yStone)-1) do
  begin
    yStone[i]:=random(height div 5);
  end;

  p[0]:=point(height div 15,height div 15);
  p[1]:=point(height div 5,00);
  p[2]:=point(height div 15,-(height div 15));
  p[3]:=point(0,0);

  xCloud:=0;


  ManSize := 0.2;
  manX := Round(Height*0.5);
  manY := Round(Height*0.7);
  manH := Round(Height*ManSize);
  manW := Round(manH*0.5);
  N := 0;

  ManDrawLoop:=1;
  score:=0;


  gManX:=Width div 3;
  gManY:=Height div 2;
  AnimationTimer.Enabled:=true;
end;


procedure TMainFormW.FormPaint(Sender: TObject);
begin
   drawGrass(self);
   drawGround(self);
   drawStones(self,yStone);
   drawTree(self);
   drawCloudsMain(self,xCloud,p);
   drawScore(self,manW,manH,score);

   drawMan(self,ManDrawLoop,N,K,score,manX,manY,manH,manW);
   drawGuitarMan(self,gManX,gManY);
   drawGuitarMan(self,Self.Width - gManX, gManY);
end;


procedure TMainFormW.FormResize(Sender: TObject);
begin
    manX := Round(width*0.5);
    manY := Round(height*0.7);

    manH := Round(Height*ManSize);
    manW := Round(manH*0.5);

    gManX:=Width div 3;
    gManY:=Height div 2;

    p[0]:=point(height div 15,height div 15);
    p[1]:=point(height div 5,00);
    p[2]:=point(height div 15,-(height div 15));
    p[3]:=point(0,0);

    //Repaints everything
    self.Refresh;
end;


procedure TMainFormW.AnimationTimerTimer(Sender: TObject);
begin
  self.Refresh;
end;

end.
