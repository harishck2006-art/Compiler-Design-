[24bcs170@mepcolinux ex2]$cat common.l
%{
#include <stdio.h>
#include <string.h>

#define YY_USER_INIT BEGIN(state_1);
%}

%x state_1

%%

<state_1>"-"[0-9]+ {
    printf("UNARY MINUS : %s\n", yytext);
    BEGIN(INITIAL);
}

<state_1>[0-9]+ {
    printf("NUMBER : %s\n", yytext);
    BEGIN(INITIAL);
}

<state_1>[a-zA-Z_][a-zA-Z0-9_]* {
    printf("IDENTIFIER : %s\n", yytext);
    BEGIN(INITIAL);
}

"=" {
    printf("ASSIGNMENT OPERATOR : %s\n", yytext);
    BEGIN(state_1);
}

"(" {
    printf("LEFT PARENTHESIS : %s\n", yytext);
    BEGIN(state_1);
}

")" {
    printf("RIGHT PARENTHESIS : %s\n", yytext);
    BEGIN(INITIAL);
}

"+"|"-"|"*"|"/" {
    if(strcmp(yytext, "-") == 0)
        printf("SUBTRACTION OPERATOR : %s\n", yytext);
    else
        printf("OPERATOR : %s\n", yytext);

    BEGIN(state_1);
}

[0-9]+ {
    printf("NUMBER : %s\n", yytext);
}

[a-zA-Z_][a-zA-Z0-9_]* {
    printf("IDENTIFIER : %s\n", yytext);
}

";" {
    printf("PUNCTUATION : %s\n", yytext);
}

[ \t\n]+      { ; }

.             { ; }

%%

int main()
{
    FILE *fp = fopen("cinput.txt", "r");

    if(fp) {
        yyin = fp;
    } else {
        printf("Error: cinput.txt cannot be open:");
        return 1;
    }

    yylex();
    return 0;
}

int yywrap()
{
    return 1;
}

[24bcs170@mepcolinux ex2]$lex common.l
[24bcs170@mepcolinux ex2]$gcc lex.yy.c
[24bcs170@mepcolinux ex2]$./a.out
IDENTIFIER : a
ASSIGNMENT OPERATOR : =
 UNARY MINUS : -5
OPERATOR : +
 IDENTIFIER : b
PUNCTUATION : ;
[24bcs170@mepcolinux ex2]$cat cinput.txt
a = -5 + b;
