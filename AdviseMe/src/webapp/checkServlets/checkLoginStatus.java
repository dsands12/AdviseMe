package webapp.checkServlets;

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
public class checkLoginStatus extends HttpServlet{
	static{ObjectifyService.register(User.class);}
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String id = req.getParameter("id");
		try{
			if(id==null||id.isEmpty()){
				throw new Exception("Facebook not returning valid identification. Please relogin.");
			}
			System.out.println("Passed ID was:"+id);
			List<User> users = ofy().load().type(User.class).list();
			Collections.sort(users);
			for(User user: users){
				if(user.getfbUserId().equals(id)){
					Boolean status = user.getLoginStatus();
					resp.setContentType("text/plain");
					resp.setCharacterEncoding("UTF-8");
					resp.getWriter().write(status.toString());
					break;
				}
			}
		} catch(Exception e){
			String logMsg = "Exception in processing request: " + e.getMessage();
			throw new IOException(logMsg);
		}
	}
}
