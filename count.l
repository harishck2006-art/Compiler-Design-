[?1034h[24bcs170@mepcolinux Compiler]$cat count1.l
%{
#include <stdio.h>

int wc = 0;
int cc = 0;
int lc = 0;
%}

%%
[a-zA-Z0-9]+    { wc++; cc += yyleng; }
\n              { lc++; cc++; }
.               { cc++; }
%%

int main()
{
    FILE *fp = fopen("input.txt", "r"); 
    
    if (fp == NULL) {
        fprintf(stderr, "Error: Unable to open input.txt\n");
        return 1;
    }
    
    yyin = fp;
    yylex();
    fclose(fp);

    printf("words = %d\n", wc);
    printf("characters = %d\n", cc);
    printf("lines = %d\n", lc);

    return 0;
}

int yywrap()
{
    return 1;
}

[24bcs170@mepcolinux Compiler]$cat input.txt
Harish Perumal
[24bcs170@mepcolinux Compiler]$lex count1.l
[24bcs170@mepcolinux Compiler]$gcc lex.yy.c 
[24bcs170@mepcolinux Compiler]$./a.out
words = 2
characters = 15
lines = 1
