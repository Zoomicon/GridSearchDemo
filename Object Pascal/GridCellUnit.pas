//Version: 21May2003

unit GridCellUnit;

interface
 uses Classes,Controls,ExtCtrls;

 type TCellType=(ctEmpty,ctObstacle,ctStart,ctGoal,ctSearched);

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
   procedure reset;
   procedure flash;
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
 cellType:=ctEmpty;
 font.size:=18;
 OnMouseDown:=CellMouseDown;
end;

procedure TGridCell.setCellType(const Value: TCellType);
begin
 fCellType:=Value;
 case value of
  ctEmpty: begin text:=''; color:=clWhite; end;
  ctObstacle: begin text:=''; color:=clDkGray; end;
  ctStart: begin text:='S'; color:=clWhite; end;
  ctGoal: begin text:='G'; color:=clWhite; end;
  ctSearched: begin text:=intToStr(step); color:=clRed; end;
  end;
end;

procedure TGridCell.setStep(const Value: integer);
begin
 fStep := Value;
 if cellType=ctEmpty then cellType:=ctSearched;
end;

procedure TGridCell.reset;
begin
 step:=0;
 cellType:=ctEmpty;
end;

procedure TGridCell.flash;
var i:integer;
begin
 for i:=0 to 100000 do color:=clYellow;
 repaint;
 parent.Repaint;
 for i:=0 to 100000 do cellType:=cellType;
 repaint;
 parent.Repaint;
end;

//

class procedure TGridCell.CellMouseDown(Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
const lastmanualstep:integer=0; //allow user to turn cells to manually number cells by CTRL+Clicking them
begin
 With Sender As TGridCell do
  begin

  If ssShift In Shift then lastmanualstep:=0; //can CTRL+SHIFT+Click for setting the first cell's number

  If ssCtrl In Shift then
   begin
    if cellType=ctEmpty Then
     begin
      lastmanualstep:=lastmanualstep+1;
      step:=lastmanualstep;
     end
   end

   else

   if button=mbRight then
    cellType:=ctEmpty
   else
    case cellType of
     ctEmpty: cellType:=ctObstacle;
     ctObstacle: cellType:=ctStart;
     ctStart: cellType:=ctGoal;
     ctGoal: cellType:=ctEmpty;
     end;
  end;
end;

end.
