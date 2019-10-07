%{
int yylval=0;
char string_table[100];
int i;
int indexd =0;
int yyline=1;
int yycolumn=0;
%}

%%
[\t ]+           { yycolumn += strlen(yytext); }
["(*"][.]*["*)"] { yycolumn += strlen(yytext); }
"(*"[^}\n]*"*)"  { yycolumn += strlen(yytext); }
\n		 { yyline++; yycolumn=0;} 
[a-zA-Z]*[0-9]+[a-zA-Z]+[a-zA-Z0-9]* { 
  printf("Error: incorrect identifier name, line %d column %d, Image: %s \n", yyline, yycolumn+1, yytext);
  yycolumn += strlen(yytext); 
}

EOF              { return 0; }
";"              { yycolumn++; return 1; }
"("              { yycolumn++; return 2; }
")"              { yycolumn++; return 3; }
([1-9][0-9]*)|0  { yycolumn += strlen(yytext); yylval = atoi(yytext); return 4; }
begin            { yycolumn+=5; return 5; }
program          { yycolumn+=7; return 6; }
"-"              { yycolumn++; return 7; }
"*"              { yycolumn++; return 8; }
var              { yycolumn+=3; return 9; }
,                { yycolumn++; return 10; }
end              { yycolumn+=3; return 12; }
is               { yycolumn+=2; return 13; }
"+"              { yycolumn++; return 14; }
"/"              { yycolumn++; return 15; }
print            { yycolumn+=5; return 16; }
"="              { yycolumn++; return 17; }
[a-zA-Z]+[0-9]*  {
  yycolumn += strlen(yytext);
  yylval=indexd;  
  for( i=0 ; i < strlen(yytext) ; i++ ){
    string_table[indexd+i] = yytext[i];
  }
  indexd = i+1 ;
  return 11; }
.               { yycolumn += strlen(yytext); printf("Error: incorrect operation, line %d, column %d, Image: %s \n", yyline, yycolumn, yytext);}

%%
