package webapp.tests;

import static org.junit.Assert.fail;

import javax.servlet.http.HttpServletRequest;

import org.junit.Before;

public class Test {
	@Before
	public void setUp(){
		HttpServletRequest req = new HttpServletRequest();
	}
	
	@org.junit.Test
	public void testDoPostHttpServletRequestHttpServletResponse() {
		fail("Not yet implemented");
	}

}
