program GridSearchDemo;

uses
  Forms,
  MainForm in 'MainForm.pas' {Form1},
  GridCellUnit in 'GridCellUnit.pas',
  GridUnit in 'GridUnit.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
