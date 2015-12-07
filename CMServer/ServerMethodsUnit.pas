unit ServerMethodsUnit;

interface

uses System.SysUtils, System.Classes, System.Json,
    Datasnap.DSServer, Datasnap.DSAuth, DataSnap.DSProviderDataModuleAdapter,
  Data.DBXInterBase, Data.FMTBcd, Datasnap.Provider, Data.DB, Data.SqlExpr;

type
  TServerMethods = class(TDSServerModule)
    dspEmployee: TDataSetProvider;
    EmployeeinfTable: TSQLDataSet;
  private

  public
    { Public declarations }
    function EchoString(AValue: string): string;
    function ReverseString(AValue: string): string;
    function IsValidUser(ALogin, APass: string): Boolean;
  end;

implementation


{$R *.dfm}


uses System.StrUtils, DMServerUnit;

function TServerMethods.EchoString(AValue: string): string;
begin
  Result := AValue;
end;

function TServerMethods.IsValidUser(ALogin, APass: string): Boolean;
begin
  Result := DMServer.GetSqlBool('select RESULT from IS_VALID_USER(' +
    QuotedStr(ALogin) + ', ' + QuotedStr(APass) + ')');
end;

function TServerMethods.ReverseString(AValue: string): string;
begin
  Result := System.StrUtils.ReverseString(AValue);
end;

end.

