package lang;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;

import RDP;
import RDP.SyntaxError;
import lang.ast.LangScanner;

public class RecursiveDescentCompiler {
  public static void main(String args[]) {
		if (args.length != 1) {
			System.err.println("You must specify a source file on the command line!");
			System.exit(1);
		}

		try {
			parse(new FileReader(args[0]));
		} catch (FileNotFoundException e) {
			System.err.println(e.getMessage());
		}
  }

  private static void parse(Reader reader) {
    LangScanner scanner = new LangScanner(reader);
		RDP rdp = new RDP();

		try {
			rdp.parse(scanner);
			System.out.println("Valid syntax");
		} catch (SyntaxError | beaver.Parser.Exception e) {
			System.err.println("Syntax error: " + e.getMessage());
		} catch (IOException e) {
			e.printStackTrace();
		}
  }
}
