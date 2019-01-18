unit UPrincipal;

interface

uses
  System.Threading,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Error, FireDAC.VCLUI.Login, FireDAC.VCLUI.Async,
  FireDAC.VCLUI.Script, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  FireDAC.Phys.IBBase, FireDAC.Phys.FB, Data.DB, FireDAC.Comp.Client,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    btnExecucaoThread: TButton;
    FDConnection1: TFDConnection;
    btnExecucaoNormal: TButton;
    procedure btnExecucaoThreadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnExecucaoNormalClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

const
  SEU_NOME_CONEXAO = 'MINHA_CONEXAO_POOL_FB';

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  oParam: TStringList;
begin
  // criar os parametro e adicionar ao fdmanager somente uma vez
  FDManager.Close;
  oParam := TStringList.Create;
  try
    oParam.Clear;
    oParam.Add('DriverID=FB');
    oParam.Add('Server=localhost');
    oParam.Add('Port=3050');
    oParam.Add('Protocol=TCPIP');
    oParam.Add('CharacterSet=WIN1252');
    oParam.Add('User_Name=sysdba');
    oParam.Add('Password=masterkey');
    oParam.Add('Database=C:\Users\regys\Desktop\Exemplo POOL Firedac\database\DADOS.FDB');

    // adicionar a conexão ao fdmamanger e usar o nome da conexão
    FDManager.AddConnectionDef(SEU_NOME_CONEXAO, 'FB', oParam);
    FDManager.Open;
  finally
    oParam.Free;
  end;
end;

procedure TForm1.btnExecucaoNormalClick(Sender: TObject);
var
  FDConn: TFDConnection;
begin
  FDConn := TFDConnection.Create(nil);
  try
    FDConn.ConnectionDefName := SEU_NOME_CONEXAO;
    FDConn.LoginPrompt := False;

    FDConn.ExecSQLScalar('select * from teste');
    ShowMessage('pronto!');
  finally
    FDConn.Free;
  end;
end;

procedure TForm1.btnExecucaoThreadClick(Sender: TObject);
begin
  TParallel.For(1, 1000,
    procedure (I: Integer)
    var
      FDConn: TFDConnection;
    begin
      FDConn := TFDConnection.Create(nil);
      try
        FDConn.ConnectionDefName := SEU_NOME_CONEXAO;
        FDConn.LoginPrompt := False;

        FDConn.ExecSQLScalar('select * from teste');
      finally
        FDConn.Free;
      end;
    end
  );

  ShowMessage('pronto');
end;

end.
