package webapp.addServlets;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import webapp.datastoreObjects.Course;

import com.googlecode.objectify.ObjectifyService;

@SuppressWarnings("serial")
public class addSubscriberServlet extends HttpServlet{
	static{ObjectifyService.register(Course.class);}
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String email = req.getParameter("email");
		String courseName = req.getParameter("course");
		try{
			if(email==null||email.isEmpty()){
				throw new Exception("Email was invalid");
			}
			if(courseName==null||courseName.isEmpty()){
				throw new Exception("Course was invalid");
			}
			System.out.println("Email passed is:" + email);
			System.out.println("Course passed is:" + courseName);
			
			
			List<Course> courses = ofy().load().type(Course.class).list();
			for(Course course: courses){
				if(course.getCourseName().equals(courseName)){
					System.out.println("Adding " + email + " to " + courseName);
					if(course.getSubscribers()==null){
						course.setSubscribers(new ArrayList<String>());
					}
					course.getSubscribers().add(email);
					ofy().save().entity(course).now();
					break;
				}
			}
			resp.setContentType("text/plain");
			resp.setCharacterEncoding("UTF-8");
			resp.getWriter().write("true");
		} catch(Exception e){
			String logMsg = "Exception in processing request: " + e.getMessage();
			throw new IOException(logMsg);
		}
	}
}
