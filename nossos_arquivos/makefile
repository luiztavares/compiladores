all: trabalho entrada.cc
	./trabalho < entrada-multiplica-matriz.karpo

lex.yy.c: trabalho.l
	lex trabalho.l

y.tab.c: trabalho.y
	yacc trabalho.y

trabalho: lex.yy.c y.tab.c
	g++ -o trabalho y.tab.c 
