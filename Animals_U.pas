// Joshua Le Roux
unit Animals_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, DataModule_U, oop_U, Grids, DBGrids, ExtCtrls, jpeg, pngimage,
  StdCtrls;

type
  TfrmAnimals = class(TForm)
    imgPenguin: TImage;
    imgWDog: TImage;
    imgLion: TImage;
    imgButterfly: TImage;
    imgRhino: TImage;
    imgOrangutan: TImage;
    imgWhale: TImage;
    imgTurtle: TImage;
    imgShark: TImage;
    imgTuna: TImage;
    pnlInstructions: TPanel;
    imgBack: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgBackClick(Sender: TObject);
    procedure imgPenguinClick(Sender: TObject);
    procedure imgWDogClick(Sender: TObject);
    procedure imgRhinoClick(Sender: TObject);
    procedure imgWhaleClick(Sender: TObject);
    procedure imgSharkClick(Sender: TObject);
    procedure imgLionClick(Sender: TObject);
    procedure imgButterflyClick(Sender: TObject);
    procedure imgOrangutanClick(Sender: TObject);
    procedure imgTurtleClick(Sender: TObject);
    procedure imgTunaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AnimalClick;
  end;

var
  frmAnimals: TfrmAnimals;
  animal  :String;
  frmObject :TfrmAnimals;
  objAnimals :TAnimals;

implementation
uses
  Home_U;

{$R *.dfm}

procedure TfrmAnimals.AnimalClick;
var
  sStatus, sContinent :String;
  found :Integer;
begin
  found := 0;
  with DM do
    begin
      ADOTableA.First;
      while (not ADOTableA.EOF) OR (found = 0) do
        begin
          if ADOTableA['Animal'] = animal then  //extract data for specific selected animal
            begin
              sStatus := ADOTableA['EndangeredLevel'];
              sContinent := ADOTableA['Continent'];
              {correct the formatting of Oceans and Americas}
              if sContinent = 'Oceans' then
                sContinent := 'the ' + LowerCase(sContinent);
              if sContinent = 'Americas' then
                sContinent := 'the ' + sContinent;
              Inc(found);
            end;
          ADOTableA.Next;
        end;  //end of while
    end;  //end of with

  objAnimals := TAnimals.create(animal, sStatus, sContinent);   //send values
  MessageDlg(objAnimals.toString, mtInformation, [mbOK], 0);    //receives ToString and displays in an info dialog

end;

procedure TfrmAnimals.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmHome.Show;
end;

procedure TfrmAnimals.imgBackClick(Sender: TObject);
begin
  frmHome.Show;
  Self.Close;
end;

{each image click will make use of the procedure "AnimalClick"}
procedure TfrmAnimals.imgButterflyClick(Sender: TObject);
begin
 animal := 'Monarch Butterfly';
 AnimalClick();
end;

procedure TfrmAnimals.imgLionClick(Sender: TObject);
begin
  animal := 'Lion';
  AnimalClick();
end;

procedure TfrmAnimals.imgOrangutanClick(Sender: TObject);
begin
  animal := 'Orangutan';
  AnimalClick();
end;

procedure TfrmAnimals.imgPenguinClick(Sender: TObject);
begin
  animal := 'African Penguin';
  AnimalClick();
end;

procedure TfrmAnimals.imgRhinoClick(Sender: TObject);
begin
  animal := 'Black Rhino';
  AnimalClick();
end;

procedure TfrmAnimals.imgSharkClick(Sender: TObject);
begin
  animal := 'Great White Shark';
  AnimalClick();
end;

procedure TfrmAnimals.imgTunaClick(Sender: TObject);
begin
  animal := 'Yellowfin Tuna';
  AnimalClick();
end;

procedure TfrmAnimals.imgTurtleClick(Sender: TObject);
begin
  animal := 'Sea Turtles';
  AnimalClick();
end;

procedure TfrmAnimals.imgWDogClick(Sender: TObject);
begin
  animal := 'African Wild Dog';
  AnimalClick();
end;

procedure TfrmAnimals.imgWhaleClick(Sender: TObject);
begin
  animal := 'Blue Whale';
  AnimalClick();
end;

end.
