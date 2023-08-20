// Joshua Le Roux
unit Admin_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DataModule_U, Grids, DBGrids, ExtCtrls, pngimage, StdCtrls;

type
  TfrmAdmin = class(TForm)
    dbgUsers: TDBGrid;
    pnlUser: TPanel;
    pnlDelete: TPanel;
    pnlRestore: TPanel;
    lblNote: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure imgBackClick(Sender: TObject);
    procedure pnlDeleteClick(Sender: TObject);
    procedure pnlRestoreClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAdmin: TfrmAdmin;
  arrUsers : array[1..3,1..2] of String;
  myFile  :TextFile;
  sline :String;
  J, L, R, H :Integer;

implementation
uses
  Home_U;

{$R *.dfm}

procedure TfrmAdmin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmHome.Show;
end;

procedure TfrmAdmin.FormShow(Sender: TObject);
var
  SQL2 :String;
begin
  SQL2 := 'SELECT Username, Privileges FROM tblUsers WHERE Privileges = false ORDER BY Username';

  with DM do
    begin
      qryUsers.Close;
      qryUsers.SQL.Clear;
      qryUsers.SQL.Add(SQL2);
      qryUsers.Open;
    end;

  pnlDelete.Color := $98FB98;
  pnlRestore.Color := $98FB98;
  pnlUser.Caption := 'current admin: ' + username;
end;

procedure TfrmAdmin.imgBackClick(Sender: TObject);
begin
  frmHome.Show;
  Self.Close;
end;

procedure TfrmAdmin.pnlDeleteClick(Sender: TObject);
var
  found :Integer;
  confirm :String;
begin
{delete selected user}
  if (DM.qryUsers['Username'] = username) OR (DM.qryUsers['Username'] = null) then  //ensures user to be deleted is not the current admin
    exit;
  confirm := InputBox('Warning!','Are you sure you want to delete ' + DM.qryUsers['Username'] + '?' +#13+ 'y/n','n'); //confirm deletion
  if UpperCase(confirm) <> 'Y' then
    begin
      ShowMessage(DM.qryUsers['Username'] + ' was not removed.');
      exit;
    end;

  with DM do
    begin
      ADOusers.First;
      ADOusers.Edit;
      while not ADOusers.EOF do
        begin
          ADOusers.Edit;
          if ADOusers['Username'] = qryUsers['Username'] then //check that table user is the selected query user
            begin
              ADOusers.Delete;
              Inc(found);
            end
          else
          ADOusers.Next;
        end;  //end of while
    end;  //end of with

  if found = 0 then
    ShowMessage('Error: User not found!')
  else
    FormShow(Action);
end;

procedure TfrmAdmin.pnlRestoreClick(Sender: TObject);
begin
{remove all non admins}
      with DM do
        begin
          ADOusers.First;
          ADOusers.Edit;
          while not ADOusers.EOF do
            begin
              ADOusers.Edit;

              if ADOusers['Privileges'] = false then  //ensure admins not removed
                begin
                  ADOusers.Delete;
                  ADOusers.First;   //return to beginning for thorough re-search
                end
              else
                ADOusers.Next;
            end;  //end of while
        end;  //end of with

  DM.ADOusers.Edit;
  DM.ADOusers.Post;
  DM.ADOusers.Refresh;
  FormShow(Action);

{extract user data from text file...}
  if FileExists('uBackup.txt') = false then
    begin
      ShowMessage('File not found!');
      Exit;
    end;

  AssignFile(myFile,'uBackup.txt');
  Reset(myFile);
  L := 1;

  {...extract file contents to array}
  while not EOF(myFile) do
    begin
      Readln(myFile, sline);
      for J := 1 to 2 do
        begin
          H := pos('#',sline);
          arrUsers[L,J] := copy(sline,1,H-1);
          delete(sline,1,H);
        end;
      Inc(L);
    end;

  CloseFile(myFile);

{insert extracted user accounts}
  with DM do
    begin
      ADOusers.Last;
      ADOusers.Insert;
      for R := 1 to 3 do
        begin
          ADOusers.Insert;
          ADOusers['Username'] := arrUsers[R,1];
          ADOusers['Password'] := arrUsers[R,2];
        end;  //end of for loop
    end;  //end of with

  DM.ADOusers.Edit;
  DM.ADOusers.Post;   //ensure data posted correctly
  DM.ADOusers.Refresh;
  FormShow(Action);
end;

end.
