CC=cc 
outfile=calc
lexfile=ch3-02
yaccfile=ch3-02

outfile: compile
	${CC} -o ${outfile}.out lex.yy.o y.tab.o -ll

compile: build
	${CC} -c lex.yy.c -ll
	${CC} -c y.tab.c -ll

build:
	lex ${lexfile}.l
	yacc -d ${yaccfile}.y