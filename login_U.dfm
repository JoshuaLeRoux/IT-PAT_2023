object TLoginForm: TTLoginForm
  Left = 0
  Top = 0
  Caption = 'TLoginForm'
  ClientHeight = 201
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblPassword: TLabel
    Left = 40
    Top = 40
    Width = 56
    Height = 13
    Caption = 'lblPassword'
  end
  object btnLogin: TButton
    Left = 288
    Top = 128
    Width = 115
    Height = 41
    Caption = 'Login'
    TabOrder = 0
    OnClick = btnLoginClick
  end
  object edtPassword: TEdit
    Left = 40
    Top = 88
    Width = 121
    Height = 21
    TabOrder = 1
  end
end
