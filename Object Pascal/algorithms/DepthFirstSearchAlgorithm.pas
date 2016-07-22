//Version: 26May2003

unit DepthFirstSearchAlgorithm;

interface
 uses GridCell, GridSearchAlgorithm;

 type TDepthFirstSearchAlgorithm=class(TGridSearchAlgorithm)
   protected
    function searchCell(c:TGridCell):boolean; overload;
    function searchCell(row,col:integer):boolean; overload;
   public
    procedure search; override;
   end;

implementation
 uses SysUtils, Dialogs, Forms;

procedure TDepthFirstSearchAlgorithm.search;
begin
 if grid=nil then
  begin
  ShowMessage('Missing grid');
  exit;
  end;

 with grid do
  begin
  currentStep:=0;
  if searchCell(findStart()) then
   if not stopped
    then ShowMessage('found in '+intToStr(currentStep)+' steps')
    else ShowMessage('not found');
  end;
end;

function TDepthFirstSearchAlgorithm.searchCell(c:TGridCell):boolean;
begin
 Application.processMessages; //don't freeze application's GUI

 if stopped or (c=nil) then
  begin
  result:=false;
  exit;
  end;

 //...add delay...

 with c do
  begin
   if cellType=ctGoal then
    begin
    step:=grid.currentStep; //will mark the cell as searched
    result:=true;
    end
   else if (cellType=ctEmpty) or
           ((grid.currentStep=0) and (cellType=ctStart)) then
    begin
    step:=grid.currentStep; //will mark the cell as searched
    grid.currentStep:=grid.currentStep+1;
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

function TDepthFirstSearchAlgorithm.searchCell(row,col:integer):boolean;
var c:TGridCell;
begin
 c:=grid.findCell(row,col);
 if c<>nil then
  begin
  c.flash;
  result:=searchCell(c);
  end
 else result:=false;
end;

end.
