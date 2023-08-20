// Joshua Le Roux
unit DataModule_U;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TDM = class(TDataModule)
    ADOConnection1: TADOConnection;
    DataSourceF: TDataSource;
    ADOTableF: TADOTable;
    ADOTableA: TADOTable;
    DataSourceA: TDataSource;
    ADOusers: TADOTable;
    DataSourceU: TDataSource;
    qryFundR: TADOQuery;
    dsrFundR: TDataSource;
    qryUsers: TADOQuery;
    dsrUsers: TDataSource;
    qryTotals: TADOQuery;
    dsrTotals: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation
uses
  Home_U, FundR_U, Animals_U, Admin_U, oop_U;

{$R *.dfm}

end.
