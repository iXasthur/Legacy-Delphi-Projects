unit GuitarUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Vcl.MPlayer;

type
  TForm1 = class(TForm)
    MainTimer: TTimer;
    procedure FormPaint(Sender: TObject);
    procedure MainTimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public


    { Public declarations }
  end;
  TMyCanvas = class(TCanvas)
  procedure Circle(Rad, X, Y, color: integer);

  end;


  procedure MenStatic(Form:TForm;x,y,rad:Integer);
  procedure Guitar(form:TForm;x,y,rad:Integer);
  procedure LeftHand(Form:TForm;mX,mY,rad:Integer);
  procedure RightHand(Form:TForm;mX,mY,rad:Integer);
  procedure HeadAndNeck(form:TForm;mX,mY,rad:integer);

var
  Form1: TForm1;


implementation

{$R *.dfm}

procedure TMyCanvas.Circle(Rad, X, Y, color: integer);
begin
  Brush.Color:=color;
  Ellipse(X-Rad, Y-Rad, X+Rad, Y+Rad);
end;


procedure DrawBackround(Form:TForm; k1:integer);
var x1,x2,y1,y2,i:Integer;
    MC:TMyCanvas;

begin
  with Form do
  begin
    MC:=TMyCanvas.Create;
    MC.Handle:=Canvas.Handle;

    x1:=0;
    x2:=ClientWidth;
    y1:=(ClientHeight div 2)+k1;
    y2:=ClientHeight;
    Canvas.Brush.Color:=clWebDarkRed;

    Canvas.Rectangle(0,0,x2,y1);
    Canvas.Brush.Color:=clWebTan;
    Canvas.Rectangle(x1, y1, x2, y2);

    for i:=10 to 30 do
      begin
        y1:=y1+i;
        Canvas.MoveTo(x1,y1);    //Горизонтальные линиии
        Canvas.LineTo(x2, y1);
      end;

    x1:=x2;
    {for i:=1 to trunc(x1/20) do
      begin
        Canvas.MoveTo(x1, y1);
        Canvas.LineTo(x1, y2);   //Вертикальные линии
        x1:=x1-20;
      end;    }

    //прорисовка колонок
    x1:=ClientWidth div 5;
    y1:=(ClientHeight div 2)+2*k1;
    y2:=y1-4*k1;
    Canvas.Brush.Color:=clWebDarkSlategray;
    for i:=1 to 2 do
    begin
      x2:=x1+2*k1;
      Canvas.Rectangle(x1,y1,x2,y2);
      x1:=x1*3;
    end;

    x1:=ClientWidth div 5;
    y1:=(ClientHeight div 2)+2*k1;
    y2:=y1-4*k1;
    for i:=1 to 2 do
      begin
        x2:=x1+2*k1;
        MC.Circle(trunc(k1*0.75),trunc((x1+x2)*0.5), trunc((y1+y2)*0.35), clBlack);
        MC.Circle(trunc(k1*0.75),trunc((x1+x2)*0.5), trunc((y1+y2)*0.65), clBlack);
        MC.Circle(trunc(k1*0.45),trunc((x1+x2)*0.5), trunc((y1+y2)*0.35), clWebGray);
        MC.Circle(trunc(k1*0.45),trunc((x1+x2)*0.5), trunc((y1+y2)*0.65), clWebGray);
        x1:=x1*3;
      end;
   end;
end;

procedure MenStatic(Form:TForm;x,y,rad:Integer);
begin
  with Form do
  begin
    canvas.Pen.Color:=clRed;

    Canvas.MoveTo(x,y);
    y:=y+4*rad;
    Canvas.LineTo(x,y);      //туловище

    Canvas.LineTo(x-rad,y+2*rad);       //нога левая

    Canvas.LineTo(x-rad-trunc(rad*0.8),y+2*rad);        //лодыжка левая

    Canvas.MoveTo(x,y);
    Canvas.LineTo(x+rad,y+2*rad);       //нога правая

    Canvas.LineTo(x+rad+trunc(rad*0.8),y+2*rad);        //лодыжка правая
    y:=y-4*rad;

    Canvas.MoveTo(x,y);
    Canvas.LineTo(x-trunc(1.4*rad),y+rad); // левая рука
  end;
end;


procedure Guitar(form:TForm;x,y,rad:Integer);
var i:Integer;
    k2:Real;
begin
  with form do
  begin

    //гитара
    Canvas.Brush.Color:=clWebDarkGray;
    Canvas.Pen.Color:=clWebBlack;

    Canvas.Polygon([Point(x+trunc(0.8*rad),y+(2*rad)),
                    Point(x-trunc(2.1*rad),y+trunc(1*rad)),
                    Point(x-trunc(1.2*rad),y+trunc(2.3*rad)),
                    Point(x-trunc(2.1*rad),y+trunc(3.6*rad)),
                    Point(x+trunc(0.8*rad),y+trunc(2.5*rad))
                    ]);
    Canvas.Rectangle(x-trunc(0.9*rad),y+trunc(2*rad), x-trunc(1*rad),y+trunc(2.5*rad));
    Canvas.Rectangle(x+trunc(0.8*rad),y+(2*rad),x+trunc(2.4*rad),y+trunc(2.5*rad));

    //Струны
    k2:=2.40;
    for I:=1 to 4 do
      begin
        Canvas.MoveTo(x+trunc(2.4*rad),y+trunc(k2*rad));
        Canvas.LineTo(x-trunc(0.9*rad),y+trunc(k2*rad));
        k2:=k2-0.1;
      end;
   end;
end;


var
  bLeft,bRight, bHead:boolean;
  alpha, beta, num:integer;
  kRight:Real;
  rad: integer;

procedure TForm1.FormPaint(Sender: TObject);
var
  MC: TMyCanvas;
  x, y:Integer;
  k: Integer;
begin
  Color:=clWhite;
  MC:=TMyCanvas.Create;
  MC.Handle:=Canvas.Handle;

  k:=(ClientHeight+ClientHeight) div 15;          //коэффицент

  DrawBackround(Self,k);  //отрисовка сцены

  x:=ClientWidth div 2;
  y:=ClientHeight div 2;
  MenStatic(Self,x,y,rad);     //отрисовка человека (статические части)

  Guitar(Self,x,y,rad);   //отрисовка гитары

end;

procedure TForm1.FormResize(Sender: TObject);
begin
  rad:=(ClientHeight+ClientWidth) div 36;
end;

procedure RightHand(Form:TForm;mX,mY,rad:Integer);
var x,y,xnew:Integer;
begin
  with Form do
  begin
//    rad:=(Height) div 34;

    x:=mX;
    y:=mY;

    if bRight=true then
    begin
      kRight:=kRight+0.005;
      Inc(num);
      xnew:=x+trunc(kRight*rad);
      Canvas.MoveTo(x,y);
      Canvas.LineTo(xnew,y+2*rad);
    end;
    if bRight=false then
    begin
      kRight:=kRight-0.005;
      Dec(num);
      xnew:=x+trunc(kRight*rad);
      Canvas.MoveTo(x,y);
      Canvas.LineTo(xnew,y+2*rad);
    end;
    if num=30  then bRight:=False;
    if num=-20  then bRight:=True
  end;
end;

procedure LeftHand(Form:TForm;mX,mY,rad:Integer);
var xnew, ynew:Integer;
    x,y,x1,y1:Integer;
    cosa,sina:Real;
begin
  with Form do
  begin
    Canvas.Pen.Color:=clRed;

    x:=(mX)-trunc(1.4*rad);
    y:=mY + rad;
    x1:=x+rad;
    y1:=y+rad;

    cosa:=cos(alpha*pi/180);
    sina:=Sin(alpha*pi/180);

    if bLeft= true then
    begin
      alpha:= alpha+7;
      xnew:=trunc(((x1-x)*cosa-(y1-y)*sina)+x);
      ynew:=Trunc(((x1-x)*sina+(y1-y)*cosa)+y);
      Canvas.MoveTo(x,y);
      Canvas.LineTo(xnew,ynew);
    end;
    if bLeft= false then
    begin
      alpha:= alpha-7;
      xnew:=trunc(((x1-x)*cosa-(y1-y)*sina)+x);
      ynew:=Trunc(((x1-x)*sina+(y1-y)*cosa)+y);
      Canvas.MoveTo(x,y);
      Canvas.LineTo(xnew,ynew);
    end;
    if alpha > 45 then bLeft:=false;
    if alpha < -15 then bLeft:=true;
  end;
end;

procedure HeadAndNeck(form:TForm;mX,mY,rad:integer);
var MC: TMyCanvas;
    xnew, ynew:Integer;
    x,y,x1,y1,x2,y2:Integer;
    cosb, sinb:Real;
begin
  with form do
  begin
    rad:=(rad*10) div 11;
    MC:=TMyCanvas.Create;
    MC.Handle:=Canvas.Handle;
    MC.Pen.Color:=clRed;
    x:=mX;
    y:=mY - Trunc(1.5*rad);
    x1:=x;
    y1:=y+trunc(1.5*rad);

    cosb:=cos(beta*pi/180);
    sinb:=Sin(beta*pi/180);

    if bHead = true then
    begin
      //Form1.Refresh;
//      beta:= beta-6;
      beta:= beta-6;
      xnew:=trunc(((x-x1)*cosb-(y-y1)*sinb)+x1);
      ynew:=Trunc(((x-x1)*sinb+(y-y1)*cosb)+y1);
      Canvas.MoveTo(x1,y1);
      Canvas.LineTo(xnew,ynew);
      MC.Circle(rad,xnew,ynew,clCream);
    end;
    if bHead = false then
    begin
      //Form1.Refresh;
      beta:= beta+6;
      xnew:=trunc(((x-x1)*cosb-(y-y1)*sinb)+x1);
      ynew:=Trunc(((x-x1)*sinb+(y-y1)*cosb)+y1);
      Canvas.MoveTo(x1,y1);
      Canvas.LineTo(xnew,ynew);
      MC.Circle(rad,xnew,ynew,clCream);
    end;
    if beta < 12 then bHead:=false;
    if beta > 78 then bHead:=true;
  end;
end;

procedure TForm1.MainTimerTimer(Sender: TObject);
var  xnew, ynew:Integer;
      xc, yc, x,y,x1,y1:Integer;
       cosa,sina, cosb, sinb:Real;
begin

  Form1.Refresh;
//  LeftHand(Self);
//  RightHand(self);
//  HeadAndNeck(Self);

end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  Self.DoubleBuffered:=True;
//  MediaPlayer.FileName:='Highway To Hell.mp3';
//  MediaPlayer.Open;
//  MediaPlayer.Play;
//  MainTimer.Enabled:=True;
end;

initialization
      alpha:=0;
      bLeft:=true;

      bRight:=True;
      kRight:=1.5;
      num:=0;
      bHead:=True;

      beta:=90;

      rad:=1;
end.
