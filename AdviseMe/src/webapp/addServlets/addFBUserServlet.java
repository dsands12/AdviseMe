package webapp.addServlets;

import webapp.datastoreObjects.User;

import com.googlecode.objectify.ObjectifyService;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static com.googlecode.objectify.ObjectifyService.ofy;

@SuppressWarnings("serial")
public class addFBUserServlet extends HttpServlet{
	static{ObjectifyService.register(User.class);}
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String FBId = req.getParameter("id");
		String FBFirst = req.getParameter("firstname");
		String FBLast = req.getParameter("lastname");
		String FBEmail = req.getParameter("email");
		User user;
		if(FBEmail==null){
			user = new User(FBId,FBFirst,FBLast);
		}else{
			user = new User(FBId,FBFirst,FBLast,FBEmail);
		}
		ofy().save().entity(user).now();
		resp.sendRedirect("/home.jsp");
	}
}
