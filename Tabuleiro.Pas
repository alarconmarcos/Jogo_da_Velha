{ Marcos Alarcon, em Umuarama, 24 de março de 1999.
  Arquivo    : Tabuleiro.Pas
  Atualização: 15/04/1999
  Aqui estão as rotinas de tratamento do Tabuleiro do Jogo da Velha.
}

unit Tabuleiro;

interface

const
  cLivre            = 0; // Valor representando posição vazia (Deve ser 0)
  cMaquina          = 3; // Valor representando a máquina
  cAdversario       = 5; // Valor representando o adversário
  cVitoriaMaquina   = cMaquina*cMaquina*cMaquina;
  cVitoriaAdversario= cAdversario*cAdversario*cAdversario;
  cEmJogo           = 254;
  cEmpate           = 255;

type
  tVetorTabuleiro= array [1..9] of Byte;

  TVetorPosicoes= class
    public
      Tamanho: Byte;
      Vetor  : tVetorTabuleiro;

      constructor Create;
      procedure   Inserir (Valor: Byte);
      function    EscolherRandomico: Byte;
  end;

  TTabuleiro= class
    public
      Vetor: tVetorTabuleiro;

      procedure Inicializar;
      procedure Movimentar            (P: Byte; Valor: Byte);
      function  Buscar                (P: Byte)      : Byte;
      function  BuscarResultadoJogada (Posicao: Byte): Byte;
      function  ProcurarPosicaoLivre                 : Byte;
      function  BuscarPosicoesLivres                 : TVetorPosicoes;
      function  BuscarResultado                      : Byte;
  end;

var
  gTabuleiro: TTabuleiro;

implementation





constructor TVetorPosicoes.Create;

begin
  inherited Create;
  Tamanho:= 0;
end; // Create ()





procedure TVetorPosicoes.Inserir (Valor: Byte);

begin
  Inc (Tamanho);
  Vetor[Tamanho]:= Valor;
end; // Inserir ()





function TVetorPosicoes.EscolherRandomico: Byte;

begin
  if Tamanho > 0 then
    Result:= Vetor[Random (Tamanho)+1]
  else
    Result:= 0;
end; // EscolherRandomico ()





procedure TTabuleiro.Inicializar;
var
  P: Byte;

begin
  for P:= 1 to 9 do
    Vetor[P]:= cLivre;
end; // Inicializar ()





procedure TTabuleiro.Movimentar (P: Byte; Valor: Byte);

begin
  Vetor[P]:= Valor;
end; // Movimentar ()





function TTabuleiro.Buscar (P: Byte): Byte;

begin
  Result:= Vetor[P];
end; // Buscar ()




// A vitoria (relativo ao jogador da "Posicao") tem prioridade de resultado
function TTabuleiro.BuscarResultadoJogada (Posicao: Byte): Byte;
var
  Jogador: Byte;
  Vitoria: Byte;

begin
  Jogador:= Vetor[Posicao];
  Vitoria:= Jogador*Jogador*Jogador;
  case Posicao of
    1: begin
         Result:= Vetor[1]*Vetor[2]*Vetor[3]; // Linha
         if Result <> Vitoria then begin
           Result:= Vetor[1]*Vetor[4]*Vetor[7]; // Coluna
           if Result <> Vitoria then
             Result:= Vetor[1]*Vetor[5]*Vetor[9]; // Diagonal
         end;
       end;
    2: begin
         Result:= Vetor[1]*Vetor[2]*Vetor[3]; // Linha
         if Result <> Vitoria then
           Result:= Vetor[2]*Vetor[5]*Vetor[8]; // Coluna
       end;
    3: begin
         Result:= Vetor[1]*Vetor[2]*Vetor[3]; // Linha
         if Result <> Vitoria then begin
           Result:= Vetor[3]*Vetor[6]*Vetor[9]; // Coluna
           if Result <> Vitoria then
             Result:= Vetor[3]*Vetor[5]*Vetor[7]; // Diagonal
         end;
       end;
    4: begin
         Result:= Vetor[4]*Vetor[5]*Vetor[6]; // Linha
         if Result <> Vitoria then
           Result:= Vetor[1]*Vetor[4]*Vetor[7]; // Coluna
       end;
    5: begin
         Result:= Vetor[4]*Vetor[5]*Vetor[6]; // Linha
         if Result <> Vitoria then begin
           Result:= Vetor[2]*Vetor[5]*Vetor[8]; // Coluna
           if Result <> Vitoria then begin
             Result:= Vetor[1]*Vetor[5]*Vetor[9]; // Diagonal
             if Result <> Vitoria then
               Result:= Vetor[3]*Vetor[5]*Vetor[7]; // Diagonal
           end;
         end;
       end;
    6: begin
         Result:= Vetor[4]*Vetor[5]*Vetor[6]; // Linha
         if Result <> Vitoria then
           Result:= Vetor[3]*Vetor[6]*Vetor[9]; // Coluna
       end;
    7: begin
         Result:= Vetor[7]*Vetor[8]*Vetor[9]; // Linha
         if Result <> Vitoria then begin
           Result:= Vetor[1]*Vetor[4]*Vetor[7]; // Coluna
           if Result <> Vitoria then
             Result:= Vetor[3]*Vetor[5]*Vetor[7]; // Diagonal
         end;
       end;
    8: begin
         Result:= Vetor[7]*Vetor[8]*Vetor[9]; // Linha
         if Result <> Vitoria then
           Result:= Vetor[2]*Vetor[5]*Vetor[8]; // Coluna
       end;
    9: begin
         Result:= Vetor[7]*Vetor[8]*Vetor[9]; // Linha
         if Result <> Vitoria then begin
           Result:= Vetor[3]*Vetor[6]*Vetor[9]; // Coluna
           if Result <> Vitoria then
             Result:= Vetor[1]*Vetor[5]*Vetor[9]; // Diagonal
         end;
       end;
  end;
end; // BuscarResultodaJogada ()





function TTabuleiro.ProcurarPosicaoLivre: Byte;
var
  P: Byte;

begin
  Result:= 0;
  for P:= 1 to 9 do
    if Vetor[P] = cLivre then begin
      Result:= P;
      Exit;
    end;
end; // ProcurarPosicaoLivre ()





function TTabuleiro.BuscarPosicoesLivres: TVetorPosicoes;
var
  P: Byte;

begin
  Result:= TVetorPosicoes.Create;
  for P:= 1 to 9 do
    if Vetor[P] = cLivre then
      Result.Inserir (P);
end; // BuscarPosicoesLivres ()




// Status do Jogo: 1) Vitória da Máquina; 2) Vitória do Adversário; 3) Empate; 4) Continua Jogando.
function TTabuleiro.BuscarResultado: Byte;

begin
  // Linhas
  Result:= Vetor[1]*Vetor[2]*Vetor[3];
  if (Result = cVitoriaMaquina) or (Result = cVitoriaAdversario) then
    Exit;
  Result:= Vetor[4]*Vetor[5]*Vetor[6];
  if (Result = cVitoriaMaquina) or (Result = cVitoriaAdversario) then
    Exit;
  Result:= Vetor[7]*Vetor[8]*Vetor[9];
  if (Result = cVitoriaMaquina) or (Result = cVitoriaAdversario) then
    Exit;

  // Colunas
  Result:= Vetor[1]*Vetor[4]*Vetor[7];
  if (Result = cVitoriaMaquina) or (Result = cVitoriaAdversario) then
    Exit;
  Result:= Vetor[2]*Vetor[5]*Vetor[8];
  if (Result = cVitoriaMaquina) or (Result = cVitoriaAdversario) then
    Exit;
  Result:= Vetor[3]*Vetor[6]*Vetor[9];
  if (Result = cVitoriaMaquina) or (Result = cVitoriaAdversario) then
    Exit;

  // Diagonais
  Result:= Vetor[1]*Vetor[5]*Vetor[9];
  if (Result = cVitoriaMaquina) or (Result = cVitoriaAdversario) then
    Exit;
  Result:= Vetor[3]*Vetor[5]*Vetor[7];
  if (Result = cVitoriaMaquina) or (Result = cVitoriaAdversario) then
    Exit;

  // Verifica se houve um empate
  Result:= Vetor[1]*Vetor[2]*Vetor[3]*Vetor[4]*Vetor[5]*Vetor[6]*Vetor[7]*Vetor[8]*Vetor[9];
  if Result = 0 then
    Result:= cEmJogo
  else
    Result:= cEmpate;
end; // ProcurarPosicaoLivre ()





initialization
  Randomize;
end.

// Final do Arquivo