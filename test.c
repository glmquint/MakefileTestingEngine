#include <stdio.h>
#include <stdlib.h>
#include "result.c"

int main(int argc, char *argv[]){
    if (argc < 2){
        printf("Usage: %s base\n", argv[0]);
        return 1;
    }
    int base = atoi(argv[1]);
    int offset = 0;
    printf("Insert offset: ");
    scanf("%d", &offset);
    printf("result is %d\n", result(base, offset));
    return 0;
}
