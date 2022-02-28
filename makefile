all: test

test: test.o result.o
	gcc -Wall test.o -o test

test.o: test.c
	gcc -c test.c

result.o: result.c
	gcc -c result.c

clean:
	rm *.o

reset:
	rm *.o
	rm test
