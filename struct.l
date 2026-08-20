[24bcs170@mepcolinux ex2]$cat struct.l
%{
#include <stdio.h>
%}

%x STRUCT_STATE

%%

"struct" {
    printf("KEYWORD : %s\n", yytext);
    BEGIN(STRUCT_STATE);
}

<STRUCT_STATE>[a-zA-Z_][a-zA-Z0-9_]* {
    printf("STRUCT TAG NAME (left context after 'struct') : %s\n", yytext);
    BEGIN(INITIAL);
}

[a-zA-Z_][a-zA-Z0-9_]* {
    printf("IDENTIFIER : %s\n", yytext);
}

";"|","|"{"|"}"|"("|")" {
    printf("PUNCTUATION : %s\n", yytext);
}

[ \t\n]+ {
    ;
}

. {
    ;
}

%%

int main()
{
    FILE *fp = fopen("sinput.txt", "r");

    if(fp) {
        yyin = fp;
    } else {
        printf("Error: sinput.txt cannot be open:");
        return 1;
    }

    yylex();
    return 0;
}

int yywrap()
{
    return 1;
}


[24bcs170@mepcolinux ex2]$lex struct.l
[24bcs170@mepcolinux ex2]$gcc lex.yy.c
[24bcs170@mepcolinux ex2]$./a.out
KEYWORD : struct
 STRUCT TAG NAME (left context after 'struct') : Student
PUNCTUATION : {
IDENTIFIER : int
IDENTIFIER : roll
PUNCTUATION : ;
IDENTIFIER : char
IDENTIFIER : name
PUNCTUATION : ;
PUNCTUATION : }
PUNCTUATION : ;
[24bcs170@mepcolinux ex2]$cat sinput.txt
struct Student {
    int roll;
    char name;
};

