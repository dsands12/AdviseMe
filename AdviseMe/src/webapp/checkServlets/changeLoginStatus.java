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
public class changeLoginStatus extends HttpServlet {
	static{ObjectifyService.register(User.class);}
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String id = req.getParameter("id");
		System.out.println("Passed ID was:" + id);
		List<User> users = ofy().load().type(User.class).list();
		Collections.sort(users);
		for(User user: users){
			if(user.getfbUserId().equals(id)){
				Boolean status = user.getLoginStatus();
				System.out.println("Old status is:"+status.toString());
				if(status){
					user.setLoginStatus(false);
					ofy().save().entity(user).now();
				}else{
					user.setLoginStatus(true);
					ofy().save().entity(user).now();
				}
				status=user.getLoginStatus();
				System.out.println("New status is:"+status.toString());
				resp.setContentType("text/plain");
				resp.setCharacterEncoding("UTF-8");
				resp.getWriter().write(status.toString());
				break;
			}
		}
		//if code reaches here, then invalid id was passed.
		
		//TODO: Redirect to error page
	}
}
