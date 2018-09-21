package lang;

import lang.ast.*;

class CountIdentifiers extends TraversingVisitor {

  static int count = 0;
  static int result(Program root){
    root.accept(new CountIdentifiers(), null);
    return count;
  }

  public Object visit(IfStmt node, Object data) {
	   count++;
     return null;
	}

  public Object visit(WhileStmt node, Object data) {
	   count++;
     return null;
	}
}
