#include <stdlib.h>
#include <string.h>

#define NSYMS 20

struct symtab
{
    char *name;
    double value;
} symtab[NSYMS];

struct symtab *symlook();