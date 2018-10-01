package lang;

import lang.ast.*;

class CountIdentifiers extends TraversingVisitor {

  static int currentDepth;
  static int maxDepth;

  static int result(Program root) {
    currentDepth = 0;
    maxDepth = 0;
    root.accept(new CountIdentifiers(), null);
    return maxDepth;
  }

  public Object visit(Function node, Object data) {
    currentDepth++;
    super.visit(node, data);
    if (currentDepth > maxDepth) {
      maxDepth = currentDepth;
    }
    currentDepth--;
    return null;
	}

  public Object visit(IfStmt node, Object data) {
    currentDepth++;
    super.visit(node, data);
    if (currentDepth > maxDepth) {
      maxDepth = currentDepth;
    }
    currentDepth--;
    return null;
	}

  public Object visit(WhileStmt node, Object data) {
    currentDepth++;
    super.visit(node, data);
    if (currentDepth > maxDepth) {
      maxDepth = currentDepth;
    }
    currentDepth--;
    return null;
	}
}
