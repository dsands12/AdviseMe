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

import webapp.datastoreObjects.Course;

import com.googlecode.objectify.ObjectifyService;

@SuppressWarnings("serial")
public class addSubscriberServlet extends HttpServlet{
	static{ObjectifyService.register(Course.class);}
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String email = req.getParameter("email");
		String course = req.getParameter("course");
		try{
			if(email==null||email.isEmpty()){
				throw new Exception("Email was invalid");
			}
			if(course==null||course.isEmpty()){
				throw new Exception("Course was invalid");
			}
			System.out.println("Email passed is:" + email);
			System.out.println("Course passed is:" + course);
			
			
			List<Course> courses = ofy().load().type(Course.class).list();
			Collections.sort(courses);
			//Current issue with this is that it is not linked with the actual courses.
			
		} catch(Exception e){
			String logMsg = "Exception in processing request: " + e.getMessage();
			throw new IOException(logMsg);
		}
	}
}
