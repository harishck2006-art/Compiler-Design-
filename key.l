[24bcs170@mepcolinux ex2]$cat key.l
%{
#include <stdio.h>
%}

%x DECLARATION_STATE

%%

"int"|"float"|"char"|"double" {
    printf("KEYWORD (Data Type) : %s\n", yytext);
    BEGIN(DECLARATION_STATE);
}

"void"|"if"|"else"|"while"|"for"|"return"|"switch"|"case"|"break"   { printf("KEYWORD : %s\n", yytext); }

<DECLARATION_STATE>[a-zA-Z_][a-zA-Z0-9_]* {
    printf("VARIABLE_NAME  : %s\n", yytext);
    BEGIN(INITIAL);
}

[a-zA-Z_][a-zA-Z0-9_]*                                                                            { printf("IDENTIFIER : %s\n", yytext); }

"+"|"-"|"*"|"/"|"="|"=="|"<"|">"|"<="|">="|"!="|"&&"|"||"                                         { printf("OPERATOR : %s\n", yytext); }

[0-9]+                                                                                            { printf("INT CONSTANT : %s\n", yytext); }

[0-9]*\.[0-9]+                                                                                    { printf("FLOAT CONSTANT : %s\n", yytext); }

";"|","|"{"|"}"|"("|")"|"["|"]"                                                                   { printf("PUNCTUATION : %s\n", yytext); }

[ \t\n]+                                                                                          { ; }

.                                                                                                 { ; }

%%

int main()
{
    FILE *fp = fopen("kinput.txt", "r");

    if(fp)
    {
        yyin = fp;
        yylex();
        fclose(fp);
    }
    else
    {
        printf("Error: kinput.txt cannot be open.\n");
    }

    return 0;
}

int yywrap()
{
    return 1;
}

[24bcs170@mepcolinux ex2]$lex key.l
[24bcs170@mepcolinux ex2]$gcc lex.yy.c
[24bcs170@mepcolinux ex2]$./a.out
KEYWORD (Data Type) : int
 VARIABLE_NAME  : main
PUNCTUATION : (
PUNCTUATION : )
PUNCTUATION : {
KEYWORD (Data Type) : float
 VARIABLE_NAME  : total
OPERATOR : =
FLOAT CONSTANT : 10.5
PUNCTUATION : ;
KEYWORD (Data Type) : int
 VARIABLE_NAME  : count
OPERATOR : =
INT CONSTANT : 5
PUNCTUATION : ;
KEYWORD : if
PUNCTUATION : (
IDENTIFIER : count
OPERATOR : >
INT CONSTANT : 0
PUNCTUATION : )
PUNCTUATION : {
KEYWORD : return
INT CONSTANT : 1
PUNCTUATION : ;
PUNCTUATION : }
KEYWORD : else
PUNCTUATION : {
KEYWORD : return
INT CONSTANT : 0
PUNCTUATION : ;
PUNCTUATION : }
PUNCTUATION : }
[24bcs170@mepcolinux ex2]$cat kinput.txt
int main() {
    float total = 10.5;
    int count = 5;
    if (count > 0) {
        return 1;
    }
    else {
        return 0;
    }
}
