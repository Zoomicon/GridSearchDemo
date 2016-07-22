program GridSearchDemo;

uses
  Forms,
  MainForm in 'MainForm.pas' {Form1},
  GridCellUnit in 'GridCellUnit.pas',
  GridUnit in 'GridUnit.pas',
  GridSearchAlgorithm in 'GridSearchAlgorithm.pas',
  DepthFirstSearchAlgorithm in 'DepthFirstSearchAlgorithm.pas',
  BreadthFirstSearchAlgorithm in 'BreadthFirstSearchAlgorithm.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Grid Search Demo';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
