[24bcs170@mepcolinux Compiler]$cat email.l
%{
#include <stdio.h>
FILE *efile;
FILE *ufile;
%}

%%
[a-zA-Z0-9_+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z][a-zA-Z]+ {
    fprintf(efile, "%s\n", yytext);
}
https?:\/\/[a-zA-Z0-9.\/?=_-]+ {
    fprintf(ufile, "%s\n", yytext);
}
.|\n { ; }
%%

int main()
{
    FILE *fp = fopen("extract.txt", "r");
    if (fp != NULL)
    {
        yyin = fp;
    }
    
    efile = fopen("emails.txt", "w");
    ufile = fopen("urls.txt", "w");
    yylex();
    fclose(efile);
    fclose(ufile);
    
    if (fp != NULL)
    {
        fclose(fp);
    }
    return 0;
}

int yywrap()
{
    return 1;
}

[24bcs170@mepcolinux Compiler]$cat extract.txt
my email is test@gmail.com
my website is https://google.com

[24bcs170@mepcolinux Compiler]$cat emails.txt
test@gmail.com
[24bcs170@mepcolinux Compiler]$cat urls.txt
https://google.com
