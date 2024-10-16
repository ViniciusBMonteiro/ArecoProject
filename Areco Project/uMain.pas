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
    Label1: TLabel;
    procedure btnExitClick(Sender: TObject);
    procedure btnRegClick(Sender: TObject);
    procedure btnProductsClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure tableAction(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
  private
    tableQuery: TFDQuery;
    dsQuery: TDataSource;
    tableSel: String;
    procedure queryConfig;
  public
    mainConnection: TFDConnection;
  end;

var
  frmMain: TfrmMain;

implementation

uses uConfigDb, uRegister;

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

procedure TfrmMain.btnSettingsClick(Sender: TObject);
begin
  if not assigned(frmConfigDb) then
    frmConfigDb := TFrmConfigDb.Create(Self);

  frmConfigDb.ShowModal;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  mainConnection := TFDConnection.Create(Self);

  frmConfigDb := TFrmConfigDb.Create(Self);

end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  frmMain := nil;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  // Create Query that connect with the main table
  tableQuery := TFDQuery.Create(Self);

  tableQuery.connection := mainConnection;

  dsQuery := TDataSource.Create(Self);
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
    frmRegister := TFrmRegister.Create(Self);

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

procedure TfrmMain.queryConfig;
begin
  tableQuery.Close;

  tableQuery.SQL.Text := 'SELECT * FROM ' + tableSel;

  tableQuery.IndexFieldNames := 'id';

  tableQuery.Open;
end;

procedure TfrmMain.btnProductsClick(Sender: TObject);
begin
  tableSel := 'productreg';
  queryConfig;
end;

end.
