unit MainFrm;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TMainForm = class(TForm)
    pnTop: TPanel;
    btnTestDB: TButton;
    meLog: TMemo;
    procedure btnTestDBClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure AddLog(AMsg: string);
  end;

var
  MainForm: TMainForm;

implementation

uses
  DMServerUnit, ServerMethodsUnit;

{$R *.dfm}

procedure TMainForm.AddLog(AMsg: string);
begin
  meLog.Lines.BeginUpdate;
  try
    meLog.Lines.Add(formatDateTime('YYYY.MM.DD hh:mm:ss',Now) + ' - ' + AMsg);
  finally
    meLog.Lines.EndUpdate;
  end;
end;

procedure TMainForm.btnTestDBClick(Sender: TObject);
begin
  try
    DMServer.CmConnection.Open;
    if DMServer.CmConnection.Connected then
    begin
      ShowMessage('Ok');
      DMServer.CmConnection.Close;
    end
    else
      ShowMessage('Error!');
  except
    on e: Exception do
      ShowMessage(e.Message);
  end;
end;

end.

