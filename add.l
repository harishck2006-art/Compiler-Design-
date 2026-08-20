[24bcs170@mepcolinux Compiler]$cat add.l
%{
#include <stdio.h>
#include <stdlib.h>
FILE *out;
%}

%%
[0-9]+\.[0-9]+ {
    float fnum;
    fnum = atof(yytext);
    fnum = fnum + 0.5;
    printf("%f", fnum);
    fprintf(out, "%f", fnum);
}

[0-9]+ {
    int num;
    num = atoi(yytext);
    num = num + 1;
    printf("%d", num);
    fprintf(out, "%d", num);
}

.|\n {
    printf("%s", yytext);
    fprintf(out, "%s", yytext);
}
%%

int main()
{
    FILE *fp = fopen("numinput.txt", "r");
    if (fp != NULL)
    {
        yyin = fp;
    }
    else
    {
        printf("Error: Unable to open input file 'numinput.txt'.\n");
        return 1;
    }
    
    out = fopen("intfloatoutput.txt", "w");
    if (out == NULL)
    {
        printf("Error: Unable to create output file 'intfloatoutput.txt'.\n");
        fclose(fp);
        return 1;
    }
    
    yylex();
    
    fclose(fp);
    fclose(out);
    return 0;
}

int yywrap()
{
    return 1;
}

[24bcs170@mepcolinux Compiler]$cat numinput.txt
Product ID: 104
Base Price: 45.20
Tax Code: 12
Shipping Cost: 6.30
Total items in stock: 85

[24bcs170@mepcolinux Compiler]$lex add.l
[24bcs170@mepcolinux Compiler]$gcc lex.yy.c 
[24bcs170@mepcolinux Compiler]$./a.out
Product ID: 105
Base Price: 45.700001
Tax Code: 13
Shipping Cost: 6.800000
Total items in stock: 86

