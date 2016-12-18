//Project: GridSearchDemo (http://github.com/Zoomicon/GridSearchDemo)
//Author: George Birbilis
//Version: 18Dec2016

unit BestFirstSearchAlgorithm;

interface
  uses GridCell, GridSearchAlgorithm, GridCellList, Grid;

  type TBestFirstSearchAlgorithm=class(TGridSearchAlgorithm)
    protected
      backtracking:boolean;
      checkLaterList:TGridCellList;
      goal:TGridCell;
      function searchCell(c:TGridCell):boolean; overload;
      function searchCell(row,col:integer; currentDistance2:double):boolean; overload;
      function searchNeighbours(c:TGridCell):boolean;
      function getBestNeighbour(c:TGridCell):TGridCell;
      function distance2(c1,c2:TGridCell):double; virtual;
    public
      constructor Create(theGrid:TGrid); override;
      destructor Destroy;override;
      procedure search; override;
  end;

implementation
  uses SysUtils, Dialogs, Forms, Windows;

  constructor TBestFirstSearchAlgorithm.Create(theGrid:TGrid);
  begin
    inherited; //call ancestor's constructor first
    checkLaterList:=TGridCellList.Create;
  end;

  destructor TBestFirstSearchAlgorithm.Destroy();
  begin
    checkLaterList.Free;
    goal:=nil;
    inherited; //call ancestor's destructor last
  end;

  procedure TBestFirstSearchAlgorithm.search;
  var
    c:TGridCell;
    b:boolean;
  begin
    if grid=nil then
      begin
      ShowMessage('Missing grid');
      exit;
      end;

    with grid do
      begin

      goal:=findGoal;
      if goal=nil then
        begin
        ShowMessage('have to know where goal is cause using straight line distance towards it as a measure to choose best next cell to move to');
        exit;
        end;

      currentStep:=0;
      b:=searchCell(findStart());
      while (not stopped) and (not b) and (checkLaterList.peekStart<>nil) do
        begin
        backtracking:=false;
        c:=checkLaterList.popStart;
        if c.cellType=ctEmpty then
          begin
          currentStep:=currentStep+1;
          c.step:=currentStep;
          end;
        b:=searchCell(getBestNeighbour(c));
        end;

      if not stopped then
        if b
          then ShowMessage('found in '+intToStr(currentStep)+' steps')
          else ShowMessage('not found');
      end;
  end;

  function TBestFirstSearchAlgorithm.searchCell(c:TGridCell):boolean;
  begin
    Application.processMessages; //don't freeze application's GUI

   if stopped or (c=nil) then
     begin
     result:=false;
     exit;
     end;

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
       result:=searchNeighbours(c);
       end
     else
       result:=false;
    end;
  end;

  function TBestFirstSearchAlgorithm.searchNeighbours(c:TGridCell):boolean;
  var currentDistance2:double;
  begin
    if c=nil then
      begin
      result:=false;
      exit;
      end;

    with c do
      begin
      currentDistance2:=distance2(c,goal);
      result:=
        searchCell(row,col+1,currentDistance2) or
        searchCell(row-1,col,currentDistance2) or
        searchCell(row,col-1,currentDistance2) or
        searchCell(row+1,col,currentDistance2);
      if not result then
        begin
        if not backtracking and grid.hasEmptyNeighbours(c) then checkLaterList.append(c);
        backtracking:=true;
        end;
      end;
  end;

  function TBestFirstSearchAlgorithm.searchCell(row,col:integer; currentDistance2:double):boolean;
  var c:TGridCell;
  begin
    c:=grid.findCell(row,col);
    if (c<>nil) and (distance2(c,goal)<currentDistance2) then
      begin
      c.flash;
      backtracking:=false;
      result:=searchCell(c);
      end
    else
      result:=false;
  end;

  function TBestFirstSearchAlgorithm.distance2(c1,c2:TGridCell):double;
  begin
    if (c1=nil) or (c2=nil)
      then result:=10000000000000
      else result:=sqr(c1.row-c2.row)+sqr(c1.col-c2.col);
  end;

  function TBestFirstSearchAlgorithm.getBestNeighbour(c:TGridCell):TGridCell;
  var
    d2,d2a:double;
    cn:TGridCell;
  begin
    with c do
      begin
      result:=grid.findEmptyCell(row,col+1);
      d2:=distance2(result,goal);

      cn:=grid.findEmptyCell(row-1,col);
      d2a:=distance2(cn,goal);
      if d2a<d2 then begin result:=cn; d2:=d2a; end;

      cn:=grid.findEmptyCell(row,col-1);
      d2a:=distance2(cn,goal);
      if d2a<d2 then begin result:=cn; d2:=d2a; end;

      cn:=grid.findEmptyCell(row+1,col);
      d2a:=distance2(cn,goal);
      if d2a<d2 then result:=cn;
      end;
end; //may return nil if all neighbours are not allowed

end.

