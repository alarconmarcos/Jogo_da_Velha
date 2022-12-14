// Marcos Alarcon, em Umuarama, 21 de Junho de 1999.

unit Principal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, Buttons, Explorador, Tabuleiro;

type
  TFormPrincipal= class (TForm)
    Posicao1     : TSpeedButton;
    Posicao2     : TSpeedButton;
    Posicao3     : TSpeedButton;
    Posicao4     : TSpeedButton;
    Posicao5     : TSpeedButton;
    Posicao6     : TSpeedButton;
    Posicao7     : TSpeedButton;
    Posicao8     : TSpeedButton;
    Posicao9     : TSpeedButton;
    MainMenu     : TMainMenu;
    MenuPrincipal: TMenuItem;
    MenuNovo     : TMenuItem;
    N1           : TMenuItem;
    MenuSair     : TMenuItem;
    Bevel1       : TBevel;
    Bevel2       : TBevel;
    Bevel3       : TBevel;
    Bevel4       : TBevel;

    procedure FormCreate    (Sender: TObject);
    procedure FormDestroy   (Sender: TObject);
    procedure MenuNovoClick (Sender: TObject);
    procedure MenuSairClick (Sender: TObject);
    procedure Posicao1Click (Sender: TObject);
    procedure Posicao2Click (Sender: TObject);
    procedure Posicao3Click (Sender: TObject);
    procedure Posicao4Click (Sender: TObject);
    procedure Posicao5Click (Sender: TObject);
    procedure Posicao6Click (Sender: TObject);
    procedure Posicao7Click (Sender: TObject);
    procedure Posicao8Click (Sender: TObject);
    procedure Posicao9Click (Sender: TObject);
    private
      SerAdversario: Boolean;
      Explorador   : TExplorador;

      function  BuscarJogador: Char;
      procedure PararJogo;
      procedure MovimentarMaquina;
      procedure Movimentar    (Posicao: Byte);
      procedure MostrarJogada (Posicao: Byte);
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.DFM}



procedure TFormPrincipal.FormCreate(Sender: TObject);

begin
  SerAdversario:= True;
  gTabuleiro   := TTabuleiro.Create;
  Explorador   := TExplorador.Create;
  gTabuleiro.Inicializar;
end;





procedure TFormPrincipal.FormDestroy (Sender: TObject);

begin
  gTabuleiro.Free;
  Explorador.Free;
end;





procedure TFormPrincipal.MenuNovoClick (Sender: TObject);

begin
  SerAdversario   := True;
  Posicao1.Enabled:= True;
  Posicao2.Enabled:= True;
  Posicao3.Enabled:= True;
  Posicao4.Enabled:= True;
  Posicao5.Enabled:= True;
  Posicao6.Enabled:= True;
  Posicao7.Enabled:= True;
  Posicao8.Enabled:= True;
  Posicao9.Enabled:= True;
  Posicao1.Caption:= '&1';
  Posicao2.Caption:= '&2';
  Posicao3.Caption:= '&3';
  Posicao4.Caption:= '&4';
  Posicao5.Caption:= '&5';
  Posicao6.Caption:= '&6';
  Posicao7.Caption:= '&7';
  Posicao8.Caption:= '&8';
  Posicao9.Caption:= '&9';
  gTabuleiro.Inicializar;
end;





procedure TFormPrincipal.MenuSairClick (Sender: TObject);

begin
  Close;
end;





procedure TFormPrincipal.Posicao1Click (Sender: TObject);

begin
  Movimentar (1);
end;





procedure TFormPrincipal.Posicao2Click (Sender: TObject);

begin
  Movimentar (2);
end;





procedure TFormPrincipal.Posicao3Click (Sender: TObject);

begin
  Movimentar (3);
end;





procedure TFormPrincipal.Posicao4Click (Sender: TObject);

begin
  Movimentar (4);
end;





procedure TFormPrincipal.Posicao5Click (Sender: TObject);

begin
  Movimentar (5);
end;





procedure TFormPrincipal.Posicao6Click (Sender: TObject);

begin
  Movimentar (6);
end;





procedure TFormPrincipal.Posicao7Click (Sender: TObject);

begin
  Movimentar (7);
end;





procedure TFormPrincipal.Posicao8Click (Sender: TObject);

begin
  Movimentar (8);
end;





procedure TFormPrincipal.Posicao9Click (Sender: TObject);

begin
  Movimentar (9);
end;





function TFormPrincipal.BuscarJogador: Char;

begin
  if SerAdversario then
    Result:= 'X'
  else
    Result:= 'O';
end; // BuscarJogador ()





procedure TFormPrincipal.PararJogo;

begin
  Posicao1.Enabled:= False;
  Posicao2.Enabled:= False;
  Posicao3.Enabled:= False;
  Posicao4.Enabled:= False;
  Posicao5.Enabled:= False;
  Posicao6.Enabled:= False;
  Posicao7.Enabled:= False;
  Posicao8.Enabled:= False;
  Posicao9.Enabled:= False;
end; // PararJogo ()





procedure TFormPrincipal.MovimentarMaquina;
var
  Posicao: Byte;

begin
  Posicao:= Explorador.Explorar;
  gTabuleiro.Movimentar (Posicao, cMaquina);
  MostrarJogada (Posicao);
  case gTabuleiro.BuscarResultado of
    cVitoriaMaquina   : begin
                          MessageDlg ('Seu Burro voc? perdeu !!!', mtInformation, [mbOk], 0);
                          PararJogo;
                        end;
    cVitoriaAdversario: begin
                          MessageDlg ('At? que enfim ganhou uma em !!!', mtInformation, [mbOk], 0);
                          PararJogo;
                        end;
    cEmpate           : begin
                          MessageDlg ('Ih! Empatou, n?o tem nem as moral !!!', mtInformation, [mbOk], 0);
                          PararJogo;
                        end;
  end;
end; // MovimentarMaquina ()





procedure TFormPrincipal.Movimentar (Posicao: Byte);

begin
  if SerAdversario then
    gTabuleiro.Movimentar (Posicao, cAdversario)
  else
    gTabuleiro.Movimentar (Posicao, cMaquina);
  MostrarJogada (Posicao);
  case gTabuleiro.BuscarResultado of
    cEmJogo           : MovimentarMaquina;
    cVitoriaMaquina   : begin
                          MessageDlg ('Seu Burro voc? perdeu !!!', mtInformation, [mbOk], 0);
                          PararJogo;
                        end;
    cVitoriaAdversario: begin
                          MessageDlg ('At? que enfim ganhou uma em !!!', mtInformation, [mbOk], 0);
                          PararJogo;
                        end;
    cEmpate           : begin
                          MessageDlg ('Ih! Empatou, n?o tem nem as moral !!!', mtInformation, [mbOk], 0);
                          PararJogo;
                        end;
  end;
end; // Movimentar ()





procedure TFormPrincipal.MostrarJogada (Posicao: Byte);

begin
  case Posicao of
    1: begin
         Posicao1.Caption:= BuscarJogador;
         Posicao1.Enabled:= False;
       end;
    2: begin
         Posicao2.Caption:= BuscarJogador;
         Posicao2.Enabled:= False;
       end;
    3: begin
         Posicao3.Caption:= BuscarJogador;
         Posicao3.Enabled:= False;
       end;
    4: begin
         Posicao4.Caption:= BuscarJogador;
         Posicao4.Enabled:= False;
       end;
    5: begin
         Posicao5.Caption:= BuscarJogador;
         Posicao5.Enabled:= False;
       end;
    6: begin
         Posicao6.Caption:= BuscarJogador;
         Posicao6.Enabled:= False;
       end;
    7: begin
         Posicao7.Caption:= BuscarJogador;
         Posicao7.Enabled:= False;
       end;
    8: begin
         Posicao8.Caption:= BuscarJogador;
         Posicao8.Enabled:= False;
       end;
    9: begin
         Posicao9.Caption:= BuscarJogador;
         Posicao9.Enabled:= False;
       end;
  end;
  SerAdversario:= not SerAdversario;
end; // MostrarJogada

end.
