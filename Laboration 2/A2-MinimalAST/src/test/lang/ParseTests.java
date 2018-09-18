package lang;

import java.io.File;

import org.junit.Test;

public class ParseTests {
	/** Directory where the test input files are stored. */
	private static final File TEST_DIRECTORY = new File("testfiles/parser");

	@Test
	public void doubleReturnType() {
		Util.testSyntaxError(TEST_DIRECTORY, "doubleReturnType.in");
	}

	@Test
	public void noParentheses() {
		Util.testSyntaxError(TEST_DIRECTORY, "noParentheses.in");
	}

	@Test
	public void noBrackets() {
		Util.testSyntaxError(TEST_DIRECTORY, "noBrackets.in");
	}

	@Test
	public void assignWithoutValue() {
		Util.testSyntaxError(TEST_DIRECTORY, "assignWithoutValue.in");
	}
}
