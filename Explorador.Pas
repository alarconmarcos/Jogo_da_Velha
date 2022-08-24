{ Marcos Alarcon, em Umuarama, 24 de março de 1996.
  Arquivo    : Explorador.Pas
  Atualização: 15/04/1999
  A idéia é procurar uma POSIÇÃO (jogada) para máquina que qualquer que seja a
  jogada do adversário a máquina possa conseguir pelo menos um empate.
}

unit Explorador;

interface

uses Tabuleiro;

type
  TExplorador= class
    protected
      Tabuleiro: TTabuleiro;

      function ProcurarAdversario (Posicao: Byte): Boolean;
      function ProcurarMaquina    (Posicao: Byte): Boolean;
    public
      constructor Create;
      destructor  Destroy; override;
      function    Explorar: Byte;
  end;

implementation





constructor TExplorador.Create;

begin
  inherited Create;

  Tabuleiro:= TTabuleiro.Create;
end; // Create ()





destructor TExplorador.Destroy;

begin
  Tabuleiro.Free;

  inherited Destroy;
end; // Destroy ()




// Faz uma jogada para o adversário e verifica se a máquina consegue um empate/vitória
function TExplorador.ProcurarAdversario (Posicao: Byte): Boolean;
var
  P            : Byte;
  ResultadoJogo: Byte;
  Livres       : TVetorPosicoes;

begin
  Tabuleiro.Movimentar (Posicao, cAdversario);
  case Tabuleiro.BuscarResultado of
    cVitoriaAdversario: Result:= False;
    cVitoriaMaquina   : Result:= True;
    cEmpate           : Result:= True;
    else begin
      Livres:= Tabuleiro.BuscarPosicoesLivres;
      for P:= 1 to Livres.Tamanho do begin
        Posicao:= Livres.Vetor[P];
        Result := ProcurarMaquina (Posicao);
        Tabuleiro.Movimentar (Posicao, cLivre); // Restaura a jogada da máquina
        if Result then
          Break; // Houve um empate/vitória da máquina
      end;
      Livres.Free;
    end;
  end;
end; // ProcurarAdversario ()




// Faz uma jogada para a máquina e verifica se o adversário vence
function TExplorador.ProcurarMaquina (Posicao: Byte): Boolean;
var
  P            : Byte;
  ResultadoJogo: Byte;
  Livres       : TVetorPosicoes;

begin
  Tabuleiro.Movimentar (Posicao, cMaquina);
  case Tabuleiro.BuscarResultado of
    cVitoriaAdversario: Result:= False;
    cVitoriaMaquina   : Result:= True;
    cEmpate           : Result:= True;
    else begin
      Livres:= Tabuleiro.BuscarPosicoesLivres;
      for P:= 1 to Livres.Tamanho do begin
        Posicao:= Livres.Vetor[P];
        Result := ProcurarAdversario (Posicao);
        Tabuleiro.Movimentar (Posicao, cLivre); // Restaura a jogada do adversário
        if not Result then
          Break; // A jogada da máquina foi ruim
      end;
      Livres.Free;
    end;
  end;
end; // ProcurarMaquina ()




// Escolher uma entre as posições que não levam a derrota para a máquina.
function TExplorador.Explorar: Byte;
var
  P      : Byte;
  Posicao: Byte;
  Jogadas: TVetorPosicoes; // Melhores posições para a máquina
  Maquina: TVetorPosicoes; // Posições livres da máquina

begin
  Jogadas        := TVetorPosicoes.Create;
  Maquina        := gTabuleiro.BuscarPosicoesLivres; // O próprio método cria o objeto
  Tabuleiro.Vetor:= gTabuleiro.Vetor; // Tabuleiro de rascunho/trabalho

  for P:= 1 to Maquina.Tamanho do begin
    Posicao:= Maquina.Vetor[P];
    if ProcurarMaquina (Posicao) then
      Jogadas.Inserir (Posicao);
    Tabuleiro.Movimentar (Posicao, cLivre); // Restaura a jogada da máquina
  end;

  if Jogadas.Tamanho > 0 then
    Result:= Jogadas.EscolherRandomico
  else
    Result:= Maquina.EscolherRandomico;  // Pode levar a derrota !!!

  Jogadas.Free;
  Maquina.Free;
end; // Explorar ()

end.

// Final do Arquivo
