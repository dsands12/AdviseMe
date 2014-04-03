package webapp.checkServlets;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import webapp.datastoreObjects.User;

import com.googlecode.objectify.ObjectifyService;


@SuppressWarnings("serial")
public class createSessionServlet extends HttpServlet{
	static{ObjectifyService.register(User.class);}
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		try{
			String picurl = req.getParameter("picurl");
			String fbid = req.getParameter("id");
			System.out.println("FACEBOOK " + fbid);
			HttpSession session = req.getSession(true);
			List<User> users = ofy().load().type(User.class).list();
			for(User user: users){
				if(user.getfbUserId().equals(fbid)){
					session.setAttribute("first", user.getFirstName());
					session.setAttribute("last", user.getLastName());
					session.setAttribute("pic", picurl);
					session.setAttribute("id", fbid);
					session.setAttribute("isLoggedIn", user.getLoginStatus().toString());
				}
			}
		}catch(Exception e){
			String logMsg = "Exception in processing request: " + e.getMessage();
			throw new IOException(logMsg);
		}
	}
}
