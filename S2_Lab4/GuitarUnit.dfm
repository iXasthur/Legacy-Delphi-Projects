object Form1: TForm1
  Left = 338
  Top = 219
  Caption = 'Form1'
  ClientHeight = 500
  ClientWidth = 800
  Color = clBtnFace
  Constraints.MinHeight = 500
  Constraints.MinWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnPaint = FormPaint
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object MainTimer: TTimer
    Enabled = False
    Interval = 10
    OnTimer = MainTimerTimer
    Left = 160
    Top = 56
  end
end
