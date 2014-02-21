package webapp.addServlets;

import webapp.datastoreObjects.*;

import com.googlecode.objectify.ObjectifyService;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static com.googlecode.objectify.ObjectifyService.ofy;

@SuppressWarnings("serial")
public class addUserServlet extends HttpServlet{
	static{ObjectifyService.register(User.class);}
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		
		}
	}

