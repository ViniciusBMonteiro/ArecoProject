unit uRegister;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Buttons, Vcl.DBCtrls, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  System.ImageList, Vcl.ImgList, Vcl.Mask;

type
  TfrmRegister = class(TForm)
    Panel2: TPanel;
    Panel1: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    edtName: TDBLabeledEdit;
    edtDesc: TDBLabeledEdit;
    btnSave: TSpeedButton;
    pnlCancel: TPanel;
    btnCancel: TSpeedButton;
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure CreateTable;
    procedure configFields;
  public
    connection: TFDConnection;
    table: TFDTable;
    dataSource: TDataSource;
    tableName, tableAction: String;
    itemId: Integer;
    procedure configForm;
  end;

var
  frmRegister: TfrmRegister;

implementation

uses uMain;

{$R *.dfm}

procedure TfrmRegister.btnCancelClick(Sender: TObject);
begin
  close;
end;

procedure TfrmRegister.btnSaveClick(Sender: TObject);
begin
  try
    table.FieldByName('name').AsString := edtName.Text;
    table.FieldByName('description').AsString := edtDesc.Text;

    table.Post;

    ShowMessage('Product registration successful!');
    close;
  except
    on E: Exception do
      ShowMessage('Error registering the product: ' + E.Message);
  end;

end;

procedure TfrmRegister.configFields;
begin
  edtName.dataSource := dataSource;
  edtName.DataField := 'name';

  edtDesc.dataSource := dataSource;
  edtDesc.DataField := 'description';
end;

procedure TfrmRegister.configForm;
begin
  CreateTable;
  configFields;

  if tableAction = 'edit' then
  begin
    table.Locate('id', itemId, []);
    table.Edit;
  end
  else if tableAction = 'insert' then
    table.Insert;

end;

procedure TfrmRegister.CreateTable;
begin
  // Create table
  table := TFDTable.Create(nil);
  table.connection := frmMain.mainConnection;

  table.tableName := tableName;

  // Create Data Source
  dataSource := TDataSource.Create(Self);
  dataSource.DataSet := table;

  table.Open;
end;

procedure TfrmRegister.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmRegister.FormDestroy(Sender: TObject);
begin
  frmRegister := nil;
end;

end.
