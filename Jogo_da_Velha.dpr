program Jogo_da_Velha;

uses
  Forms,
  Principal in 'Principal.Pas' {FormPrincipal},
  Explorador in 'Explorador.Pas',
  Tabuleiro in 'Tabuleiro.Pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
