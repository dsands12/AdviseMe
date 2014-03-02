package webapp.removeServlets;

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
public class deleteFBUserServlet extends HttpServlet{
	static{ObjectifyService.register(User.class);}
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String fbId = req.getParameter("id");
		System.out.println("Passed id was" + fbId);
		List<User> users = ofy().load().type(User.class).list();
		Collections.sort(users);
		boolean flag = false;
		for(User user: users){
			if(user.getfbUserId().equals(fbId)){
				ofy().delete().entity(user).now();
				break;
			}
		}
		//if code reached here, then user was never registered
		resp.sendRedirect("/error.jsp");
		
	}

}
