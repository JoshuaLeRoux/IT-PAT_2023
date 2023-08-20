// Joshua Le Roux
unit Home_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DataModule_U, Grids, DBGrids, ExtCtrls, StdCtrls, pngimage, FundR_U,
  Animals_U, Signup_U, Admin_U;

type
  TfrmHome = class(TForm)
    pnlLogin: TPanel;
    lblLogin: TLabel;
    edtUsername: TEdit;
    lblUser: TLabel;
    btnLogin: TButton;
    imgShow: TImage;
    lblPass: TLabel;
    edtPassword: TEdit;
    lblHeading: TLabel;
    Image1: TImage;
    Image2: TImage;
    pnlFundR: TPanel;
    pnlAnimals: TPanel;
    Label1: TLabel;
    imgAdmin: TImage;
    pnlLogout: TPanel;
    pnlUser: TPanel;
    pnlAdCon: TPanel;
    lblHello: TLabel;
    Image3: TImage;
    procedure btnLoginClick(Sender: TObject);
    procedure imgShowClick(Sender: TObject);
    procedure pnlFundRClick(Sender: TObject);
    procedure pnlAnimalsClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtUsernameChange(Sender: TObject);
    procedure pnlLogoutClick(Sender: TObject);
    procedure pnlAdConClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHome: TfrmHome;
  username :String;
  privileges: boolean;

implementation

{$R *.dfm}

procedure TfrmHome.btnLoginClick(Sender: TObject);
var
  password  :string;
  found :Boolean;

begin
  username := edtUsername.Text;
  password := edtPassword.Text;
  found := false;

  with DM do
    begin
      ADOusers.First;
      while (not ADOusers.Eof) AND (found = false) do
      begin
        if (ADOusers['Username'] = username) AND (ADOusers['Password'] = password) then
          begin
            found := true;
            pnlLogin.Visible := false;
            privileges := ADOusers['Privileges'];
            pnlAdCon.Visible := privileges;
          end
        else
          ADOusers.Next;
      end;
    end;

  if found = false then
    ShowMessage('Invalid credentials.');

  lblHello.Caption := 'Welcome ' + username + '!';

end;

procedure TfrmHome.edtUsernameChange(Sender: TObject);
var
  test  :boolean;
begin
  username := edtUsername.Text;
  imgAdmin.Visible := false;

  with DM do
    begin
      ADOusers.First;
      while not ADOusers.EOF do
        begin
          if ADOusers['Username'] = username then
            test := ADOusers['Privileges'];
          ADOusers.Next;
        end;
    end;

  if test = true then
    imgAdmin.Visible := true
  else
    imgAdmin.Visible := false;
end;

procedure TfrmHome.FormShow(Sender: TObject);
begin
  pnlFundR.Color := $98FB98;
  pnlAnimals.Color := $98FB98;
  pnlLogout.Color := $98FB98;
  pnlAdCon.Color := $98FB98;
end;

procedure TfrmHome.imgShowClick(Sender: TObject);
begin
  if edtPassword.PasswordChar = #0 then
    edtPassword.PasswordChar := '*'
  else
    edtPassword.PasswordChar := #0;
end;

procedure TfrmHome.Label1Click(Sender: TObject);
begin
 frmSignup.Show;

 edtPassword.Text := '';
 edtUsername.Text := '';
end;

procedure TfrmHome.pnlLogoutClick(Sender: TObject);
begin
  pnlLogin.Visible := true;
  edtUsername.Text := '';
  edtPassword.Text := '';
end;

procedure TfrmHome.pnlAdConClick(Sender: TObject);
begin
  frmAdmin.Show;
end;

procedure TfrmHome.pnlAnimalsClick(Sender: TObject);
begin
  frmAnimals.Show;
  Self.Hide;
end;

procedure TfrmHome.pnlFundRClick(Sender: TObject);
begin
  frmFundR.Show;
  Self.Hide;
end;

end.
