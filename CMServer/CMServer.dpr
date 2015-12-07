program CMServer;

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  MainFrm in 'MainFrm.pas' {MainForm},
  ServerMethodsUnit in 'ServerMethodsUnit.pas' {ServerMethods: TDSServerModule},
  ServerContainerUnit in 'ServerContainerUnit.pas' {ServerContainer: TDataModule},
  DMServerUnit in 'DMServerUnit.pas' {DMServer: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TServerContainer, ServerContainer);
  Application.CreateForm(TDMServer, DMServer);
  Application.Run;
end.

