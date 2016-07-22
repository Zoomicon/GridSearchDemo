//Version: 21May2003

unit BreadthFirstSearchAlgorithm;

interface
 uses GridCellUnit, GridSearchAlgorithm;

 type TBreadthFirstSearchAlgorithm=class(TGridSearchAlgorithm)
   private
    searchBottom:integer;
   protected
    function checkNeighbours(c:TGridCell):boolean;overload;
    function checkNextLevel:boolean;
    function checkCell(row,column:integer):boolean;
   public
    procedure search; override;
   end;

implementation
 uses SysUtils,Dialogs;

procedure TBreadthFirstSearchAlgorithm.search;
var c:TGridCell;
begin
 if grid=nil then exit;
 with grid do
  begin
  c:=findStart();
  currentStep:=0;
  searchBottom:=0;
  if checkNeighbours(c)
   then ShowMessage('found in '+intToStr(currentStep)+' steps')
   else ShowMessage('not found');
  end;
end;

function TBreadthFirstSearchAlgorithm.checkNeighbours(c:TGridCell):boolean;
begin
 result:=
  checkCell(c.row,c.col+1) or
  checkCell(c.row-1,c.col) or
  checkCell(c.row,c.col-1) or
  checkCell(c.row+1,c.col) or
  checkNextLevel;
end;

function TBreadthFirstSearchAlgorithm.checkNextLevel:boolean;
var c:TGridCell;
begin
 searchBottom:=searchBottom+1;
 c:=grid.findCell(searchBottom); //could have used a stack to keep those cells
 if c<>nil then
  begin
  c.flash;
  result:=checkNeighbours(c);
  end
 else
  result:=false;
end;

function TBreadthFirstSearchAlgorithm.checkCell(row,column:integer):boolean;
var c:TGridCell;
begin
 c:=grid.findCell(row,column);

 if c=nil then
  begin
  result:=false;
  exit;
  end;

 c.flash;

 with c do
  begin
  if cellType=ctGoal then
  begin
   grid.currentStep:=grid.currentStep+1;
   step:=grid.currentStep;
   result:=true;
   exit;
   end;

  if cellType=ctEmpty then
   begin
   grid.currentStep:=grid.currentStep+1;
   step:=grid.currentStep; //will mark cell as searched
   result:=false;
   exit;
   end;
 end;

 result:=false;
end;

end.