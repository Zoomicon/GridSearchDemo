program GridSearchDemo;

uses
  Forms,
  MainForm in 'MainForm.pas' {Form1},
  GridCellList in 'grid\GridCellList.pas',
  GridCell in 'grid\GridCell.pas',
  Grid in 'grid\Grid.pas',
  GridSearchAlgorithm in 'algorithms\GridSearchAlgorithm.pas',
  BreadthFirstSearchAlgorithm in 'algorithms\BreadthFirstSearchAlgorithm.pas',
  DepthFirstSearchAlgorithm in 'algorithms\DepthFirstSearchAlgorithm.pas',
  BestFirstSearchAlgorithm in 'algorithms\BestFirstSearchAlgorithm.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Grid Search Demo';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
