object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Exemplo de utiliza'#231#227'o de POOL de Conex'#245'es no Firedac'
  ClientHeight = 512
  ClientWidth = 666
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnExecucaoThread: TButton
    Left = 70
    Top = 90
    Width = 151
    Height = 41
    Caption = 'Dentro de Thread'
    TabOrder = 0
    OnClick = btnExecucaoThreadClick
  end
  object btnExecucaoNormal: TButton
    Left = 265
    Top = 90
    Width = 176
    Height = 41
    Caption = 'Normal'
    TabOrder = 1
    OnClick = btnExecucaoNormalClick
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\regys\Desktop\Exemplo POOL Firedac\database\DA' +
        'DOS.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Server=localhost'
      'Port=3050'
      'CharacterSet=WIN1252'
      'DriverID=FB')
    Left = 325
    Top = 260
  end
end
