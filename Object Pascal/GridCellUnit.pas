unit GridCellUnit;

interface
 uses Classes,Controls,ExtCtrls;

 type TCellType=(Empty,Obstacle,Start,Goal,Searched);

 type TGridCell=class(TPanel)
  private
   fRow,fCol:integer;
   fStep:integer;
   fCellType: TCellType;
  protected
   procedure setCellType(const Value: TCellType);
   procedure setStep(const Value: integer);
   class procedure CellMouseDown(Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
  public
   constructor Create(theParent:TWinControl; theRow,theCol:integer);
  published
   property row:integer read fRow write fRow;
   property col:integer read fCol write fCol;
   property step:integer read fStep write setStep default 0;
   property cellType:TCellType read fCellType write setCellType;
 end;

implementation
 uses Graphics, SysUtils;

constructor TGridCell.Create;
begin
 inherited Create(theParent); //considering parent as owner
 parent:=theParent;
 row:=theRow;
 col:=theCol;
 step:=0;
 cellType:=Empty;
 font.size:=18;
 OnMouseDown:=CellMouseDown;
end;

procedure TGridCell.setCellType(const Value: TCellType);
begin
 fCellType:=Value;
 case value of
  Empty: begin text:=''; color:=clWhite; end;
  Obstacle: begin text:=''; color:=clDkGray; end;
  Start: begin text:='S'; color:=clWhite; end;
  Goal: begin text:='G'; color:=clWhite; end;
  Searched: begin text:=intToStr(step); color:=clRed; end;
  end;
end;

procedure TGridCell.setStep(const Value: integer);
begin
 fStep := Value;
 if cellType=Empty then cellType:=Searched;
end;

class procedure TGridCell.CellMouseDown(Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
begin
 With Sender As TGridCell do
  begin
   if button=mbRight then
    cellType:=Empty
   else
    case cellType of
     Empty: cellType:=Obstacle;
     Obstacle: cellType:=Start;
     Start: cellType:=Goal;
     Goal: cellType:=Empty;
     end;
  end;
end;

end.
