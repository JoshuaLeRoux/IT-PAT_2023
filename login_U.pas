unit login_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TTLoginForm = class(TForm)
    btnLogin: TButton;
    lblPassword: TLabel;
    edtPassword: TEdit;
    procedure btnLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Execute : boolean;
  end;

var
  TLoginForm: TTLoginForm;

implementation

{$R *.dfm}

//class
function TTLoginForm.Execute: boolean;
begin
  with TLoginForm.Create(nil) do try
    Result := ShowModal = mrOk;
  finally
    Free;
  end;
end;


procedure TTLoginForm.btnLoginClick(Sender: TObject);
begin
  if edtPassword.Text = 'delphi' then
    ModalResult := mrOK
  else
    ModalResult := mrAbort;
end;

end.
