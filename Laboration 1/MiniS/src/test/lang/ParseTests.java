package lang;

import org.junit.Test;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.PrintStream;

import static org.junit.Assert.fail;

public class ParseTests {
	/** Directory where the test input files are stored. */
	private static final File TEST_DIRECTORY = new File("testfiles");

	@Test public void exampleprogramTest() {
		Util.testValidSyntax(TEST_DIRECTORY, "exampleprogram.in");
	}

	@Test public void assignmentTest() {
		Util.testValidSyntax(TEST_DIRECTORY, "assignment.in");
	}

	@Test public void forTest() {
		Util.testValidSyntax(TEST_DIRECTORY, "for.in");
	}

	@Test public void ifTest() {
		Util.testValidSyntax(TEST_DIRECTORY, "if.in");
	}

	@Test public void error() {
		Util.testSyntaxError(TEST_DIRECTORY, "error.in");
	}
}
