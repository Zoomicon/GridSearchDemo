//Version: 26May2003

unit GridCellList;

interface
 uses GridCell;

 type

  TGridCellListItem=class
   protected //only accessible in this module and in any descendent class of TGridCellListItem
    fPrevious:TGridCellListItem; //will be nil if no previous
    cell:TGridCell;
    fNext:TGridCellListItem; //will be nil if no next
    constructor Create(theCell:TGridCell);
    procedure setPrevious(thePathStep:TGridCellListItem);
    procedure setNext(thePathStep:TGridCellListItem);
    property previous:TGridCellListItem read fPrevious write setPrevious;
    property next:TGridCellListItem read fNext write setNext;
   end;

  TGridCellList=class
   private
    fStart:TGridCellListItem;
    fEnd:TGridCellListItem;
   protected
    procedure setStart(thePathStep:TGridCellListItem);
    procedure setEnd(thePathStep:TGridCellListItem);
    property start:TGridCellListItem read fStart write setStart;
    property ending:TGridCellListItem read fEnd write setEnd;
   public
    constructor Create;
    procedure prepend(theCell:TGridCell);
    procedure append(theCell:TGridCell);
    function popStart:TGridCell;
    function popEnd:TGridCell;
    function peekStart:TGridCell; //get cell without removing from path
    function peekEnd:TGridCell;   //  >>
   end;

implementation

 //TGridCellListItem//

 constructor TGridCellListItem.Create(theCell:TGridCell);
 begin
  cell:=theCell;
 end;

 procedure TGridCellListItem.setPrevious(thePathStep: TGridCellListItem);
 begin
  fPrevious:=thePathStep;
  if thePathStep<>nil then thePathStep.fNext:=self;
 end;

 procedure TGridCellListItem.setNext(thePathStep: TGridCellListItem);
 begin
  fNext:=thePathStep;
  if thePathStep<>nil then thePathStep.fPrevious:=self;
 end;

 //TGridCellList//

 constructor TGridCellList.Create;
 begin
  fStart:=nil;
  fEnd:=nil;
 end;

 procedure TGridCellList.setStart(thePathStep:TGridCellListItem);
 begin
  if thePathStep=nil
   then
    begin
    //if fStart<>nil then fStart.free;
    //if fEnd<>nil then fEnd.free; //don't use dispose, cause if fStart=fEnd it would fail when disposing the object twice (free instead is OK if object is already disposed or nil)
    fStart:=nil;
    fEnd:=nil;
    end
   else
    begin
    thePathStep.previous:=nil;
    fStart:=thePathStep;
    if fEnd=nil then fEnd:=fStart;
    end;
 end;

 procedure TGridCellList.setEnd(thePathStep:TGridCellListItem);
 begin
  if thePathStep=nil //!!! should do free on the list in this case !!!
   then
    begin
    fStart.free;
    fEnd.free; //don't use dispose, cause if fStart=fEnd it would fail when disposing the object twice (free instead is OK if object is already disposed or nil)
    fStart:=nil;
    fEnd:=nil;
    end
   else
    begin
    thePathStep.previous:=fEnd;
    fEnd:=thePathStep;
    if fStart=nil then fStart:=fEnd;
    end;
 end;

 procedure TGridCellList.prepend(theCell:TGridCell);
 var ps:TGridCellListItem;
 begin
  ps:=TGridCellListItem.create(theCell);
  if fStart<>nil then fStart.previous:=ps;
  setStart(ps);
 end;

 procedure TGridCellList.append(theCell:TGridCell);
 var ps:TGridCellListItem;
 begin
  ps:=TGridCellListItem.create(theCell);
  if fEnd<>nil then fEnd.next:=ps;
  setEnd(ps);
 end;

 function TGridCellList.popStart:TGridCell;
 var ps:TGridCellListItem;
 begin
  if start=nil then
   result:=nil
  else
   begin
   ps:=start;
   result:=ps.cell;
   setStart(ps.next);
   ps.free;
   end;
 end;

 function TGridCellList.popEnd:TGridCell;
 var ps:TGridCellListItem;
 begin
  if start=nil then
   result:=nil
  else
   begin
   ps:=ending;
   result:=ps.cell;
   setEnd(ps.previous);
   ps.free;
   end;
 end;

 function TGridCellList.peekStart:TGridCell;
 begin
  if start=nil
   then result:=nil
   else result:=start.cell;
 end;

 function TGridCellList.peekEnd:TGridCell;
 begin
  if ending=nil
   then result:=nil
   else result:=ending.cell;
 end;

end.
