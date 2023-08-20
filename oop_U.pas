// Joshua Le Roux
unit oop_U;

interface

uses SysUtils;

type

  TAnimals = class(TObject)

  private
  var
    // Provided code
    fAnimal, fStatus, fContinent: String;

  public
    // Self defined code
    constructor create(sAnimal, sStatus, sContinent :String);
    function toString:String;

  end;

implementation

{ TAnimals }

constructor TAnimals.create(sAnimal, sStatus, sContinent: String);  //receive values from Animals_U
begin
  fAnimal := sAnimal;
  fStatus := sStatus;
  fContinent := sContinent;
end;

function TAnimals.toString: String;   //formats received values as paragraph (str)
var
  par :String;
begin
  par := 'The ' + fAnimal + ' lives in ' + fContinent + '.' + #13 + 'They are currently listed as ' + uppercase(fStatus) + '.';
  Result := par;
end;

end.
