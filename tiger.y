%{
#include <stdio.h>
#include "util.h"
#include "errormsg.h"

int yylex(void);

void printTest(string field)
{
  printf("Eu sou %s\n", field);
}

void yyerror(char *s)
{
 EM_error(EM_tokPos, "%s", s);
}
%}

%locations

%union {
	int pos;
	int ival;
	string sval;
}

%error-verbose
%token <sval> ID STRING
%token <ival> INT

%token COMMA COLON SEMICOLON LPAREN RPAREN LBRACK RBRACK 
%token LBRACE RBRACE DOT PLUS MINUS TIMES DIVIDE EQ NEQ LT LE GT GE
%token AND OR ASSIGN ARRAY IF THEN ELSE WHILE FOR TO LET IN END OF 
%token BREAK NIL FUNCTION VAR TYPE DO

%type <void> program
%type <void> root
%type <void> exp
%type <void> let

%start program

%%

program: root{};

root: /* empty */ {}
      |exp{};

exp:    INT {printTest("Inteiro");}
      | STRING {}
      | NIL {}
      | let {printTest("LET");}
      ;
let:    LET decs IN explist END {printTest("Expressão LET");}
      ;
decs:   /* empty */ {}
      | dec decs {}
      ;
dec:    vardec {}
      ;
explist: /* empty */ {}
      ;
vardec: VAR id ASSIGN exp {}
      | VAR id COLON id ASSIGN exp {}
      ;
id:     ID {printTest("ID");}
      ;

%%