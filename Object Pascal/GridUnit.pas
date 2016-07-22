//Version: 21May2003

unit GridUnit;

interface
 uses Classes,Controls,ExtCtrls,GridCellUnit;

 type TGrid=class(TPanel)
  private
   fRows,fCols:integer;
   fCurrentStep:integer;
  public
   constructor Create(theParent:TWinControl;theRows,theCols:integer);
   procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
   function findCell(const theRow,theCol:integer):TGridCell; overload;
   function findCell(const theStep:integer):TGridCell; overload;
   function findCell(const theStartIndex:integer;const theCellType:TCellType):TGridCell; overload;
   function findStart:TGridCell; overload;
   function findStart(const theStartIndex:integer):TGridCell; overload;
   function findGoal:TGridCell; overload;
   function findGoal(const theStartIndex:integer):TGridCell; overload;
   function hasSingleStart:boolean;
   function hasGoal:boolean;
   procedure reset;
  published
   property rows:integer read fRows;
   property cols:integer read fCols;
   property currentStep:integer read fCurrentStep write fCurrentStep default 0;
 end;

implementation
 uses Graphics, SysUtils;

constructor TGrid.Create;
var row,col:integer;
begin
 inherited Create(theParent); //considering parent as owner
 parent:=theParent;
 currentStep:=0;
 fRows:=theRows;
 fCols:=theCols;
 for row:=1 to theRows do
  for col:=1 to theCols do
   TGridCell.Create(self,row,col);
 setBounds(0,0,parent.width,parent.height);
end;

procedure TGrid.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var row,col:integer;
    b:TGridCell;
    w,h:integer;
begin
 inherited;

 if parent=nil then exit;

 w:=ClientWidth div cols;
 h:=ClientHeight div rows;
 for row:=1 to rows do
  for col:=1 to cols do
   begin
    b:=findCell(row,col);
    b.width:=w;
    b.height:=h;
    b.top:=(row-1)*h;
    b.left:=(col-1)*w;
   end;
end;

function TGrid.findCell(const theRow,theCol:integer):TGridCell;
var i:integer;
    c:TComponent;
    b:TGridCell;
begin
 for i:=0 to ComponentCount-1 do
  begin
  c:=Components[i];
  if c is TGridCell then
   begin
   b:=c as TGridCell;
   with b do
    if (row=theRow) and (col=theCol) then
     begin
     result:=b;
     exit;
     end;
   end;
  end;
 result:=nil;
end;

function TGrid.findCell(const theStep:integer):TGridCell;
var i:integer;
    c:TComponent;
    b:TGridCell;
begin
 for i:=0 to ComponentCount-1 do
  begin
  c:=Components[i];
  if c is TGridCell then
   begin
   b:=c as TGridCell;
   if b.step=theStep then
    begin
    result:=b;
    exit;
    end;
   end;
  end;
 result:=nil;
end;

function TGrid.findCell(const theStartIndex:integer;const theCellType:TCellType):TGridCell;
var i:integer;
    c:TComponent;
    b:TGridCell;
begin
 for i:=theStartIndex to ComponentCount-1 do
  begin
  c:=Components[i];
  if c is TGridCell then
   begin
   b:=c as TGridCell;
   if b.cellType=theCellType then
    begin
    result:=b;
    exit;
    end;
   end;
  end;
 result:=nil;
end;

/////////////

function TGrid.findStart(const theStartIndex:integer):TGridCell;
begin
 result:=findCell(theStartIndex,ctStart);
end;

function TGrid.findStart:TGridCell;
begin
 result:=findStart(0);
end;

/////////////

function TGrid.findGoal(const theStartIndex:integer):TGridCell;
begin
 result:=findCell(theStartIndex,ctGoal);
end;

function TGrid.findGoal:TGridCell;
begin
 result:=findGoal(0);
end;

/////////////

procedure TGrid.reset;
var i:integer;
    c:TComponent;
begin
 currentStep:=0;

 for i:=0 to ComponentCount-1 do
  begin
  c:=Components[i];
  if c is TGridCell then
   with (c as TGridCell) do
    if cellType=ctSearched then reset; //the cell, not the grid
  end;
end;

function TGrid.hasSingleStart:boolean;
var b:TGridCell;
begin
 b:=findStart;
 result:=(b<>nil) and (findStart(b.ComponentIndex+1)=nil);
end;

function TGrid.hasGoal:boolean;
begin
 result:=(findGoal<>nil);
end;

end.
