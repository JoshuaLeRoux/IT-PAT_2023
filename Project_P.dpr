program Project_P;

uses
  Forms,
  Home_U in 'Home_U.pas' {frmHome},
  DataModule_U in 'DataModule_U.pas' {DM: TDataModule},
  Animals_U in 'Animals_U.pas' {frmAnimals},
  FundR_U in 'FundR_U.pas' {frmFundR},
  Signup_U in 'Signup_U.pas' {frmSignup},
  Admin_U in 'Admin_U.pas' {frmAdmin},
  oop_U in 'oop_U.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmHome, frmHome);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmAnimals, frmAnimals);
  Application.CreateForm(TfrmFundR, frmFundR);
  Application.CreateForm(TfrmSignup, frmSignup);
  Application.CreateForm(TfrmAdmin, frmAdmin);
  Application.Run;
end.
