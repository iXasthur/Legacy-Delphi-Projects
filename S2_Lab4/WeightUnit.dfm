object MainFormW: TMainFormW
  Left = 0
  Top = 0
  Caption = 'MainFormW'
  ClientHeight = 429
  ClientWidth = 574
  Color = clBtnFace
  Constraints.MinHeight = 500
  Constraints.MinWidth = 600
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnPaint = FormPaint
  OnResize = FormResize
  PixelsPerInch = 192
  TextHeight = 25
  object AnimationTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = AnimationTimerTimer
    Left = 456
    Top = 64
  end
end
