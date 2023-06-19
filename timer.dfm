object fmTimer: TfmTimer
  Left = 1349
  Height = 76
  Top = 566
  Width = 170
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsToolWindow
  Caption = 'TinyTimer ver. 1.1.0'
  ClientHeight = 76
  ClientWidth = 170
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  OnClose = FormClose
  LCLVersion = '1.4.0.4'
  object btStart: TButton
    Cursor = crHandPoint
    Left = 1
    Height = 17
    Top = 40
    Width = 83
    Caption = 'Старт'
    Font.CharSet = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsItalic]
    OnClick = btStartClick
    ParentFont = False
    TabOrder = 0
  end
  object btStop: TButton
    Cursor = crHandPoint
    Left = 85
    Height = 17
    Top = 40
    Width = 83
    Caption = 'Стоп'
    Enabled = False
    Font.CharSet = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsItalic]
    OnClick = btStopClick
    ParentFont = False
    TabOrder = 1
  end
  object btRepeat: TButton
    Cursor = crHandPoint
    Left = 85
    Height = 17
    Top = 57
    Width = 83
    Caption = 'Повтор'
    Font.CharSet = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsItalic]
    OnClick = btRepeatClick
    ParentFont = False
    TabOrder = 2
  end
  object btReset: TButton
    Cursor = crHandPoint
    Left = 1
    Height = 17
    Top = 57
    Width = 83
    Caption = 'Сброс'
    Font.CharSet = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsItalic]
    OnClick = btResetClick
    ParentFont = False
    TabOrder = 3
  end
  object meHour: TMemo
    Left = 0
    Height = 21
    Top = 18
    Width = 41
    Alignment = taRightJustify
    Color = clBackground
    Font.Color = clLime
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Lines.Strings = (
      '0'
    )
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
  end
  object upHours: TUpDown
    Cursor = crHandPoint
    Left = 41
    Height = 21
    Top = 18
    Width = 16
    Associate = meHour
    Max = 23
    Min = 0
    Position = 0
    TabOrder = 5
    Wrap = False
  end
  object meMin: TMemo
    Tag = 1
    Left = 55
    Height = 21
    Top = 18
    Width = 41
    Alignment = taRightJustify
    Color = clBackground
    Font.Color = clLime
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Lines.Strings = (
      '0'
    )
    ParentFont = False
    ReadOnly = True
    TabOrder = 6
  end
  object upMin: TUpDown
    Cursor = crHandPoint
    Left = 96
    Height = 21
    Top = 18
    Width = 16
    Associate = meMin
    Max = 59
    Min = 0
    Position = 0
    TabOrder = 7
    Wrap = False
  end
  object meSec: TMemo
    Left = 110
    Height = 21
    Top = 18
    Width = 41
    Alignment = taRightJustify
    Color = clBackground
    Font.Color = clLime
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Lines.Strings = (
      '0'
    )
    ParentFont = False
    ReadOnly = True
    TabOrder = 8
  end
  object upSec: TUpDown
    Cursor = crHandPoint
    Left = 151
    Height = 21
    Top = 18
    Width = 16
    Associate = meSec
    Max = 59
    Min = 0
    Position = 0
    TabOrder = 9
    Wrap = False
  end
  object Panel2: TPanel
    Left = 1
    Height = 17
    Top = 1
    Width = 55
    Caption = 'Часы'
    TabOrder = 10
  end
  object Panel3: TPanel
    Left = 56
    Height = 17
    Top = 1
    Width = 55
    Caption = 'Минуты'
    TabOrder = 11
  end
  object Panel4: TPanel
    Left = 111
    Height = 17
    Top = 1
    Width = 56
    Caption = 'Секунды'
    TabOrder = 12
  end
  object Timer: TTimer
    Enabled = False
    OnTimer = TimerTimer
    left = 156
  end
  object STimer: TTimer
    left = 160
    top = 16
  end
end
