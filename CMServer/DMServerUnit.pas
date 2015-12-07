unit DMServerUnit;

interface

uses
  System.SysUtils, System.Classes, Data.FMTBcd, Data.DB, Data.SqlExpr,
  ServerMethodsUnit, Data.DBXInterBase, Datasnap.Provider;

type
  TDMServer = class(TDataModule)
    SQLQuery: TSQLQuery;
    CmConnection: TSQLConnection;
    procedure DataModuleCreate(Sender: TObject);
  private

  public
    function GetSqlBool(ASql: string): Boolean;
  end;

var
  DMServer: TDMServer;

implementation

uses
  MainFrm;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDMServer }

procedure TDMServer.DataModuleCreate(Sender: TObject);
begin
  CmConnection.Params.Values['Database'] := 'localhost:' +
    ExtractFilePath(ParamStr(0)) + PathDelim + 'CM.ib';
  CmConnection.Params.Values['User_name'] := 'SYSDBA';
  CmConnection.Params.Values['Password'] := 'masterkey';
  try
    CmConnection.Connected := True;
    MainForm.AddLog('Database connection is successful!');
  except on e: Exception do
    MainForm.AddLog('Error connect to database: ' + e.Message);
  end;
end;

function TDMServer.GetSqlBool(ASql: string): Boolean;
begin
  Result := False;
  SQLQuery.Close;
  SQLQuery.SQL.Clear;
  SQLQuery.SQL.Add(ASql);
  try
    SQLQuery.Open;
    try
      Result := SQLQuery.FieldByName('Result').AsBoolean;
    finally
      SQLQuery.Close;
    end;
  except
    on E: Exception do
      MainForm.AddLog('SQL: ' + ASql + #13#10 + 'Message: ' + E.Message);
  end;
end;

end.
