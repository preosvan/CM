unit MainFrm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit, FMX.SearchBox, FMX.Layouts, FMX.ListBox,
  FMX.TabControl, Data.DBXDataSnap, IPPeerClient, Data.DBXCommon,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, System.Actions, FMX.ActnList, Data.Bind.Components,
  Data.Bind.DBScope, Data.DB, Datasnap.DBClient, Datasnap.DSConnect,
  Data.SqlExpr, Fmx.Bind.Navigator, FMX.StdCtrls, DMClientUnit, FMX.Ani,
  FMX.ExtCtrls, Data.Bind.DBLinks, Fmx.Bind.DBLinks;

type
  TMainForm = class(TForm)
    BindSourceDB: TBindSourceDB;
    BindingsList: TBindingsList;
    ActionList: TActionList;
    TitleAction: TControlAction;
    actPreviousTab: TPreviousTabAction;
    actSetLangEN: TAction;
    actSetLangFR: TAction;
    actSetLangPR: TAction;
    actAccess: TAction;
    actSwitchToEmployee: TChangeTabAction;
    actSwitchToMenu: TChangeTabAction;
    actSwitchToEmployeeEditor: TChangeTabAction;
    actEmplEdit: TAction;
    actEmplDelete: TAction;
    actEmplApply: TAction;
    actEmplCancel: TAction;
    actEmplAdd: TAction;
    actSwitchToLogin: TChangeTabAction;
    actEmplRefresh: TAction;
    tcMain: TTabControl;
    TabLogin: TTabItem;
    pnClient: TPanel;
    pnCenter: TPanel;
    edLogin: TEdit;
    edPassword: TEdit;
    btnAccess: TButton;
    ivBR: TImageViewer;
    BitmapListAnimation3: TBitmapListAnimation;
    ivCA: TImageViewer;
    BitmapListAnimation2: TBitmapListAnimation;
    ivFR: TImageViewer;
    BitmapListAnimation1: TBitmapListAnimation;
    ivLogo: TImageViewer;
    TabMenu: TTabItem;
    lbMenu: TListBox;
    ListBoxItemEmployee: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    ListBoxItem6: TListBoxItem;
    ListBoxItem7: TListBoxItem;
    TabEmployee: TTabItem;
    lbEmployee: TListBox;
    SearchBox: TSearchBox;
    TabEmployeeEditor: TTabItem;
    Layout1: TLayout;
    ImageControlPhoto: TImageControl;
    edLoginEd: TEdit;
    edPassEd: TEdit;
    edConfirmPassEd: TEdit;
    Layout2: TLayout;
    edSurnameEd: TEdit;
    edMailEd: TEdit;
    edPhoneEd: TEdit;
    edFirstNameEd: TEdit;
    btnEmplDelete: TSpeedButton;
    TopToolBar: TToolBar;
    ToolBarLabel: TLabel;
    btnBack: TSpeedButton;
    btnEmplEdit: TSpeedButton;
    btnEmplCancel: TSpeedButton;
    btnEmplApply: TSpeedButton;
    btnEmplAdd: TSpeedButton;
    StyleBook: TStyleBook;
    Lang: TLang;
    LinkListControlToField1: TLinkListControlToField;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField6: TLinkControlToField;
    LinkControlToField7: TLinkControlToField;
    actEmplInsertLB: TFMXBindNavigateInsert;
    actEmplDeleteLB: TFMXBindNavigateDelete;
    actEmplPostLB: TFMXBindNavigatePost;
    actEmplCancelLB: TFMXBindNavigateCancel;
    actEmplApplyUpdatesLB: TFMXBindNavigateApplyUpdates;
    LinkControlToField5: TLinkControlToField;
    procedure actAccessExecute(Sender: TObject);
    procedure TitleActionUpdate(Sender: TObject);
    procedure actEmplEditExecute(Sender: TObject);
    procedure actEmplDeleteExecute(Sender: TObject);
    procedure actEmplCancelExecute(Sender: TObject);
    procedure actEmplAddExecute(Sender: TObject);
    procedure actEmplRefreshExecute(Sender: TObject);
    procedure actSetLangENExecute(Sender: TObject);
    procedure actSetLangFRExecute(Sender: TObject);
    procedure actSetLangPRExecute(Sender: TObject);
    procedure ivCATap(Sender: TObject; const [Ref] Point: TPointF);
    procedure ivBRTap(Sender: TObject; const [Ref] Point: TPointF);
    procedure ivFRTap(Sender: TObject; const [Ref] Point: TPointF);
    procedure ListBoxItemEmployeeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actEmplPostLBExecute(Sender: TObject);
    procedure actEmplDeleteLBExecute(Sender: TObject);
    procedure actEmplInsertLBExecute(Sender: TObject);
    procedure tcMainChange(Sender: TObject);
    procedure ImageControlPhotoLoaded(Sender: TObject; const FileName: string);
    procedure lbEmployeeItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
  private
    FIsEditModeEmpl: Boolean;
    procedure SearchReset;
    procedure SetActStatus;
    procedure SetEnebledCntls(AIsReadOnly: Boolean);
    procedure SetIsEditModeEmpl(const Value: Boolean);
    function GetIsEmplFiltered: Boolean;
  public
    property IsEditModeEmpl: Boolean read FIsEditModeEmpl write SetIsEditModeEmpl;
    property IsEmplFiltered: Boolean read GetIsEmplFiltered;
  end;

var
  MainForm: TMainForm;

implementation

uses
  ServerMethodsClientUnit, System.StrUtils;

{$R *.fmx}

{ TForm1 }

procedure TMainForm.actAccessExecute(Sender: TObject);
begin
  if not DMClient.SQLConnection.Connected then
    DMClient.InitConnection;

  if not DMClient.SQLConnection.Connected then
  begin
    ShowMessage('No connection to the server!');
    // Тут необходимо запросить параметры подключения к серверу (хост:порт)
  end;

  if DMClient.SQLConnection.Connected then
  begin
    if dsClient.IsValidUser(Trim(edLogin.Text), Trim(edPassword.Text)) then
      actSwitchToMenu.ExecuteTarget(Sender)
    else
      ShowMessage('Invalid user or password');
  end;
end;

procedure TMainForm.actEmplAddExecute(Sender: TObject);
var
  EmplId, EmplIdNew: Integer;
begin
  SearchReset;
  DMClient.cdsEmployee.Last;
  EmplId := 0;
  if not DMClient.cdsEmployee.IsEmpty then
    EmplId := DMClient.cdsEmployee.FieldByName('EMPLOYEEID').AsInteger;
  EmplIdNew := EmplId + 1;
  DMClient.cdsEmployee.Insert;
  DMClient.cdsEmployee.FieldByName('EMPLOYEEID').Value := EmplIdNew;
  IsEditModeEmpl := True;
  actEmplDelete.Visible := False;
  actEmplDeleteLB.Visible := False;
  actSwitchToEmployeeEditor.ExecuteTarget(Sender);
end;

procedure TMainForm.actEmplCancelExecute(Sender: TObject);
begin
  actEmplCancelLB.ExecuteTarget(Self);
  IsEditModeEmpl := False;
  actSwitchToEmployee.ExecuteTarget(Sender);
end;

procedure TMainForm.actEmplDeleteExecute(Sender: TObject);
begin
  IsEditModeEmpl := False;
  actSwitchToEmployee.ExecuteTarget(Sender);
end;

procedure TMainForm.actEmplDeleteLBExecute(Sender: TObject);
begin
  DMClient.cdsEmployee.Delete;
  DMClient.cdsEmployee.ApplyUpdates(-1);
  actEmplDelete.Execute;
end;

procedure TMainForm.actEmplEditExecute(Sender: TObject);
begin
  DMClient.cdsEmployee.Edit;
  IsEditModeEmpl := True;
end;

procedure TMainForm.actEmplInsertLBExecute(Sender: TObject);
begin
  actEmplAdd.Execute;
end;

procedure TMainForm.actEmplPostLBExecute(Sender: TObject);
begin
  actEmplApplyUpdatesLB.ExecuteTarget(Self);
  IsEditModeEmpl := False;
end;

procedure TMainForm.actEmplRefreshExecute(Sender: TObject);
begin
  if tcMain.ActiveTab = TabMenu then
    SearchReset;
  DMClient.EmployeeRefresh;
end;

procedure TMainForm.actSetLangENExecute(Sender: TObject);
begin
  Lang.Lang := 'EN';
end;

procedure TMainForm.actSetLangFRExecute(Sender: TObject);
begin
  Lang.Lang := 'FR';
end;

procedure TMainForm.actSetLangPRExecute(Sender: TObject);
begin
  Lang.Lang := 'PR';
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  actSwitchToLogin.ExecuteTarget(Sender);
end;

function TMainForm.GetIsEmplFiltered: Boolean;
begin
  Result := SearchBox.Text.Trim <> EmptyStr;
end;

procedure TMainForm.ImageControlPhotoLoaded(Sender: TObject;
  const FileName: string);
begin
  TBlobField(DMClient.cdsEmployee.FieldByName('PHOTO')).Assign(ImageControlPhoto.Bitmap);
end;

procedure TMainForm.ivBRTap(Sender: TObject; const [Ref] Point: TPointF);
begin
  actSetLangPR.Execute;
end;

procedure TMainForm.ivCATap(Sender: TObject; const [Ref] Point: TPointF);
begin
  actSetLangEN.Execute;
end;

procedure TMainForm.ivFRTap(Sender: TObject; const [Ref] Point: TPointF);
begin
  actSetLangFR.Execute;
end;

procedure TMainForm.lbEmployeeItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
var
  I: Integer;
  SurNameSel: string;
begin
  if IsEmplFiltered then
  begin
    SurNameSel := Item.Text;
    actSwitchToEmployeeEditor.ExecuteTarget(Sender);
    if BindSourceDB.DataSet.FieldByName('SURNAME').AsString <> SurNameSel then
    begin
      BindSourceDB.DataSet.First;
      while not BindSourceDB.DataSet.Eof do
      begin
        if BindSourceDB.DataSet.FieldByName('SURNAME').AsString = SurNameSel then
            Break;
        BindSourceDB.DataSet.Next;
      end;
    end;
  end
  else
    actSwitchToEmployeeEditor.ExecuteTarget(Sender);

//  lbEmployee.FilterPredicate := nil;
//  lbEmployee.BeginUpdate;
//  try
//    for I := 0 to lbEmployee.Count - 1 do
//      if lbEmployee.ListItems[I].ItemData = Item.ItemData then
//        lbEmployee.ItemIndex := I;
//  finally
//    lbEmployee.EndUpdate;
//  end;
end;

procedure TMainForm.ListBoxItemEmployeeClick(Sender: TObject);
begin
  actSwitchToEmployee.ExecuteTarget(Sender);
end;

procedure TMainForm.SearchReset;
begin
  lbEmployee.FilterPredicate := nil;
  SearchBox.Text := EmptyStr;
end;

procedure TMainForm.SetActStatus;
begin
  actPreviousTab.Visible := not IsEditModeEmpl;
  actEmplAdd.Visible := tcMain.ActiveTab = TabEmployee;
  actEmplInsertLB.Visible := tcMain.ActiveTab = TabEmployee;
  actEmplEdit.Visible := (tcMain.ActiveTab = TabEmployeeEditor) and
    not IsEditModeEmpl;
  //LoginTab
  if tcMain.ActiveTab = TabLogin then
  begin
    actPreviousTab.Visible := False;
    actEmplDelete.Visible := False;
    actEmplDeleteLB.Visible := False;
    actEmplApply.Visible := False;
    actEmplPostLB.Visible := False;
    actEmplCancel.Visible := False;
    actEmplCancelLB.Visible := False;
  end;

  if tcMain.ActiveTab <> TabEmployeeEditor then
    IsEditModeEmpl := False;
end;

procedure TMainForm.SetEnebledCntls(AIsReadOnly: Boolean);
begin
  edLoginEd.ReadOnly := AIsReadOnly;
  edPassEd.ReadOnly := AIsReadOnly;
  edConfirmPassEd.ReadOnly := AIsReadOnly;
  edSurnameEd.ReadOnly := AIsReadOnly;
  edMailEd.ReadOnly := AIsReadOnly;
  edPhoneEd.ReadOnly := AIsReadOnly;
  edFirstNameEd.ReadOnly := AIsReadOnly;
  ImageControlPhoto.EnableOpenDialog := not AIsReadOnly;
end;

procedure TMainForm.SetIsEditModeEmpl(const Value: Boolean);
begin
  FIsEditModeEmpl := Value;
  actEmplApply.Visible := Value;
  actEmplPostLB.Visible := Value;
  actEmplEdit.Visible := not Value and (tcMain.ActiveTab = TabEmployeeEditor);
  actEmplDelete.Visible := Value;
  actEmplDeleteLB.Visible := Value;
  actEmplCancel.Visible := Value;
  actEmplCancelLB.Visible := Value;
  SetEnebledCntls(not Value);
end;

procedure TMainForm.tcMainChange(Sender: TObject);
var
  SearchText: string;
begin
  if (tcMain.ActiveTab <> TabLogin) then
    actEmplRefresh.Execute;

  if (tcMain.ActiveTab = TabEmployee) and IsEmplFiltered then
  begin
    SearchText := SearchBox.Text;
    SearchReset;
    SearchBox.Text := SearchText;
  end;
end;

procedure TMainForm.TitleActionUpdate(Sender: TObject);
begin
  if Sender is TCustomAction then
  begin
    if Assigned(tcMain.ActiveTab) then
      TCustomAction(Sender).Text := tcMain.ActiveTab.Text
    else
      TCustomAction(Sender).Text := '';
  end;
  SetActStatus;
end;

end.
