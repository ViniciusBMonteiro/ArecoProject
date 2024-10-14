unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Comp.Client, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  Vcl.ControlList, Vcl.ExtCtrls, Vcl.Buttons, Vcl.DBCtrls, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, Vcl.StdCtrls, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase,
  FireDAC.Phys.FB, FireDAC.Comp.UI, Vcl.ComCtrls, Vcl.ButtonGroup,
  FireDAC.VCLUI.Login, Vcl.Imaging.pngimage, System.ImageList, Vcl.ImgList;

type
  TfrmMain = class(TForm)
    Panel2: TPanel;
    Panel3: TPanel;
    btnSettings: TSpeedButton;
    btnExit: TSpeedButton;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    pnlRegister: TPanel;
    btnReg: TSpeedButton;
    Panel1: TPanel;
    grdItens: TDBGrid;
    Panel5: TPanel;
    lblTitle: TLabel;
    btnDelete: TSpeedButton;
    btnNew: TSpeedButton;
    btnEdit: TSpeedButton;
    pnlRegisterSub: TPanel;
    btnProducts: TSpeedButton;
    procedure btnExitClick(Sender: TObject);
    procedure btnRegClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnProductsClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure tableAction(Sender: TObject);
  private
    tableQuery: TFDQuery;
    dsQuery: TDataSource;
    tableSel: String;
    procedure configQuery;

  public
    mainConnection: TFDConnection;
  end;

var
  frmMain: TfrmMain;

implementation

uses uRegister;

{$R *.dfm}

procedure TfrmMain.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.btnRegClick(Sender: TObject);
begin
  pnlRegisterSub.Visible := not pnlRegisterSub.Visible;

  if pnlRegisterSub.Visible then
    pnlRegister.Color := $00886D5E
  else
    pnlRegister.Color := $004E3F36;

end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  loginDialog: TFDGUIxLoginDialog;
begin

  // Configure database access
  loginDialog := TFDGUIxLoginDialog.Create(self);

  try
    mainConnection := TFDConnection.Create(self);

    mainConnection.DriverName := 'PG';
    mainConnection.Params.Values['Database'] := 'dbArcoProject';
    mainConnection.Params.Values['User_Name'] := 'vbmonteiro';
    mainConnection.Params.Values['Password'] := '260118';
    mainConnection.Params.Values['Server'] := 'localhost';
    mainConnection.Params.Values['Port'] := '5432';
    mainConnection.Connected := True;
  except
    on e: Exception do
    begin
      ShowMessage('Error to acess the system, please contact our support!');
      Abort;
    end;

  end;

  // Create Query that connect with the main table
  tableQuery := TFDQuery.Create(self);

  tableQuery.connection := mainConnection;

  dsQuery := TDataSource.Create(self);
  dsQuery.DataSet := tableQuery;

  grdItens.DataSource := dsQuery;

  pnlRegisterSub.Visible := False;
end;

procedure TfrmMain.tableAction(Sender: TObject);
var
  tag: integer;
begin
  tag := TSpeedButton(Sender).tag;

  if not assigned(frmRegister) then
    frmRegister := TFrmRegister.Create(self);

  frmRegister.tableName := tableSel;

  if tag = 1 then
    frmRegister.tableAction := 'insert'
  else if tag = 2 then
  begin
    frmRegister.tableAction := 'edit';
    frmRegister.itemId := tableQuery.FieldByName('id').AsInteger;
  end;

  frmRegister.configForm;

  frmRegister.ShowModal;

  tableQuery.Refresh;

end;

procedure TfrmMain.btnDeleteClick(Sender: TObject);
begin
  if tableQuery.RecordCount > 0 then
  begin
    if Application.MessageBox('Are you sure you want to delete this record?',
      'Confirmation', MB_YESNO or MB_ICONHAND) = IDYES then
    begin
      with TFDQuery.Create(nil) do
      begin
        connection := mainConnection;

        SQL.Add('DELETE fROM ' + tableSel);
        SQL.Add('WHERE id = :id');

        ParamByName('id').AsInteger := tableQuery.FieldByName('id').AsInteger;

        ExecSQL;

        free;
      end;

      tableQuery.Refresh;
    end;
  end
  else
    ShowMessage('There are no records to delete!');

end;

procedure TfrmMain.configQuery;
begin
  tableQuery.Close;

  tableQuery.SQL.Text := 'SELECT * FROM ' + tableSel;

  tableQuery.IndexFieldNames := 'id';

  tableQuery.Open;
end;

procedure TfrmMain.btnProductsClick(Sender: TObject);
begin
  tableSel := 'productReg';
  configQuery;
end;

end.
