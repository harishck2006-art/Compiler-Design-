%{
#include <stdio.h>
%}

%x TYPE_CONTEXT

%%

(unsigned|signed)?[ \t]*(long|short)?[ \t]*(int|float|char|double) {
    printf("DATA TYPE      : %s\n", yytext);
    BEGIN(TYPE_CONTEXT);
}

void|_Bool {
    printf("DATA TYPE      : %s\n", yytext);
    BEGIN(TYPE_CONTEXT);
}

<TYPE_CONTEXT>[a-zA-Z_][a-zA-Z0-9_]* {
    printf("DECLARED_VARIABLE : %s\n", yytext);
    BEGIN(INITIAL);
}

[a-zA-Z_][a-zA-Z0-9_]* {
    printf("IDENTIFIER     : %s\n", yytext);
}

[;,{}()] {
    printf("PUNCTUATION    : %s\n", yytext);
}

[ \t\n]+ {

}

. {

}

%%

int main(int argc, char *argv[])
{
    FILE *fp = fopen("inputfile.txt", "r");

    if(fp) {
        yyin = fp;
    } else {
        printf("Error: inputfile.txt cannot be open \n");
        return 1;
    }

    yylex();
    fclose(fp);
    return 0;
}

int yywrap()
{
    return 1;
}

[24bcs170@mepcolinux ex2]$lex last.l
[24bcs170@mepcolinux ex2]$gcc lex.yy.c
[24bcs170@mepcolinux ex2]$./a.out
DATA TYPE      : int
 DECLARED_VARIABLE : main
PUNCTUATION    : (
PUNCTUATION    : )
PUNCTUATION    : {
DATA TYPE      : unsigned long int
 DECLARED_VARIABLE : totalCount
PUNCTUATION    : ;
DATA TYPE      : float
 DECLARED_VARIABLE : average_marks
PUNCTUATION    : ;
DATA TYPE      : char
 DECLARED_VARIABLE : grade
PUNCTUATION    : ;
DATA TYPE      : _Bool
 DECLARED_VARIABLE : isValid
PUNCTUATION    : ;
PUNCTUATION    : }
[24bcs170@mepcolinux ex2]$cat inputfile.txt
int main()
{
    unsigned long int totalCount;
    float average_marks;
    char grade;
    _Bool isValid;
}
[24bcs170@mepcolinux ex2]$exit
exit

