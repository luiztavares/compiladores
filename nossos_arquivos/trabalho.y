%{

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string>
#include <iostream>

using namespace std;

#define YYSTYPE string

extern int yylex();
int yyparse();
void yyerror(const char *);


%}

%token TK_TIPO_INT TK_TIPO_DEC TK_TIPO_BOOL TK_TIPO_CHAR TK_TIPO_TEXTO TK_TIPO_VAZIO
%token TK_PARA TK_SE TK_ENTAO TK_INCREMENTE TK_SENAO TK_ENQUANTO TK_OK TK_KO TK_REPITA TK_ATE

%token TK_ID TK_INT TK_DEC TK_BOOL TK_CHAR TK_TEXTO

%token TK_IN TK_OUT
%token TK_VARIAVEIS_GLOBAIS TK_FIM_VARIAVEIS_GLOBAIS TK_MAIN TK_END_MAIN TK_RETURN

%token TK_MAIOR_IGUAL TK_MENOR_IGUAL TK_IGUAL TK_DIFERENTE
%token TK_AND TK_OU TK_NAO TK_EM
%token TK_MOD

%left TK_OU
%left TK_AND
%nonassoc TK_NAO

%nonassoc '>' '<' TK_MAIOR_IGUAL TK_MENOR_IGUAL TK_IGUAL TK_DIFERENTE
%nonassoc TK_EM


%left '+' '-'
%left '*' '/'
%right TK_MOD


%%

S : VARIAVEIS_GLOBAIS FUNCOES MAIN
  ;
  
VARIAVEIS_GLOBAIS : TK_VARIAVEIS_GLOBAIS LISTA_DECLARACAO TK_FIM_VARIAVEIS_GLOBAIS
				  | 
				  ;

//PROGRAMA : LISTA_DECLARACAO LISTA_DECLARACAO_FUNCAO MAIN;

E : E '+' E
  | E '-' E
  | E '*' E
  | E '/' E
  | E '<' E
  | E '>' E
  | E TK_MENOR_IGUAL E
  | E TK_MAIOR_IGUAL E
  | E TK_IGUAL E
  | E TK_DIFERENTE E
  | E TK_MOD E
  | E TK_AND E
  | E TK_OU E
  | TK_NAO E
  | OPERANDO
  | E TK_EM INTERVALO
  ;
  
OPERANDO : TK_ID
		 | TK_ID '[' E ']'
		 | TK_ID '[' E ',' E ']'
		 | TK_INT
		 | TK_DEC
		 | TK_BOOL
		 | '(' E ')'
		 | CHAMADA_FUNCAO
		 | TK_IN '(' ')'
		 | TK_OUT '(' CONST_BASICA ')'
		 ;
		 
INTERVALO : ESQ_INTERVALO E ':' E DIR_INTERVALO
		  ;
		  
ESQ_INTERVALO : ']'
			  | '['
			  ;
			  
DIR_INTERVALO : '['
			  | ']'
			  ;


DECLARACAO : TIPO LISTA_VAR ';'
		   ;
		   
LISTA_DECLARACAO : DECLARACAO LISTA_DECLARACAO
				 |
				 ;
		
LISTA_VAR : TK_ID INIT
		  | TK_ID INIT ',' LISTA_VAR
		  ;
		   
TIPO : ARRAY TIPO_BASICO
	 ;
		   
ARRAY : '<' TK_INT '>'
	  | '<' TK_INT  ',' TK_INT '>'
	  |
	  ;
	  
INIT : ATRIBUICAO
	 |
	 ;

ATRIBUICAO : '=' VALOR
<<<<<<< HEAD
		   |'[' E ']' '=' VALOR
		   |'[' E ',' E ']' '=' VALOR
=======
>>>>>>> e81878b8aa45e9ed93203a220a926d73315758f3
		   ;
		   
VALOR : CONST_BASICA
	  | CONST_VETOR
<<<<<<< HEAD
	  | CONST_MATRIX
=======
	  | CONST_MATRIX;
>>>>>>> e81878b8aa45e9ed93203a220a926d73315758f3
	  ;
	  
CONST_VETOR : '{' LISTA_CONST '}'
			| '{' '}'
			;
			
CONST_MATRIX : '{' LISTA_CONST_VETOR '}'
			 ;	  

LISTA_CONST_VETOR : CONST_VETOR
				  | CONST_VETOR ',' LISTA_CONST_VETOR
				  ;
	 
LISTA_CONST : CONST_BASICA
			| CONST_BASICA ',' LISTA_CONST
			;
	  
TIPO_BASICO : TK_TIPO_INT
	 		| TK_TIPO_DEC
			| TK_TIPO_BOOL
			| TK_TIPO_CHAR
	 		| TK_TIPO_TEXTO
	 		| TK_TIPO_VAZIO
	 		;

CONST_BASICA :  TK_CHAR
			 | TK_TEXTO
			 | E
			 ;
				
COMANDO : COMANDO_IF
		| COMANDO_WHILE
		| COMANDO_DO_WHILE
		| COMANDO_BLOCO
		| COMANDO_FOR
		| COMANDO_EXPRESSAO
		| COMANDO_ATRIBUICAO
		| COMANDO_VAZIO
		| COMANDO_RETURN
		;

LISTA_COMANDO : COMANDO
			  | COMANDO LISTA_COMANDO  
			  ;
			 			  

			  
COMANDO_IF : TK_SE E TK_ENTAO COMANDO
		   | TK_SE E TK_ENTAO COMANDO TK_SENAO COMANDO
		   ;

COMANDO_WHILE : TK_ENQUANTO E ':' COMANDO
			  ;

COMANDO_DO_WHILE : TK_REPITA COMANDO TK_ATE E ';'
				 ;

			 
COMANDO_BLOCO : BLOCO
			  ;			 
			  
COMANDO_FOR : TK_PARA TK_ID TK_EM INTERVALO TK_INCREMENTE TK_INT ':' COMANDO
			;
			
COMANDO_EXPRESSAO : E ';'
				  ;

COMANDO_ATRIBUICAO : TK_ID ATRIBUICAO ';'
				   ;

COMANDO_VAZIO : ';'
			  ;
			  
<<<<<<< HEAD
COMANDO_RETURN : TK_RETURN E ';'
=======
COMANDO_RETURN : TK_RETURN ';'
>>>>>>> e81878b8aa45e9ed93203a220a926d73315758f3
			   ;			  
			  
BLOCO : TK_OK LISTA_DECLARACAO LISTA_COMANDO TK_KO
	  ;			  

DECLARACAO_FUNCAO : CABECALHO_FUNCAO BLOCO
				  | CABECALHO_FUNCAO ';'
				  ;
				  
FUNCOES : LISTA_DECLARACAO_FUNCAO
		|
		;

LISTA_DECLARACAO_FUNCAO : DECLARACAO_FUNCAO
						| DECLARACAO_FUNCAO LISTA_DECLARACAO_FUNCAO	
						;
				  
CABECALHO_FUNCAO : 	TIPO TK_ID '(' ARGUMENTO ')'
				 ;		
				 
ARGUMENTO : LISTA_ARGUMENTO
		   |
		   ;
		   
LISTA_ARGUMENTO : TIPO TK_ID
				 | 	TIPO TK_ID ',' LISTA_ARGUMENTO
				 ;

CHAMADA_FUNCAO : TK_ID '(' PARAMETRO ')'
			   ;

PARAMETRO : LISTA_PARAMETRO
		  |
		  ;

LISTA_PARAMETRO : VALOR
				| VALOR ',' LISTA_PARAMETRO
				;
				
MAIN : TK_MAIN '(' ')' BLOCO_MAIN TK_END_MAIN
	 ;
	 	 
BLOCO_MAIN : LISTA_DECLARACAO LISTA_COMANDO
		   ;
		   
%%

#include "lex.yy.c"

void yyerror( const char* st )
{
   puts( st ); 
   printf( "Proximo a: %s\nNa linha %d\n", yytext, current_line);
   exit(-1);
}

int main( int argc, char* argv[] )
{
  yyparse();
  cout << endl << "Sintaxe ok!" << endl;
}
