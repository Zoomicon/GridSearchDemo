//Version: 21May2003

unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, GridCellUnit,
  Buttons, StdCtrls, ExtCtrls, GridUnit;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    edCols: TEdit;
    Label1: TLabel;
    edRows: TEdit;
    btnMakeGrid: TButton;
    MainPanel: TPanel;
    btnSearch: TButton;
    btnReset: TButton;
    cbAlgorithm: TComboBox;
    procedure btnMakeGridClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
   grid:TGrid;
  end;

var Form1: TForm1;

implementation
 uses GridSearchAlgorithm,
      DepthFirstSearchAlgorithm,
      BreadthFirstSearchAlgorithm;

{$R *.DFM}

procedure TForm1.btnMakeGridClick(Sender: TObject);
begin
 if grid<>nil then grid.free;
 grid:=TGrid.Create(MainPanel,strToInt(edRows.text),strToInt(edCols.text));
end;

procedure TForm1.btnSearchClick(Sender: TObject);
var algorithm:TGridSearchAlgorithm;
begin
 btnReset.click;

 if not grid.hasSingleStart then
  begin
  ShowMessage('Must define one (and only) Start cell, using the "S" symbol (click on a cell many times till it writes "S")');
  exit;
  end;

 if not grid.hasGoal then
  begin
  ShowMessage('Must define at least one Goal cell, using the "G" symbol (click on a cell many times till it writes "G")');
  exit;
  end;

 With cbAlgorithm do
  begin
  if Text='' then exit; //just for safety
  case ItemIndex of
   0: algorithm:=TDepthFirstSearchAlgorithm.Create(grid);
   1: algorithm:=TBreadthFirstSearchAlgorithm.Create(grid);
   else exit;
   end;
  end;
 algorithm.search;
 algorithm.free;
end;

procedure TForm1.btnResetClick(Sender: TObject);
begin
 if grid<>nil then grid.reset;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 edRows.text:='10';
 edCols.text:='10';
 btnMakeGrid.Click;
 cbAlgorithm.ItemIndex:=0;
end;

end.
