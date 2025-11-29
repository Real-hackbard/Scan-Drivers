object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Scan Drivers'
  ClientHeight = 496
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  TextHeight = 15
  object ListBox1: TListBox
    Left = 0
    Top = 47
    Width = 624
    Height = 268
    TabStop = False
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    ItemHeight = 15
    PopupMenu = PopupMenu1
    TabOrder = 0
    OnClick = ListBox1Click
    OnDblClick = ListBox1DblClick
    ExplicitWidth = 620
    ExplicitHeight = 267
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 47
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 620
    object Label1: TLabel
      Left = 13
      Top = 4
      Width = 166
      Height = 39
      Caption = 'Scan Drivers'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Impact'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 186
      Top = 24
      Width = 112
      Height = 15
      Caption = 'and execute function'
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 477
    Width = 624
    Height = 19
    Panels = <
      item
        Text = 'Status :'
        Width = 50
      end
      item
        Width = 300
      end>
    ExplicitTop = 476
    ExplicitWidth = 620
  end
  object Panel3: TPanel
    Left = 0
    Top = 315
    Width = 624
    Height = 162
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Scan Drivers'
    TabOrder = 3
    ExplicitTop = 314
    ExplicitWidth = 620
    DesignSize = (
      624
      162)
    object Label3: TLabel
      Left = 6
      Top = 72
      Width = 63
      Height = 15
      Caption = 'Command :'
    end
    object Label4: TLabel
      Left = 13
      Top = 131
      Width = 56
      Height = 15
      Caption = 'Examples :'
    end
    object Label5: TLabel
      Left = 16
      Top = 101
      Width = 53
      Height = 15
      Caption = 'Function :'
    end
    object Label6: TLabel
      Left = 22
      Top = 43
      Width = 47
      Height = 15
      Caption = 'Execute :'
    end
    object Label2: TLabel
      Left = 32
      Top = 14
      Width = 37
      Height = 15
      Caption = 'Driver :'
    end
    object Button4: TButton
      Left = 539
      Top = 129
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Execute'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
      OnClick = Button4Click
      ExplicitLeft = 535
    end
    object Edit2: TEdit
      Left = 75
      Top = 69
      Width = 508
      Height = 23
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      OnChange = Edit2Change
      ExplicitWidth = 504
    end
    object ComboBox1: TComboBox
      Left = 75
      Top = 127
      Width = 296
      Height = 23
      Style = csDropDownList
      DropDownCount = 30
      TabOrder = 2
      TabStop = False
      OnChange = ComboBox1Change
      Items.Strings = (
        'Control'
        'Windows About'
        'OpenAs'
        'Explorer Options'
        'Time/Date'
        'Desktop Properties'
        'Device manager'
        'View Environment Variables'
        'Fonts folder'
        'Game Controllers'
        'Open Indexing'
        'Internet Properties'
        'Keyboard Properties'
        'Mouse Properties'
        'Network Connections'
        'ODBC Data'
        'Offline Files'
        'Power Options'
        'Printer User Interface'
        'Programs and Features'
        'Region '#8211' Formats tab'
        'Region '#8211' Location tab'
        'Security and Maintenance'
        'Network wizard'
        'Sound Settings'
        'Start Settings'
        'Taskbar Settings'
        'Services and Input Languages'
        'Firewall Settings'
        'Clear Cookies & Website data (Execute)')
    end
    object Edit3: TEdit
      Left = 75
      Top = 98
      Width = 296
      Height = 23
      TabStop = False
      Enabled = False
      TabOrder = 3
    end
    object Edit4: TEdit
      Left = 75
      Top = 40
      Width = 508
      Height = 23
      TabStop = False
      TabOrder = 4
      Text = 'rundll32.exe'
    end
    object Button1: TButton
      Left = 589
      Top = 11
      Width = 25
      Height = 24
      Hint = 'Load Driver'
      Anchors = [akTop, akRight]
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      TabStop = False
      OnClick = Button1Click
      ExplicitLeft = 585
    end
    object Edit1: TEdit
      Left = 75
      Top = 11
      Width = 508
      Height = 23
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      ReadOnly = True
      TabOrder = 6
      OnChange = Edit1Change
      ExplicitWidth = 504
    end
    object Button2: TButton
      Left = 589
      Top = 41
      Width = 25
      Height = 24
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      TabStop = False
      OnClick = Button2Click
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 278
    Top = 102
  end
  object PopupMenu1: TPopupMenu
    Left = 365
    Top = 102
    object Update1: TMenuItem
      Caption = 'Update'
      OnClick = Update1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Clear1: TMenuItem
      Caption = 'Clear'
      OnClick = Clear1Click
    end
    object Execute1: TMenuItem
      Caption = 'Execute'
      OnClick = Execute1Click
    end
  end
  object OpenDialog2: TOpenDialog
    Filter = 'Executables (*.EXE)|*.exe'
    Left = 455
    Top = 103
  end
end
