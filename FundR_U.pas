// Joshua Le Roux
unit FundR_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, DataModule_U, Grids, DBGrids, StdCtrls, ExtCtrls, pngimage;

type
  TfrmFundR = class(TForm)
    dbgFundR: TDBGrid;
    pnlEdit: TPanel;
    btnEdit: TButton;
    edtRaised: TEdit;
    edtGoal: TEdit;
    pnlToGo: TPanel;
    lblEdit: TLabel;
    pnlTotals: TPanel;
    lblRaised: TLabel;
    lblGoal: TLabel;
    btnRestore: TButton;
    imgBack: TImage;
    dbgTotals: TDBGrid;
    lblTotals: TLabel;
    redOutput: TRichEdit;
    procedure FormShow(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure imgBackClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnRestoreClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure showTotals;
  end;

var
  frmFundR: TfrmFundR;
  arrFundR : array [1..10] of String;
  J, L, R :Integer;
  myFile  :TextFile;
  sLine, temp :String;

implementation
uses
  Home_U;

{$R *.dfm}

procedure TfrmFundR.btnEditClick(Sender: TObject);
var
  raised, goal, diff  :Integer;
begin
{edit goal and raised amounts}
  if edtRaised.Text = '' then
    edtRaised.Text := '0';
  if edtGoal.Text = '' then
    edtGoal.Text := '0';

  raised := StrToInt(edtRaised.Text);
  goal := StrToInt(edtGoal.Text);

  with DM do
    begin
      ADOTableF.First;
      ADOTableF.Edit;
      while not ADOTableF.EOF do
        begin
        ADOTableF.Edit;
          if ADOTableF['ProjectName'] = dm.qryFundR['ProjectName'] then
            begin
              if raised > 0 then  // ensures 0 data not written
                ADOTableF['MoneyRaised'] := raised;
              if goal > 0 then
                ADOTableF['GoalAmount'] := goal;
              diff := ADOTableF['GoalAmount'] - ADOTableF['MoneyRaised'];
              ADOTableF.Post;
              ADOTableF.Refresh;
            end;  //end of if
          ADOTableF.Next;
        end;  //end of while
    end;  //end of with

  FormShow(Action);
  pnlToGo.Color := clMoneyGreen;
  if diff <= 0 then
    pnlToGo.Caption := 'Goal reached!!!'
  else
    pnlToGo.Caption := 'Amount to go: R' + IntToStr(diff);

  edtRaised.Text := '0';
  edtGoal.Text := '0';
end;

procedure TfrmFundR.btnRestoreClick(Sender: TObject);
var
  h, d  :Integer;
  first, second  :Real;
begin
{restore database fund raiser amounts to original}
  if FileExists('fBackup.txt') = false then
    begin
      ShowMessage('File not found!');
      Exit;
    end;

  AssignFile(myFile, 'fBackup.txt');
  Reset(myFile);
  L := 1;

  {extract file contents to array}
  while not EOF(myFile) do
    begin
      Readln(myFile, arrFundR[L]);
      Inc(L);
    end;

  CloseFile(myFile);

  with DM do
    begin
      ADOTableF.First;
      ADOTableF.Edit;
      L := 1;
      while not ADOTableF.EOF do
        begin
          ADOTableF.Edit;

          {seperates data into usable information}
          temp := arrFundR[L];
          h := Pos('#',temp);
          d := h-1;
          first := StrToFloat(copy(temp,1,d));
          delete(temp,1,h);
          second := StrToFloat(temp);

          {writes restored data to database}
          ADOTableF['GoalAmount'] := FloatToStrF(first, ffCurrency,8,2);
          ADOTableF['MoneyRaised'] := FloatToStrF(second, ffCurrency,8,2);

          ADOTableF.Next;
          Inc(L);
        end;  //end of while
      FormShow(Action); //refresh dbgrid
    end;  //end of with

  pnlToGo.Color := clSkyBlue;
  pnlToGo.Caption := '';

end;

procedure TfrmFundR.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  edtRaised.Text := '0';
  edtGoal.Text := '0';
  pnlToGo.Color := clSkyBlue;
  pnlToGo.Caption := '';

  frmHome.Show;
end;

procedure TfrmFundR.FormShow(Sender: TObject);
var
  SQL1 :String;
begin
{display table data using sql query}
  SQL1 := 'SELECT ProjectName, Organiser, Animal, MoneyRaised, GoalAmount FROM tblFundraisers ORDER BY Organiser';

  with DM do
    begin
      qryFundR.Close;
      qryFundR.SQL.Clear;
      qryFundR.SQL.Add(SQL1);
      qryFundR.Open;
    end;

  showTotals();   //use procedure to display total amounts

{checks for admin privilege and enables/disables functions accordingly}
  if privileges = false then
    begin
      btnEdit.Enabled := false;
      btnRestore.Enabled := false;
    end;
  if privileges = true then
    begin
      btnEdit.Enabled := true;
      btnRestore.Enabled := true;
    end;

end;

procedure TfrmFundR.imgBackClick(Sender: TObject);
begin
{clears data on return to home}
  edtRaised.Text := '0';
  edtGoal.Text := '0';
  pnlToGo.Color := clSkyBlue;
  pnlToGo.Caption := '';

  frmHome.Show;
  Self.Close;
end;

procedure TfrmFundR.showTotals;
var
  SQL3, prog  :String;
  ToOut  :Real;
  perc  :Integer;
begin
{display totals and progress of table amounts}
 SQL3 := 'SELECT SUM(MoneyRaised) AS [TotalRaised], SUM(GoalAmount) AS [TotalGoal] FROM tblFundraisers';

  with DM do
    begin
      qryTotals.Close;
      qryTotals.SQL.Clear;
      qryTotals.SQL.Add(SQL3);
      qryTotals.Open;
      ToOut := qryTotals['TotalGoal'] - qryTotals['TotalRaised'];   //find total difference
      perc := Round(qryTotals['TotalRaised'] / qryTotals['TotalGoal'] * 100);
    end;
  if perc >= 50 then
    prog := 'good'
  else
    prog := 'bad';

  redOutput.Lines.Clear;
  redOutput.Lines.Add('Outstanding' +#9+ 'Percentage Completed' +#9+ 'Progress');
  redOutput.Lines.Add(FloatToStr(ToOut) +#9+#9+ IntToStr(perc) + '%' +#9+#9+#9+ prog);
end;

end.
