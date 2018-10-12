package lang;

import java.io.File;
import java.io.PrintStream;
import java.io.ByteArrayOutputStream;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;

import lang.ast.ErrorMessage;
import lang.ast.Program;

/**
 * This is a parameterized test: one test case is generated for each input
 * file found in TEST_DIRECTORY. Input files should have the ".in" extension.
 */
@RunWith(Parameterized.class)
public class TestInterpreter {
	/** Directory where the test input files are stored. */
	private static final File TEST_DIRECTORY = new File("testfiles/staticAnalysis");

	private final String filename;
	public TestInterpreter(String testFile) {
		filename = testFile;
	}

  @Test public void runTest() throws Exception {
    PrintStream out = System.out;
    try {
      Program program = (Program) Util.parse(new File(TEST_DIRECTORY, filename));
      ByteArrayOutputStream baos = new ByteArrayOutputStream();
      System.setOut(new PrintStream(baos));
      program.eval();
      File outFile = new File(TEST_DIRECTORY, Util.changeExtension(filename, ".out"));
      File expectedFile = new File(TEST_DIRECTORY, Util.changeExtension(filename, ".expected"));
      Util.compareOutput(baos.toString(), outFile, expectedFile);
    } finally {
      System.setOut(out);
    }
  }
	@Parameters(name = "{0}")
	public static Iterable<Object[]> getTests() {
		return Util.getTestParameters(TEST_DIRECTORY, ".in");
	}
}
