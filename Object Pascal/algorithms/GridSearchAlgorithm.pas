//Version: 21May2003

unit GridSearchAlgorithm;

interface
 uses Grid;

 type
  TGridSearchAlgorithm=class
   protected
    grid:TGrid;
   public
    stopped:boolean;
    constructor Create(theGrid:TGrid); virtual;
    procedure search; virtual; abstract;
   end;

implementation

constructor TGridSearchAlgorithm.Create;
begin
 grid:=theGrid;
end;

end.
