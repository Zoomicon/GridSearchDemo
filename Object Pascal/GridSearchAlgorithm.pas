//Version: 21May2003

unit GridSearchAlgorithm;

interface
 uses GridUnit;

 type
  TGridSearchAlgorithm=class
   protected
    grid:TGrid;
   public
    constructor Create(theGrid:TGrid);
    procedure search; virtual; abstract;
   end;

implementation

constructor TGridSearchAlgorithm.Create;
begin
 grid:=theGrid;
end;

end.
