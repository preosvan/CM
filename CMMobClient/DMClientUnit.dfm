object DMClient: TDMClient
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 313
  Width = 215
  object SQLConnection: TSQLConnection
    ConnectionName = 'DataSnapCONNECTION'
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXDataSnap'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=23.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'DriverName=DataSnap'
      'HostName=192.168.1.101'
      'port=211'
      'Filters={}')
    Left = 56
    Top = 8
    UniqueId = '{83E86134-F9C8-46E0-9EBA-15CDBCE6EFD2}'
  end
  object DSProviderConnection: TDSProviderConnection
    ServerClassName = 'TServerMethods'
    SQLConnection = SQLConnection
    Left = 56
    Top = 64
  end
  object cdsEmployee: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspEmployee'
    RemoteServer = DSProviderConnection
    Left = 56
    Top = 118
  end
end
