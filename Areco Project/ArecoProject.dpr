program ArecoProject;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  uRegister in 'uRegister.pas' {frmRegister},
  uDBConnection in 'uDBConnection.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
