object ServerMethods: TServerMethods
  OldCreateOrder = False
  Height = 183
  Width = 400
  object dspEmployee: TDataSetProvider
    DataSet = EmployeeinfTable
    Left = 119
    Top = 8
  end
  object EmployeeinfTable: TSQLDataSet
    CommandText = 'EMPLOYEEINF'
    CommandType = ctTable
    DbxCommandType = 'Dbx.Table'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = DMServer.CmConnection
    Left = 39
    Top = 66
  end
end
