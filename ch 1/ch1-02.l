%{
/* this sample demonstrates very simple recognition:
 * a verb/not a verb 
 */  
%}
%%

[\t ]+  /* ignore whitespace */ ;

is |
am |
are |
were |
was |
be |
being |
been |
do |
go  { printf("%s: is a verb\n", yytext); }

[a-zA-Z]+   { printf("%s: is not a verb\n", yytext); }

.|\n   { ECHO; /* default */}
%%

main()
{
    yylex();
}