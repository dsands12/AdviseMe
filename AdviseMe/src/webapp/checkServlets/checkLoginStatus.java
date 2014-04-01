package webapp.checkServlets;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.Date;



import webapp.datastoreObjects.User;


import com.googlecode.objectify.ObjectifyService;


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
					if(status==true){
						Date current = new Date();
						Date temp = user.getLoginDate();
						System.out.println("Last Login : " +temp);
						long diff = current.getTime() - temp.getTime();
						long diffHours = diff / (60 * 60 * 1000) % 24;
						long diffDays = diff / (24 * 60 * 60 * 1000);
						long diffSeconds = diff / 1000 % 60;
						long diffMinutes = diff / (60 * 1000) % 60;
						System.out.println("Interval :" + diffDays + " Days, " + diffHours + " Hours, "+ diffMinutes + " Min, "+ diffSeconds + " Seconds.");
						if(diffHours>=1){
							user.setLoginStatus(false);
							status=false;
							ofy().save().entity(user).now();
						}else{
							user.resetLoginDate();
							ofy().save().entity(user).now();
						}
					}
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
