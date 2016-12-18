//Project: GridSearchDemo (http://github.com/Zoomicon/GridSearchDemo)
//Author: George Birbilis
//Version: 18Dec2016

unit GridSearchAlgorithm;

interface
  uses Grid;

  type TGridSearchAlgorithm=class
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

