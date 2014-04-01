package webapp.addServlets;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import webapp.datastoreObjects.User;

import com.googlecode.objectify.ObjectifyService;

@SuppressWarnings("serial")
public class addUserCourses extends HttpServlet{
	static{ObjectifyService.register(User.class);}
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String id = req.getParameter("id");
		String usercourses[] = req.getParameterValues("course");
		try{
			if(id==null||id.isEmpty()){
				throw new Exception("Facebook not returning valid identification. Please relogin.");
			}
			System.out.println("Id passed is:" + id);
			if(usercourses.length==0){
				throw new Exception("No courses selected. Please select a course(s).");
			}
			List<User> users = ofy().load().type(User.class).list();
			ArrayList<String> newCourses = new ArrayList<String>();
			for(int i=0;i<usercourses.length;i+=1){
				newCourses.add(usercourses[i]);
			}
			for(User user: users){
				if(user.getfbUserId().equals(id)){
					ArrayList<String> courseList = user.getUserClassList();
					for(int i=0;i<usercourses.length;i+=1){
						if(!courseList.contains(usercourses[i])){
							user.addUserClass(usercourses[i]);
						}
					}
					for(int k=0;k<usercourses.length;k+=1){
						Iterator<String> iterator = courseList.iterator();
						while(iterator.hasNext()){
							String next = iterator.next();
							if(!newCourses.contains(next)){
								iterator.remove();
							}
						}
					}
					ofy().save().entity(user).now();
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
