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
public class changeLoginStatus extends HttpServlet {
	static{ObjectifyService.register(User.class);}
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String id = req.getParameter("id");
		try{
			if(id==null||id.isEmpty()){
				throw new Exception("Facebook not returning valid identification. Please relogin.");

			}
			System.out.println("Passed ID was:" + id);
			List<User> users = ofy().load().type(User.class).list();
			Collections.sort(users);
			boolean flag = false;
			for(User user: users){
				if(user.getfbUserId().equals(id)){
					Boolean status = user.getLoginStatus();
					System.out.println("Old status is:"+status.toString());
					if(status){
						user.setLoginStatus(false);
						ofy().save().entity(user).now();
					}else{
						user.setLoginStatus(true);
						user.resetLoginDate();
						ofy().save().entity(user).now();
					}
					status=user.getLoginStatus();
					System.out.println("New status is:"+status.toString());
					resp.setContentType("text/plain");
					resp.setCharacterEncoding("UTF-8");
					resp.getWriter().write(status.toString());
					flag = true;
					break;
				}
			}
			if(flag){
				//login status was changed
			}else{
				throw new Exception("User account not found in database.");
			}
		} catch(Exception e){
			String logMsg = "Exception in processing request: " + e.getMessage();
			throw new IOException(logMsg);
		}
	}
}
