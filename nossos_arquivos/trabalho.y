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

%token TK_TIPO_INT TK_TIPO_DEC TK_TIPO_BOOL TK_TIPO_CHAR TK_TIPO_TEXTO
%token TK_PARA TK_SE TK_ENTAO TK_INCREMENTE TK_SENAO TK_ENQUANTO TK_OK TK_KO TK_REPITA TK_ATE

%token TK_ID TK_INT TK_DEC TK_BOOL TK_CHAR TK_TEXTO

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

S : DECLARACAO
  | INTERVALO
  | LISTA_COMANDO
  ;



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
		 | TK_INT
		 | TK_DEC
		 | TK_BOOL
		 | '(' E ')'
		 | TK_ID '(' E ')'
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

ATRIBUICAO : '=' CONST_BASICA
		   | '=' E
		   | '=' '{' LISTA_CONST '}'
		   ;
	 
LISTA_CONST : CONST_BASICA
			| CONST_BASICA ',' LISTA_CONST
			;
	  
TIPO_BASICO : TK_TIPO_INT
	 		| TK_TIPO_DEC
			| TK_TIPO_BOOL
			| TK_TIPO_CHAR
	 		| TK_TIPO_TEXTO
	 		;

CONST_BASICA :  TK_CHAR
			 | TK_TEXTO
			 ;
				
COMANDO : COMANDO_IF
		| COMANDO_WHILE
		| COMANDO_DO_WHILE
		| COMANDO_BLOCO
		| COMANDO_FOR
		| COMANDO_EXPRESSAO
		| COMANDO_ATRIBUICAO
		| COMANDO_VAZIO
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

			 
COMANDO_BLOCO : TK_OK LISTA_COMANDO TK_KO
			  ;			 
			  
COMANDO_FOR : TK_PARA TK_ID TK_EM INTERVALO TK_INCREMENTE TK_INT ':' COMANDO
			;
			
COMANDO_EXPRESSAO : E ';'
				  ;

COMANDO_ATRIBUICAO : TK_ID ATRIBUICAO ';'
				   ;
				   


COMANDO_VAZIO : ';'
			  ;
			  


%%

#include "lex.yy.c"

void yyerror( const char* st )
{
   puts( st ); 
   printf( "Proximo a: %s\nNa linha %d\n", yytext, current_line);
}

int main( int argc, char* argv[] )
{
  yyparse();
  cout << endl << "Sintaxe ok!" << endl;
}
