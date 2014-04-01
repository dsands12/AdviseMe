package webapp.removeServlets;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import webapp.datastoreObjects.User;

import com.googlecode.objectify.ObjectifyService;

@SuppressWarnings("serial")
public class deleteFBUserServlet extends HttpServlet{
	static{ObjectifyService.register(User.class);}
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String fbId = req.getParameter("id");
		try{
			if(fbId==null||fbId.isEmpty()){
				throw new Exception("Facebook not returning valid identification. Please relogin.");
			}
			System.out.println("Passed id was" + fbId);
			List<User> users = ofy().load().type(User.class).list();
			Collections.sort(users);
			for(User user: users){
				if(user.getfbUserId().equals(fbId)){
					ofy().delete().entity(user).now();
					resp.sendRedirect("/home.jsp");
				}
			}
			throw new Exception("User account not found in database.");
		} catch(Exception e){
			String logMsg = "Exception in processing request: " + e.getMessage();
			throw new IOException(logMsg);
		}
	}
}
