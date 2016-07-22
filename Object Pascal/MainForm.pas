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
    procedure btnMakeGridClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
  private
   grid:TGrid;
  public
   procedure search;
   function searchCell(c:TGridCell):boolean; overload;
   function searchCell(row,col:integer):boolean; overload;
  end;

var Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.search;
var c:TGridCell;
begin
 if grid=nil then exit;
 with grid do
  begin
  c:=findStart();
  currentStep:=0;
  if searchCell(c)
   then ShowMessage('found in '+intToStr(currentStep)+' steps')
   else ShowMessage('not found');
  end;
end;

function TForm1.searchCell(c:TGridCell):boolean;
begin
 if c=nil then
  begin
  result:=false;
  exit;
  end;

 with c do
  begin
   if cellType=Goal then
    begin
    grid.currentStep:=grid.currentStep+1;
    result:=true;
    end
   else if (cellType=Empty) or ((grid.currentStep=0) and (cellType=Start)) then
    begin
    grid.currentStep:=grid.currentStep+1;
    c.step:=grid.currentStep; //will mark the cell as searched
    result:=
     searchCell(c.row,c.col+1) or
     searchCell(c.row-1,c.col) or
     searchCell(c.row,c.col-1) or
     searchCell(c.row+1,c.col);
    end
   else
    result:=false;
  end;
end;

function TForm1.searchCell(row,col:integer):boolean;
var c:TGridCell;
begin
 c:=grid.findCell(row,col);
 if c<>nil then
  result:=searchCell(c)
 else
  result:=false;
end;

procedure TForm1.btnMakeGridClick(Sender: TObject);
begin
 if grid<>nil then grid.free;
 grid:=TGrid.Create(MainPanel,strToInt(edRows.text),strToInt(edCols.text));
end;

procedure TForm1.btnSearchClick(Sender: TObject);
begin
 search;
end;

procedure TForm1.btnResetClick(Sender: TObject);
begin
 if grid<>nil then grid.reset;
end;

end.
