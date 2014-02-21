package webapp.addServlets;

import webapp.datastoreObjects.User;

import com.googlecode.objectify.ObjectifyService;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static com.googlecode.objectify.ObjectifyService.ofy;

@SuppressWarnings("serial")
public class checkFBUserServlet extends HttpServlet{
	static{ObjectifyService.register(User.class);}
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String prospectFbId = req.getParameter("id");
		List<User> users = ObjectifyService.ofy().load().type(User.class).list();
		Collections.sort(users);
		for(User user: users){
			if(user.getfbUserId().equalsIgnoreCase(prospectFbId)){
				//User has already registered.
				//need to figure out some way to make that known.
				resp.sendRedirect("/home.jsp");
			}
		}
		//if code reaches here, then user has not registered before.
		//should redirect to addnewuser.jsp.
		resp.sendRedirect("/addnewfacebookuser.jsp");
	}

}
