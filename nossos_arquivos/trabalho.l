%{
int current_line = 1;
%}

%option noyywrap
DELIM   [\t ]
COMMENT \?\?[^\n]*
DIGITO  [0-9]
LETRA   [a-zA-Z_]
ID      {LETRA}({LETRA}|{DIGITO})*
INTEIRO -?{DIGITO}+
DECIMAL {INTEIRO}"."{DIGITO}+
BOOL	(verdadeiro|falso)
CHAR	\'[^\n]\'
TEXTO   \"[^\n]*\"

%%

{COMMENT} {}
\n        { current_line++; }
{DELIM}   {}
{DECIMAL} { yylval = yytext; return TK_DEC; }
{INTEIRO} { yylval = yytext; return TK_INT; }
{BOOL}    { yylval = yytext; return TK_BOOL; }
{CHAR}   { yylval = yytext; return TK_CHAR; }
{TEXTO}   { yylval = yytext; return TK_TEXTO; }

para	  	{ return TK_PARA; }
incremente	{ return TK_INCREMENTE; }
enquanto	{ return TK_ENQUANTO; }
se	  		{ return TK_SE; }
entao	    { return TK_ENTAO; }
senao	    { return TK_SENAO; }
ok		    { return TK_OK; }
ko		    { return TK_KO; }
repita		{ return TK_REPITA; }
ate		    { return TK_ATE; }

leia		{ return TK_IN; }
escreva		{ return TK_OUT; }

varglob   { return TK_VARIAVEIS_GLOBAIS; }
bolgrav   { return TK_FIM_VARIAVEIS_GLOBAIS; }

retorne		  { return TK_RETURN; }

"ok computer" { return TK_MAIN; }
"ko computer" { return TK_END_MAIN; }

inteiro   { return TK_TIPO_INT; }
decimal   { return TK_TIPO_DEC; }
bool	  { return TK_TIPO_BOOL; }
caractere { return TK_TIPO_CHAR; }
texto     { return TK_TIPO_TEXTO; }
vazio		{return TK_TIPO_VAZIO; }

mod       { return TK_MOD; }

em		  { return TK_EM; }
e         { return TK_AND; }
ou		  { return TK_OU;  }
nao 	  { return TK_NAO; }

'>''='		  { return TK_MAIOR_IGUAL; }
'<''='   	  { return TK_MENOR_IGUAL; }
igual     { return TK_IGUAL; }
diferente { return TK_DIFERENTE; }

{ID}      { yylval = yytext; return TK_ID; }
.         { yylval = yytext; return yytext[0]; }

%%
