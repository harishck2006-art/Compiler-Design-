[24bcs170@mepcolinux Compiler]$cat html.l
%{
#include <stdio.h>
FILE *outfile;
%}

%%
"<"[^>]*>        { ; }
[^<\n]+          { fprintf(outfile, "%s", yytext); }
\n               { fprintf(outfile, "\n"); }
%%

int main()
{
    FILE *fp = fopen("htmlinput.txt", "r");
    if (fp != NULL)
    {
        yyin = fp;
    }
    
    outfile = fopen("htmloutput.txt", "w");
    
    yylex();
    
    fclose(fp);
    fclose(outfile);
    return 0;
}

int yywrap()
{
    return 1;
}

[24bcs170@mepcolinux Compiler]$cat htmlinput.txt
<h1>Hello World</h1>
<p>This is <b>plain</b> text.</p>

[24bcs170@mepcolinux Compiler]$lec html.l
[24bcs170@mepcolinux Compiler]$gcc lex.yy.c 
[24bcs170@mepcolinux Compiler]$./a.out
[24bcs170@mepcolinux Compiler]$cat htmloutput.txt
Hello World
This is plain text.

