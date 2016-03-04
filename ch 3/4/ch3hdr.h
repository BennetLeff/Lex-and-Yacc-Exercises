#include <stdlib.h>
#include <string.h>

#define NSYMS 20

struct symtab
{
    char *name;
    // ptr to C function to call if this entry is a fucntion name
    double (*funcptr)();
    double value;
} symtab[NSYMS];

struct symtab *symlook();