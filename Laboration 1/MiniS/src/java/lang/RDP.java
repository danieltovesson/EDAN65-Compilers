package lang;

public class RDP extends RDPTemplate {
  private int token;

  public void parseProgram() {
    program();
  }

  public void program() {
    statement();
  }

  public void statement() {
    token = peek();
    switch (token) {
      case lang.ast.LangParser.Terminals.FOR:
        forStmt();
        break;
      case lang.ast.LangParser.Terminals.IF:
        ifStmt();
        break;
      case lang.ast.LangParser.Terminals.ID:
        assignment();
        break;
      default:
        error("Expecting statement, found: " + token);
    }
  }

  public void forStmt() {
    accept(lang.ast.LangParser.Terminals.FOR);
    accept(lang.ast.LangParser.Terminals.ID);
    accept(lang.ast.LangParser.Terminals.ASSIGN);
    expr();
    accept(lang.ast.LangParser.Terminals.UNTIL);
    expr();
    accept(lang.ast.LangParser.Terminals.DO);
    statement();
    accept(lang.ast.LangParser.Terminals.OD);
  }

  public void ifStmt() {
    accept(lang.ast.LangParser.Terminals.IF);
    expr();
    accept(lang.ast.LangParser.Terminals.THEN);
    statement();
    accept(lang.ast.LangParser.Terminals.FI);
  }

  public void assignment() {
    accept(lang.ast.LangParser.Terminals.ID);
    accept(lang.ast.LangParser.Terminals.ASSIGN);
    expr();
  }

  public void expr() {
    token = peek();
    switch (token) {
      case lang.ast.LangParser.Terminals.ID:
        accept(lang.ast.LangParser.Terminals.ID);
        break;
      case lang.ast.LangParser.Terminals.NUMERAL:
        accept(lang.ast.LangParser.Terminals.NUMERAL);
        break;
      case lang.ast.LangParser.Terminals.NOT:
        accept(lang.ast.LangParser.Terminals.NOT);
        expr();
        break;
      default:
        error("Expecting statement, found: " + token);
    }
  }
}
