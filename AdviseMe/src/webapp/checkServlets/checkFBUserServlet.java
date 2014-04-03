package webapp.checkServlets;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import webapp.datastoreObjects.User;

import com.googlecode.objectify.ObjectifyService;

@SuppressWarnings("serial")
public class checkFBUserServlet extends HttpServlet{
	static{ObjectifyService.register(User.class);}
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String prospectFbId = req.getParameter("id");
		try{
			if(prospectFbId==null||prospectFbId.isEmpty()){
				throw new Exception("Facebook not returning valid identification. Please relogin.");
			}
			List<User> users = ofy().load().type(User.class).list();
			boolean flag = false;
			for(User user: users){
				if(user.getfbUserId().equals(prospectFbId)){

					System.out.println("Facebook ID: " + prospectFbId + " is an AdviseMe user.");
					resp.setContentType("text/plain");
					resp.setCharacterEncoding("UTF-8");
					resp.getWriter().write("true");
					flag=true;
					break;
				}
			}
			//if code reaches here, then user has not registered before.
			//if code reacher here, return false
			if(!flag){
				System.out.println("Facebook ID: " + prospectFbId + " is not an AdviseMe user.");
				resp.setContentType("text/plain");
				resp.setCharacterEncoding("UTF-8");
				resp.getWriter().write("false");
			}
		} catch(Exception e){
			String logMsg = "Exception in processing request: " + e.getMessage();
			throw new IOException(logMsg);
		}
	}
}
