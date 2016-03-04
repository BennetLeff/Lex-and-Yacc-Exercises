%{
    #include "ch3hdr.h"
    #include <stdio.h>
    int yylex(void);
    void yyerror(char *);

    double vbltable[26];
%}

%union {
    double dval;
    struct symtab *symp;
}

%token <symp> NAME
%token <dval> NUMBER
%left '-' '+'
%left '*' '/'
%nonassoc UMINUS

%type <dval> expression
%%

statement_list: statement '\n'
    |   statement_list statement '\n'
    ;

statement: NAME '=' expression  { $1->value = $3; }
    |      expression       { fprintf(stderr, "= %g\n", $1); }
    ;

expression: expression '+' expression   { $$ = $1 + $3; }
    |       expression '-' expression   { $$ = $1 - $3; }
    |       expression '*' expression   { $$ = $1 * $3; }
    |       expression '/' expression   
                { 
                    if($3 == 0.0)
                        yyerror("divide by zero");
                    else
                        $$ = $1 / $3;
                }
    |       '-' expression %prec UMINUS { $$ = -$2; }
    |       '(' expression ')'          { $$ = $2; }
    |       NUMBER                      
    |       NAME                        { $$ = $1->value; }
    ;
%% 

void yyerror(char *str)
{
    fprintf(stderr, "Error %s", str);
}

struct symtab *symlook(char *s) {
    char *p;
    struct symtab *sp;

    for(sp = symtab; sp < &symtab[NSYMS]; sp++) {
        /* is it already here? */
        if(sp->name && !strcmp(sp->name, s))
            return sp;
        if(!sp->name) { /* is it free */
            sp->name = strdup(s);
            return sp; 
        }
        /* otherwise continue to next */
    }
    yyerror("Too many symbols");
    exit(1);    /* cannot continue */
} /* symlook */

int main(void) {
    yyparse();
    return 0;
}