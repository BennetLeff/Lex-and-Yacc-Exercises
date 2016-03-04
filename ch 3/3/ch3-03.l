%{
#include "y.tab.h"
#include "ch3hdr.h"
#include <math.h>
extern double vbltable[26];
%}

%%

([0-9]+|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?) {
    yylval.dval = atof(yytext); 
    return NUMBER; 
    }
    
[ \t] ;  /* ignore whitespace */
[A-Za-z][A-Za-z0-9]*   { 
        yylval.symp = symlook(yytext);
        return NAME; 
    }
"$"   return 0; /* logical EOF */
\n    |
.     return yytext[0];
%%