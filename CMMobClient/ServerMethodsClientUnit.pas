//
// Created by the DataSnap proxy generator.
// 30.11.2015 2:22:06
// 

unit ServerMethodsClientUnit;

interface

uses System.JSON, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TServerMethodsClient = class(TDSAdminClient)
  private
    FEchoStringCommand: TDBXCommand;
    FReverseStringCommand: TDBXCommand;
    FIsValidUserCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(AValue: string): string;
    function ReverseString(AValue: string): string;
    function IsValidUser(ALogin: string; APass: string): Boolean;
  end;

var
  dsClient: TServerMethodsClient;

implementation

function TServerMethodsClient.EchoString(AValue: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FDBXConnection.CreateCommand;
    FEchoStringCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FEchoStringCommand.Text := 'TServerMethods.EchoString';
    FEchoStringCommand.Prepare;
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(AValue);
  FEchoStringCommand.ExecuteUpdate;
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethodsClient.ReverseString(AValue: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FDBXConnection.CreateCommand;
    FReverseStringCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FReverseStringCommand.Text := 'TServerMethods.ReverseString';
    FReverseStringCommand.Prepare;
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(AValue);
  FReverseStringCommand.ExecuteUpdate;
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethodsClient.IsValidUser(ALogin: string; APass: string): Boolean;
begin
  if FIsValidUserCommand = nil then
  begin
    FIsValidUserCommand := FDBXConnection.CreateCommand;
    FIsValidUserCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FIsValidUserCommand.Text := 'TServerMethods.IsValidUser';
    FIsValidUserCommand.Prepare;
  end;
  FIsValidUserCommand.Parameters[0].Value.SetWideString(ALogin);
  FIsValidUserCommand.Parameters[1].Value.SetWideString(APass);
  FIsValidUserCommand.ExecuteUpdate;
  Result := FIsValidUserCommand.Parameters[2].Value.GetBoolean;
end;


constructor TServerMethodsClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;


constructor TServerMethodsClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;


destructor TServerMethodsClient.Destroy;
begin
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FIsValidUserCommand.DisposeOf;
  inherited;
end;

end.
