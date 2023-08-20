// Joshua Le Roux
unit Signup_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, pngimage;

type
  TfrmSignup = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtUser: TEdit;
    edtPass: TEdit;
    btnSignup: TButton;
    lblCancel: TLabel;
    Image1: TImage;
    imgShow: TImage;
    pnlResult: TPanel;
    lblResult: TLabel;
    btnOK: TButton;
    procedure lblCancelClick(Sender: TObject);
    procedure imgShowClick(Sender: TObject);
    procedure btnSignupClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSignup: TfrmSignup;
  Password, Username, Result  :String;
  res :integer;

implementation
uses
  Home_U, DataModule_U;

{$R *.dfm}

procedure TfrmSignup.btnOKClick(Sender: TObject);
begin
{returns to login page without signing up}
  lblCancelClick(Action);
end;

procedure TfrmSignup.btnSignupClick(Sender: TObject);
begin
  Password := edtPass.Text;
  Username := edtUser.Text;

  {check if username is already in use}
  with DM do
    begin
      ADOusers.First;
      res := 0;
      while not ADOusers.EOF do
        begin
          if ADOusers['Username'] = Username then
            inc(res);
          ADOusers.Next;
        end;
    end;

  if (Password = '') OR (Username = '') then  //check if a password has been entered
    begin
      Result := 'Invalid username/password!';
    end
  else
  if res > 0 then
    begin
       Result := 'User/account already exists!'
    end
  else
    begin //if checks successful, write new accounto to database
      DM.ADOusers.Insert;
      DM.ADOusers['Username'] := Username;
      DM.ADOusers['Password'] := Password;
      DM.ADOusers['Privileges'] := false;
      Result := 'Account created successfully!';
    end;

  lblResult.Caption := Result;
  pnlResult.Visible := true;
end;

procedure TfrmSignup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
{ensure all edit fields reset to null on close}
  edtPass.Text := '';
  edtUser.Text := '';
  edtPass.PasswordChar := '*';
end;

procedure TfrmSignup.FormShow(Sender: TObject);
begin
  pnlResult.Visible := false;
end;

procedure TfrmSignup.imgShowClick(Sender: TObject);
begin
{show/hide password}
  if edtPass.PasswordChar = #0 then
    edtPass.PasswordChar := '*'
  else
    edtPass.PasswordChar := #0;
end;

procedure TfrmSignup.lblCancelClick(Sender: TObject);
begin
  edtPass.Text := '';
  edtUser.Text := '';
  edtPass.PasswordChar := '*';

  Self.Close;
end;

end.
