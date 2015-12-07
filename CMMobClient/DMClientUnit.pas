unit DMClientUnit;

interface

uses
  System.SysUtils, System.Classes, Data.DBXDataSnap, IPPeerClient,
  Data.DBXCommon, Data.DB, Datasnap.DBClient, Datasnap.DSConnect, Data.SqlExpr;

type
  TDMClient = class(TDataModule)
    SQLConnection: TSQLConnection;
    DSProviderConnection: TDSProviderConnection;
    cdsEmployee: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    procedure InitConnection;
    procedure EmployeeRefresh;
  end;

var
  DMClient: TDMClient;

implementation

uses
  ServerMethodsClientUnit;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TDMClient }

procedure TDMClient.DataModuleCreate(Sender: TObject);
begin
  InitConnection;
end;

procedure TDMClient.DataModuleDestroy(Sender: TObject);
begin
  dsClient.Free;
end;

procedure TDMClient.EmployeeRefresh;
var
  EmplId: Integer;
begin
  if Assigned(cdsEmployee) then
    if cdsEmployee.State <> dsInsert then
    begin
      EmplId := 0;
      if not cdsEmployee.IsEmpty then
        EmplId := cdsEmployee.FieldByName('EMPLOYEEID').AsInteger;
      cdsEmployee.Active := False;
      cdsEmployee.Active := True;
      if EmplId <> 0 then
        cdsEmployee.Locate('EMPLOYEEID', EmplId, []);
    end;
end;

procedure TDMClient.InitConnection;
begin
  try
    SQLConnection.Open;
    dsClient := TServerMethodsClient.Create(SQLConnection.DBXConnection, False);
    cdsEmployee.Active := True;
  except

  end;
end;

end.
