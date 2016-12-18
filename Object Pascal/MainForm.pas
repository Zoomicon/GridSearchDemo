//Project: GridSearchDemo (http://github.com/Zoomicon/GridSearchDemo)
//Author: George Birbilis
//Version: 18Dec2016

unit MainForm;

interface

  uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, GridCell,
    Buttons, StdCtrls, ExtCtrls, Grid, ComCtrls,
    GridSearchAlgorithm;

  type TForm1 = class(TForm)
    published
      Panel1: TPanel;
      edCols: TEdit;
      Label1: TLabel;
      edRows: TEdit;
      btnMakeGrid: TButton;
      MainPanel: TPanel;
      btnSearch: TButton;
      btnReset: TButton;
      cbAlgorithm: TComboBox;
      sldDelay: TTrackBar;
      Label2: TLabel;
      btnHelp: TButton;
      procedure btnMakeGridClick(Sender: TObject);
      procedure btnSearchClick(Sender: TObject);
      procedure btnResetClick(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure sldDelayChange(Sender: TObject);
      procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
      procedure btnHelpClick(Sender: TObject);
    private
      grid:TGrid;
      algorithm:TGridSearchAlgorithm;
    public
      procedure MakeGrid;
      procedure Search;
      procedure Reset;
      procedure Demo;
  end;

  var Form1: TForm1;

implementation
  uses DepthFirstSearchAlgorithm,
       BreadthFirstSearchAlgorithm,
       BestFirstSearchAlgorithm;

{$R *.DFM}

//Methods//

  procedure TForm1.MakeGrid();
  begin
    if grid<>nil then grid.free;
    grid:=TGrid.Create(MainPanel,strToInt(edRows.text),strToInt(edCols.text));
  end;

  procedure TForm1.Search();
  begin
   btnReset.click;

   if not grid.hasSingleStart then
     begin
     ShowMessage('Must define one (and only) Start cell, using the "S" symbol (click on a cell many times till it writes "S")');
     exit;
     end;

   With cbAlgorithm do
     begin
     if Text='' then exit; //just for safety
     case ItemIndex of
       0: algorithm:=TDepthFirstSearchAlgorithm.Create(grid);
       1: algorithm:=TBreadthFirstSearchAlgorithm.Create(grid);
       2: algorithm:=TBestFirstSearchAlgorithm.Create(grid);
       else exit;
       end;
     end;

   algorithm.search;
   if algorithm<>nil then
     begin
     algorithm.free;
     algorithm:=nil;
     end;
  end;

  procedure TForm1.Reset();
  begin
    if grid<>nil then grid.reset;
  end;

  procedure TForm1.Demo();
  begin
    edRows.text:='10';
    edCols.text:='10';
    btnMakeGrid.Click;
    cbAlgorithm.ItemIndex:=0;
    with grid do
      begin
      findCell(1,2).cellType:=ctObstacle;
      findCell(1,4).cellType:=ctGoal;
      findCell(1,6).cellType:=ctObstacle;
      findCell(2,2).cellType:=ctObstacle;
      findCell(2,3).cellType:=ctObstacle;
      findCell(2,4).cellType:=ctObstacle;
      findCell(2,6).cellType:=ctObstacle;
      findCell(3,2).cellType:=ctObstacle;
      findCell(3,6).cellType:=ctObstacle;
      findCell(3,8).cellType:=ctObstacle;
      findCell(3,9).cellType:=ctObstacle;
      findCell(3,8).cellType:=ctObstacle;
      findCell(4,6).cellType:=ctObstacle;
      findCell(4,8).cellType:=ctObstacle;
      findCell(4,9).cellType:=ctObstacle;
      findCell(5,9).cellType:=ctObstacle;
      findCell(6,3).cellType:=ctObstacle;
      findCell(6,4).cellType:=ctObstacle;
      findCell(6,5).cellType:=ctObstacle;
      findCell(6,6).cellType:=ctObstacle;
      findCell(7,3).cellType:=ctObstacle;
      findCell(7,7).cellType:=ctObstacle;
      findCell(8,3).cellType:=ctObstacle;
      findCell(8,7).cellType:=ctObstacle;
      findCell(9,6).cellType:=ctStart;
      end;
  end;

//Events//

  procedure TForm1.btnMakeGridClick(Sender: TObject);
  begin
    MakeGrid();
  end;

  procedure TForm1.btnSearchClick(Sender: TObject);
  begin
    Search();
  end;

  procedure TForm1.btnResetClick(Sender: TObject);
  begin
    Reset();
  end;

  procedure TForm1.FormCreate(Sender: TObject);
  begin
    Demo;
  end;

  procedure TForm1.sldDelayChange(Sender: TObject);
  begin
    cellFlashDelay:=sldDelay.Position;
  end;

  procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  begin
    if algorithm<>nil then algorithm.stopped:=true;
  end;

  procedure TForm1.btnHelpClick(Sender: TObject);
  begin
    ShowMessage('Grid Search Demo' + #13 +
                '(C)opyright 2003 - George Birbilis (birbilis@kagi.com)' + #13 +
                #13 +
                'Left click to change cell type, right click to clear cell');
  end;

end.

