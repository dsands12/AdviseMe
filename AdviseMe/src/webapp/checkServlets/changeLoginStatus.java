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
public class changeLoginStatus extends HttpServlet {
	static{ObjectifyService.register(User.class);}
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String id = req.getParameter("id");
		try{
			if(id==null||id.isEmpty()){
				throw new Exception("Facebook not returning valid identification. Please relogin.");

			}
			List<User> users = ofy().load().type(User.class).list();
			boolean flag = false;
			for(User user: users){
				if(user.getfbUserId().equals(id)){
					Boolean status = user.getLoginStatus();
					if(status){
						user.setLoginStatus(false);
						System.out.println("User: "+ id +" has logged out.");
						ofy().save().entity(user).now();
					}else{
						user.setLoginStatus(true);
						System.out.println("User: "+ id +" has logged in.");
						user.resetLoginDate();
						ofy().save().entity(user).now();
					}
					status=user.getLoginStatus();
					resp.setContentType("text/plain");
					resp.setCharacterEncoding("UTF-8");
					resp.getWriter().write(status.toString());
					flag = true;
					break;
				}
			}
			if(!flag){
				throw new Exception("User account not found in database.");
			}
		} catch(Exception e){
			String logMsg = "Exception in processing request: " + e.getMessage();
			throw new IOException(logMsg);
		}
	}
}
