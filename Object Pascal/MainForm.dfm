object Form1: TForm1
  Left = 262
  Top = 170
  Caption = 'Grid Search Demo 1.0'
  ClientHeight = 506
  ClientWidth = 666
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 432
    Width = 666
    Height = 74
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      666
      74)
    object Label1: TLabel
      Left = 72
      Top = 18
      Width = 6
      Height = 16
      Caption = 'x'
    end
    object Label2: TLabel
      Left = 8
      Top = 40
      Width = 39
      Height = 16
      Caption = 'Delay:'
    end
    object edCols: TEdit
      Left = 8
      Top = 10
      Width = 57
      Height = 24
      TabOrder = 0
    end
    object edRows: TEdit
      Left = 88
      Top = 10
      Width = 57
      Height = 24
      TabOrder = 1
    end
    object btnMakeGrid: TButton
      Left = 160
      Top = 9
      Width = 105
      Height = 25
      Caption = '<-- make grid'
      TabOrder = 2
      OnClick = btnMakeGridClick
    end
    object btnSearch: TButton
      Left = 416
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Search'
      TabOrder = 3
      OnClick = btnSearchClick
    end
    object btnReset: TButton
      Left = 504
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Reset'
      TabOrder = 4
      OnClick = btnResetClick
    end
    object cbAlgorithm: TComboBox
      Left = 288
      Top = 8
      Width = 121
      Height = 24
      Style = csDropDownList
      TabOrder = 5
      Items.Strings = (
        'Depth first'
        'Breadth first'
        'Best first')
    end
    object sldDelay: TTrackBar
      Left = 64
      Top = 40
      Width = 599
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      Max = 500000
      Position = 100000
      TabOrder = 6
      TickStyle = tsNone
      OnChange = sldDelayChange
    end
    object btnHelp: TButton
      Left = 592
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Help'
      TabOrder = 7
      OnClick = btnHelpClick
    end
  end
  object MainPanel: TPanel
    Left = 0
    Top = 0
    Width = 666
    Height = 432
    Align = alClient
    TabOrder = 1
  end
end
