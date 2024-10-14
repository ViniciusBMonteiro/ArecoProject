unit uDBConnection;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Comp.Client;

type
  TDBConnection = class
  private
    FConnection: TFDConnection;
  public
    constructor Create;
    destructor Destroy; override;
    property Connection: TFDConnection read FConnection;
  end;

implementation

{ TDBConnection }

constructor TDBConnection.Create;
begin
  FConnection := TFDConnection.Create(nil);
  FConnection.DriverName := 'PG';
  FConnection.Params.Database := 'dbArcoProject';
  FConnection.Params.UserName := 'vbmonteiro';
  FConnection.Params.Password := '260118';
  FConnection.Params.Add('Server=localhost');
  FConnection.LoginPrompt := False;
  FConnection.Connected := True;
end;

destructor TDBConnection.Destroy;
begin
  FConnection.Free;
  inherited;
end;

end.
