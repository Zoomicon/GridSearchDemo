//Version: 21May2003

unit DepthFirstSearchAlgorithm;

interface
 uses GridCellUnit, GridSearchAlgorithm;

 type TDepthFirstSearchAlgorithm=class(TGridSearchAlgorithm)
   protected
    function searchCell(c:TGridCell):boolean; overload;
    function searchCell(row,col:integer):boolean; overload;
   public
    procedure search; override;
   end;

implementation
 uses SysUtils,Dialogs;

procedure TDepthFirstSearchAlgorithm.search;
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

function TDepthFirstSearchAlgorithm.searchCell(c:TGridCell):boolean;
begin
 if c=nil then
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
   else if (cellType=ctEmpty) or ((grid.currentStep=0) and (cellType=ctStart)) then
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
 else
  result:=false;
end;

end.
