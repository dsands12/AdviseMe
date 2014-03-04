package webapp.addServlets;

import webapp.datastoreObjects.User;

import com.googlecode.objectify.ObjectifyService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Collections;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static com.googlecode.objectify.ObjectifyService.ofy;

@SuppressWarnings("serial")
public class addUserCourses extends HttpServlet{
	static{ObjectifyService.register(User.class);}
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String id = req.getParameter("id");
		String usercourses[] = req.getParameterValues("course");
		if(id==null||id.isEmpty()){
			//TODO: need to send to error page.
			resp.sendRedirect("/error.jsp");
		}
		System.out.println("Id passed is:" + id);
		if(usercourses.length==0){
			//TODO: need to send to error page.
			resp.sendRedirect("/error.jsp");
		}
		for(int i=0;i<usercourses.length;i+=1){
			System.out.println("What was passed: " + usercourses[i]);
		}
		List<User> users = ofy().load().type(User.class).list();
		Collections.sort(users);
		//Current issue with this is that it is not linked with the actual courses.
		ArrayList<String> newCourses = new ArrayList<String>();
		for(int i=0;i<usercourses.length;i+=1){
			newCourses.add(usercourses[i]);
		}
		for(User user: users){
			if(user.getfbUserId().equals(id)){
				ArrayList<String> courseList = user.getUserClassList();
				for(int i=0;i<usercourses.length;i+=1){
					if(courseList.contains(usercourses[i])){
						//do nothing
					}else{
					user.addUserClass(usercourses[i]);
					}
				}
				for(int k=0;k<usercourses.length;k+=1){
					Iterator<String> iterator = courseList.iterator();
					while(iterator.hasNext()){
						String next = iterator.next();
						if(newCourses.contains(next)){
							//do nothing
						}else{
							iterator.remove();
						}
					}
				}
				ofy().save().entity(user).now();
				resp.sendRedirect("/home.jsp");
			}			
		}
		//TODO: need to send to error page.
		resp.sendRedirect("/error.jsp");
	}
}
