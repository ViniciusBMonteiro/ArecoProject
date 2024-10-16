unit uConfigDb;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.Buttons, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.VCLUI.Login, FireDAC.Comp.UI, FireDAC.Phys.PGDef,
  FireDAC.Phys.PG, XMLDoc, XMLIntf, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TfrmConfigDb = class(TForm)
    Panel1: TPanel;
    edtDb: TLabeledEdit;
    edtServer: TLabeledEdit;
    edtPort: TLabeledEdit;
    Panel2: TPanel;
    btnConfirm: TSpeedButton;
    DriverLink: TFDPhysPgDriverLink;
    qryCreateTable: TFDQuery;
    procedure btnConfirmClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    connectionConfig: String;
    procedure SaveConnectionInfo(const FileName: string);
    procedure LoadConnectionInfo(const FileName: string);
    procedure createTable;
  public
    mainConnection: TFDConnection;
  end;

var
  frmConfigDb: TfrmConfigDb;

implementation

{$R *.dfm}

uses uMain;

procedure TfrmConfigDb.createTable;
begin
 qryCreateTable.Connection := frmMain.mainConnection;

  qryCreateTable.ExecSQL;

end;

procedure TfrmConfigDb.FormCreate(Sender: TObject);
var
  projectPath: String;
  InfoList: TStringList;
  XMLDoc: IXMLDocument;
  RootNode, ChildNode: IXMLNode;
begin
  projectPath := ExtractFileDir
    (ExtractFileDir(ExtractFileDir(ExtractFilePath(Application.ExeName))));

  DriverLink.VendorHome := projectPath;

  connectionConfig := projectPath + '\connectionConfig.xml';

  if FileExists(connectionConfig) then
    LoadConnectionInfo(connectionConfig)
  else
    ShowModal;

end;

procedure TfrmConfigDb.LoadConnectionInfo(const FileName: string);
var
  XMLDoc: IXMLDocument;
  RootNode, ChildNode: IXMLNode;
  FDQuery: TFDQuery;
  TableExists: Boolean;
begin
  XMLDoc := LoadXMLDocument(FileName);
  RootNode := XMLDoc.DocumentElement;

  ChildNode := RootNode.ChildNodes.FindNode('DriverName');
  if Assigned(ChildNode) then
    frmMain.mainConnection.DriverName := ChildNode.Text;

  ChildNode := RootNode.ChildNodes.FindNode('Database');
  if Assigned(ChildNode) then
    frmMain.mainConnection.Params.Database := ChildNode.Text;

  ChildNode := RootNode.ChildNodes.FindNode('Server');
  if Assigned(ChildNode) then
    frmMain.mainConnection.Params.Values['Server'] := ChildNode.Text;

  ChildNode := RootNode.ChildNodes.FindNode('Port');
  if Assigned(ChildNode) then
    frmMain.mainConnection.Params.Values['Port'] := ChildNode.Text;

  frmMain.mainConnection.Connected := True;

  try
    FDQuery := TFDQuery.Create(nil);

    FDQuery.Connection := frmMain.mainConnection;

    FDQuery.SQL.Text :=
      'SELECT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = :TableName)';
    FDQuery.ParamByName('TableName').AsString := 'productreg';
    FDQuery.Open;
    TableExists := FDQuery.Fields[0].AsBoolean;
    if not TableExists then
      createTable;
  finally
    FDQuery.Free;
  end;

end;

procedure TfrmConfigDb.SaveConnectionInfo(const FileName: string);
var
  XMLDoc: IXMLDocument;
  RootNode, ChildNode: IXMLNode;
begin
  XMLDoc := NewXMLDocument;
  XMLDoc.Options := [doNodeAutoIndent];
  RootNode := XMLDoc.AddChild('ConnectionInfo');

  ChildNode := RootNode.AddChild('DriverName');
  ChildNode.Text := 'PG';

  ChildNode := RootNode.AddChild('Database');
  ChildNode.Text := edtDb.Text;

  ChildNode := RootNode.AddChild('Server');
  ChildNode.Text := edtServer.Text;

  ChildNode := RootNode.AddChild('Port');
  ChildNode.Text := edtPort.Text;

  XMLDoc.SaveToFile(FileName);
end;

procedure TfrmConfigDb.btnConfirmClick(Sender: TObject);
var
  loginDialog: TFDGUIxLoginDialog;
begin
  SaveConnectionInfo(connectionConfig);

  LoadConnectionInfo(connectionConfig);

  close;

end;

end.
