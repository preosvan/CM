object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = ' '
  ClientHeight = 281
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 418
    Height = 41
    Align = alTop
    TabOrder = 0
    object btnTestDB: TButton
      Left = 8
      Top = 9
      Width = 97
      Height = 25
      Caption = 'Test DB'
      TabOrder = 0
      OnClick = btnTestDBClick
    end
  end
  object meLog: TMemo
    Left = 0
    Top = 41
    Width = 418
    Height = 240
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 88
    ExplicitTop = 120
    ExplicitWidth = 185
    ExplicitHeight = 89
  end
end
