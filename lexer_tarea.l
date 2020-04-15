%{
  #include <stdio.h>
  #include <string.h>

  void error(char *s);
%}

%option yylineno

letra [a-zA-Z]
digito [0-9]
id #({letra}|{digito})*
entero ({digito})+
real ({digito})*"."({digito})+|({digito})+"."({digito})*

%%

{id}              {printf("ID: %s\n", yytext);}
if|else|while     {printf("Palabras reservadas: %s\n", yytext );}
"+"|"-"|"*"|"/"   {printf("Operador aritmetico: %s\n", yytext );}
">"|"<"|">="|"=<" {printf("Operador relacional: %s\n", yytext );}
"="               {printf("Operador asignacion: %s\n", yytext );}
"&&"|"||"|"!"     {printf("Operador: %s\n", yytext );}
<INITIAL>[ \t\n]+ {/*Ignora los espacios en blanco*/}
<INITIAL>"/*"     {BEGIN(COMENTARIO);}
<INITIAL>.        {error(yytext);}
<COMENTARIO>[^*/] {}
<COMENTARIO>[*/]  {}
<COMENTARIO>"*/"  {BEGIN(INITIAL);}

%%

int yywrap(){
  return 1;
}

void error(char *s){
  printf("Error lexico: $s\n",s);
}

int main(){
  yylex();
}
