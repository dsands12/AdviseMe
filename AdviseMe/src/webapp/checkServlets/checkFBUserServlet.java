package webapp.checkServlets;

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
public class checkFBUserServlet extends HttpServlet{
	static{ObjectifyService.register(User.class);}
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String prospectFbId = req.getParameter("id");
		try{
			if(prospectFbId==null||prospectFbId.isEmpty()){
				throw new Exception("Facebook not returning valid identification. Please relogin.");
			}
			
			System.out.println("Passed id was:" +prospectFbId);
			List<User> users = ofy().load().type(User.class).list();
			Collections.sort(users);
			boolean flag = false;
			for(User user: users){
				if(user.getfbUserId().equals(prospectFbId)){
					//User has already registered.
					//if code reaches here, return true
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
