program ArecoProject;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  uRegister in 'uRegister.pas' {frmRegister},
  uDBConnection in 'uDBConnection.pas',
  uConfigDb in 'uConfigDb.pas' {frmConfigDb};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
