package lang.ast; // The generated scanner will belong to the package lang.ast

import lang.ast.LangParser.Terminals; // The terminals are implicitly defined in the parser
import lang.ast.LangParser.SyntaxError;

%%

// define the signature for the generated scanner
%public
%final
%class LangScanner
%extends beaver.Scanner

// the interface between the scanner and the parser is the nextToken() method
%type beaver.Symbol
%function nextToken

// store line and column information in the tokens
%line
%column

// this code will be inlined in the body of the generated scanner class
%{
  private beaver.Symbol sym(short id) {
    return new beaver.Symbol(id, yyline + 1, yycolumn + 1, yylength(), yytext());
  }
%}

// macros
WhiteSpace = [ ] | \t | \f | \n | \r
ID = [a-zA-Z0-9]+
INTEGER = [0-9]+
COMMENT = "//".*

%%

// discard whitespace information
{WhiteSpace}  { }
{COMMENT}     { }

// token definitions
"{"           { return sym(Terminals.LBRACKET); }
"}"           { return sym(Terminals.RBRACKET); }
"("           { return sym(Terminals.LPARA); }
")"           { return sym(Terminals.RPARA); }
"<"           { return sym(Terminals.LESSER); }
">"           { return sym(Terminals.GREATER); }
"<="          { return sym(Terminals.LESSEREQUAL); }
">="          { return sym(Terminals.GREATEREQUAL); }
"!="          { return sym(Terminals.NOTEQUAL); }
"=="          { return sym(Terminals.EQUAL); }
"="           { return sym(Terminals.ASSIGN); }
"*"           { return sym(Terminals.MUL); }
"/"           { return sym(Terminals.DIV); }
"%"           { return sym(Terminals.MOD); }
"+"           { return sym(Terminals.PLUS); }
"-"           { return sym(Terminals.MINUS); }
";"           { return sym(Terminals.SEMI); }
","           { return sym(Terminals.COMMA); }
"return"      { return sym(Terminals.RETURN); }
"print"       { return sym(Terminals.PRINT); }
"while"       { return sym(Terminals.WHILE); }
"else"        { return sym(Terminals.ELSE); }
"int"         { return sym(Terminals.INT); }
"if"          { return sym(Terminals.IF); }
{INTEGER}     { return sym(Terminals.INTEGER); }
{ID}          { return sym(Terminals.ID); }
<<EOF>>       { return sym(Terminals.EOF); }

/* error fallback */
[^]           { throw new SyntaxError("Illegal character <"+yytext()+">"); }
