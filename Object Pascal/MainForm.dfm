object Form1: TForm1
  Left = 395
  Top = 132
  Width = 601
  Height = 542
  Caption = 'Grid Search Demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 472
    Width = 593
    Height = 42
    Align = alBottom
    TabOrder = 0
    object Label1: TLabel
      Left = 72
      Top = 18
      Width = 6
      Height = 16
      Caption = 'x'
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
      ItemHeight = 16
      TabOrder = 5
      Items.Strings = (
        'Depth first'
        'Breadth first')
    end
  end
  object MainPanel: TPanel
    Left = 0
    Top = 0
    Width = 593
    Height = 472
    Align = alClient
    TabOrder = 1
  end
end
