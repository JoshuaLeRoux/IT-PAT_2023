object DM: TDM
  OldCreateOrder = False
  Height = 454
  Width = 485
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Database.mdb;Mode=S' +
      'hare Deny None;Persist Security Info=False;Jet OLEDB:System data' +
      'base="";Jet OLEDB:Registry Path="";Jet OLEDB:Database Password="' +
      '";Jet OLEDB:Engine Type=5;Jet OLEDB:Database Locking Mode=1;Jet ' +
      'OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transactio' +
      'ns=1;Jet OLEDB:New Database Password="";Jet OLEDB:Create System ' +
      'Database=False;Jet OLEDB:Encrypt Database=False;Jet OLEDB:Don'#39't ' +
      'Copy Locale on Compact=False;Jet OLEDB:Compact Without Replica R' +
      'epair=False;Jet OLEDB:SFP=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 40
    Top = 40
  end
  object DataSourceF: TDataSource
    DataSet = ADOTableF
    Left = 344
    Top = 40
  end
  object ADOTableF: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'tblFundraisers'
    Left = 192
    Top = 40
  end
  object ADOTableA: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'tblAnimals'
    Left = 192
    Top = 200
  end
  object DataSourceA: TDataSource
    DataSet = ADOTableA
    Left = 344
    Top = 200
  end
  object ADOusers: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'tblUsers'
    Left = 192
    Top = 328
  end
  object DataSourceU: TDataSource
    DataSet = ADOusers
    Left = 344
    Top = 328
  end
  object qryFundR: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 192
    Top = 96
  end
  object dsrFundR: TDataSource
    DataSet = qryFundR
    Left = 344
    Top = 96
  end
  object qryUsers: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 192
    Top = 384
  end
  object dsrUsers: TDataSource
    DataSet = qryUsers
    Left = 344
    Top = 384
  end
  object qryTotals: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 248
    Top = 112
  end
  object dsrTotals: TDataSource
    DataSet = qryTotals
    Left = 400
    Top = 112
  end
end
