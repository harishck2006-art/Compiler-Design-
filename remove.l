[24bcs170@mepcolinux Compiler]$cat remove.l
%{
#include <stdio.h>
FILE *outfile;
%}

%%
"/*"([^*]|\*+[^*/])*\*+"/"    { ; }
[ \t\n\r]+                    { ; }
.                             { fprintf(outfile, "%c", yytext[0]); printf("%c", yytext[0]); }
%%

int main()
{
    FILE *fp = fopen("harish.txt", "r");
    if (fp != NULL)
    {
        yyin = fp;
    }
    else
    {
        fprintf(stderr, "Error: Unable to open input file 'harish.txt'\n");
        return 1;
    }

    outfile = fopen("harish_output.txt", "w");
    if (outfile == NULL)
    {
        fprintf(stderr, "Error: Unable to create output file 'harish_output.txt'\n");
        fclose(fp);
        return 1;
    }

    yylex();
    
    fclose(fp);
    fclose(outfile);
    return 0;
}

int yywrap()
{
    return 1;
}

[24bcs170@mepcolinux Compiler]$lex remove.l
[24bcs170@mepcolinux Compiler]$gcc lex.yy.c 
[24bcs170@mepcolinux Compiler]$./a.out
#include<stdio.h>intmain(){inta=10;printf("Value:%d",a);return0;}[24bcs170@mepcolinux Compiler]$cat harish.txt
#include <stdio.h>

int main() {
    /* This is a multi-line comment 
       that must be removed */
    int a = 10;
    
    /* Checking values */
    printf("Value: %d", a);
    return 0;
}

