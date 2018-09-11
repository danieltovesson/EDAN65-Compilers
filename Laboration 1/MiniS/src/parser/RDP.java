abstract class RDP extends RDPTemplate {
  private int token;

  public void parseProgram() {
    program();
  }

  public void program() {
    statement();
  }

  public void statement() {
    token = peek()
    switch (token) {
      case LangParser.Terminals.FOR:
        forStmt();
        break;
      case LangParser.Terminals.IF:
        ifStmt();
        break;
      case LangParser.Terminals.ID:
        assignment()
        break;
      default:
        error("Expecting statement, found: " + token);
    }
  }

  public void forStmt() {
    accept(LangParser.Terminals.FOR);
    accept(LangParser.Terminals.ID);
    accept(LangParser.Terminal.ASSIGN);
    expr();
    accept(LangParser.Terminal.UNTIL);
    expr();
    accept(LangParser.Terminal.DO);
    statement();
    accept(LangParser.Terminal.OD);
  }

  public void ifStmt() {
    accept(LangParser.Terminal.IF);
    expr();
    accept(LangParser.Terminal.THEN);
    statement();
    accept(LangParser.Terminal.FI);
  }

  public void assignment() {
    accept(LangParser.Terminal.ID);
    accept(LangParser.Terminal.ASSIGN);
    expr();
  }

  public void expr() {
    token = peek()
    switch (token) {
      case LangParser.Terminals.ID:
        accept(LangParser.Terminal.ID);
        break;
      case LangParser.Terminals.NUMERAL:
        accept(LangParser.Terminal.NUMERAL);
        break;
      case LangParser.Terminals.NOT:
        accept(LangParser.Terminal.NOT);
        expr();
        break;
      default:
        error("Expecting statement, found: " + token);
    }
  }
}
