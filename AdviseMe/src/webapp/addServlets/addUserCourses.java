package webapp.addServlets;

import webapp.datastoreObjects.Course;
import webapp.datastoreObjects.User;

import com.googlecode.objectify.ObjectifyService;

import java.io.IOException;
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
		for(User user: users){
			if(user.getfbUserId().equals(id)){
				for(int i=0;i<usercourses.length;i+=1){
					Course course = new Course(usercourses[i]);
					user.addUserClass(course);
				}
				resp.sendRedirect("/home.jsp");
			}			
		}
		//TODO: need to send to error page.
		resp.sendRedirect("/error.jsp");
	}
}
